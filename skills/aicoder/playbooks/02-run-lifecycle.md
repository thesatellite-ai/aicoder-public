# 02 — Run lifecycle: how an agent works a single task

Zoom into Phase 4 of `01-spec-to-ship.md`. This is the inner loop you'll do many times.

## State machine

```
                     ┌─────────────┐
                     │ start       │  startRun
                     │ outcome:    │  → outcome=in_progress
                     │ in_progress │  → task.status auto → in_progress
                     └──────┬──────┘
                            │
                  setRunPlan│
                            ▼
                     ┌─────────────┐
                     │ steps       │  one of:
                     │ pending →   │   completeStep    (continue)
                     │ running →   │   skipStep        (continue)
                     │ completed/ │    failStep        (continue, but flag)
                     │ skipped/   │    blockStep       (pause; pair w/ Gate)
                     │ failed/    │
                     │ blocked    │
                     └──────┬──────┘
                            │
                            │ all steps terminal?
                            ▼
              ┌─────────────────────────────┐
              │ finishRun                   │
              │ outcome ∈ {success, fail,   │
              │   cancelled, timeout,       │
              │   output_invalid,           │
              │   quota_exceeded}           │
              └──────┬──────────────────────┘
                     │
       ┌─────────────┴───────────────┐
       │ success                      │ fail / timeout / output_invalid
       ▼                              ▼
  task.requiresReview?          task.status → blocked
   ├─ yes → status:                   │
   │       awaiting_review            ▼
   │       (postReview gate)     (User triages,
   └─ no  → status: done          may retry)
```

## The contract: plan before you act

The single most important thing about runs: **call `setRunPlan` BEFORE executing the work**. The watcher (human or another agent) sees the live checklist on `/t/<task>` and `/p/<plan>`. Without a plan, the run is opaque until you `finish` — which kills the value of the system.

```bash
TASK=tsk_…

# 1. Start
RUN=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id attempt } }' \
  '{"i":{"taskID":"'$TASK'","agentID":"'$AGENT'","model":"claude-opus-4-7"}}' \
  | jq -r '.data.startRun.id')

# 2. PLAN FIRST. 3–8 verb-first steps, each with a one-line rationale.
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){ setRunPlan(runID:$id, summary:$s, steps:$st){ id } }' '{
  "id":"'$RUN'",
  "s":"Wire jwtauth.New() into apidash.Boot middleware chain. Position: after ratelimit, before metrics.",
  "st":[
    {"title":"read apidash/Boot/auth.go",          "rationale":"current chain order","position":1},
    {"title":"add jwtauth import + constructor",   "rationale":"secret from env","position":2},
    {"title":"reorder middleware chain",           "rationale":"ratelimit→jwtauth→metrics→routes","position":3},
    {"title":"add chain-order assertion test",     "rationale":"prevent future reorders breaking ratelimit","position":4},
    {"title":"task test",                          "rationale":"verify nothing regresses","position":5}
  ]
}'

# 3. Get the step IDs in order
STEPS=$(gql '{ runSteps(first:20, where:{runID:"'$RUN'"}, orderBy:{field:POSITION, direction:ASC}){
  edges { node { id position title } }
}}')
```

## Walking the steps

For each step, three transitions: start → (work happens) → terminal state.

```bash
# Pseudocode loop:
for STEP_ID in $(echo "$STEPS" | jq -r '.data.runSteps.edges[].node.id'); do
  gql 'mutation { startStep(stepID:"'$STEP_ID'"){ id status } }' >/dev/null
  # ... agent does the actual work for this step here ...
  # On success:
  gql 'mutation { completeStep(stepID:"'$STEP_ID'", notes:"<what got done>", output:{<structured output>}) { id } }' >/dev/null
done
```

Pick the right terminal state:

| State | When | Run continues? |
|---|---|---|
| `completeStep` | step succeeded | yes |
| `skipStep(reason)` | step turned out unnecessary | yes |
| `failStep(errorMessage)` | step hit an error you couldn't recover from | yes (next steps still run) |
| `blockStep(reason)` | step needs human input — pair with `requestGate` | NO until gate decided |

**Important:** `failStep` does NOT abort the run. The agent decides whether to continue downstream steps or call `finishRun(outcome:"fail")` immediately. Most of the time you stop on first fail — but for cleanup steps (like "revert"), you may want to keep going.

## Capturing decisions during a step

When step 3 ("reorder middleware chain") reveals an unexpected dependency:

```bash
gql 'mutation($i:CreateDecisionInput!){ createDecision(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "taskID":"'$TASK'",
    "runID":"'$RUN'",
    "kind":"choice",
    "title":"Place jwtauth after ratelimit",
    "context":"Initially planned ratelimit→jwtauth, but found ratelimit reads auth context for per-user limits. Putting jwtauth first would lose user context for ratelimit decisions.",
    "decision":"Order: ratelimit → jwtauth → metrics → routes. Ratelimit operates on raw IP for unauthed; jwtauth fills user context; ratelimit upgrades on next request.",
    "alternatives":[
      "jwtauth first (breaks ratelimit user context)",
      "jwtauth last (auth errors not ratelimited)",
      "Refactor ratelimit to be auth-agnostic (out of scope for P1)"
    ],
    "consequences":"Ratelimit IP rules effectively bypassed for authed users — acceptable per discussion. Document in lace/jwtauth/README. Add chain-order test."
  }
}'
```

This decision now appears:
- On the Run's "Decisions" rail
- On the Task's "Knowledge" section
- On the Plan's "Decisions" rail
- As a backlink on the Spec if its body mentions `[…](/d/dec_…)` or vice versa

## Capturing memories during a step

Memories tend to be saved at run-end (postmortem), but for **incidents discovered mid-run** you record immediately so you don't forget:

```bash
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "tag":"incident",
    "title":"Ratelimit middleware silently depends on auth context",
    "body":"Discovered while reordering Boot chain. Ratelimit reads `ctx.Value(authKey)` to apply per-user limits. If jwtauth runs after ratelimit, all authed requests share the IP-based limit pool.\n\nNo runtime error — just degraded enforcement. Documented in lace/jwtauth/README.md.",
    "sourceTaskID":"'$TASK'",
    "sourceRunID":"'$RUN'"
  }
}'
```

## Finishing the run

```bash
# Success path
gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id outcome } }' '{
  "i":{
    "runID":"'$RUN'",
    "outcome":"success",
    "summary":"Wired jwtauth.New() into Boot. Order: ratelimit→jwtauth→metrics→routes. Added chain-order test (auth_test.go). Discovered + documented ratelimit auth-context dep. PR #142.",
    "approach":"Inserted via 5-step plan. Step 3 caught the ratelimit dep — adjusted order, captured decision dec_…",
    "reasoning":"The auth-before-metrics ordering matters for observability (metrics tag by user). The ratelimit-first ordering matters for unauthed throttling.",
    "confidence":"high",
    "model":"claude-opus-4-7",
    "tokensIn":18420,
    "tokensOut":4250,
    "costUsd":0.61,
    "durationMs":248000,
    "gitCommitSha":"a1b2c3d",
    "gitFiles":["apidash/Boot/auth.go","apidash/Boot/auth_test.go","lace/jwtauth/README.md"]
  }
}'
```

```bash
# Failure path
gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id outcome } }' '{
  "i":{
    "runID":"'$RUN'",
    "outcome":"fail",
    "errorKind":"build",
    "errorMessage":"task test fails: TestAuthChainOrder — ratelimit context lost after jwtauth.\n\nstacktrace:\n  …",
    "summary":"Made the chain change but tests fail. Suspect we need to thread the request context manually through jwtauth.New(). Need investigation; raised question on the spec.",
    "unresolved":{"question":"Does jwtauth.New() preserve incoming context.Context? Or do we need a wrapper?"},
    "tokensIn":12200,
    "tokensOut":2400,
    "costUsd":0.38,
    "durationMs":94000
  }
}'
# Task auto → blocked. Review may be required (depends on task.requiresReview).
```

## After finish

| Outcome | What happens |
|---|---|
| `success` + task.requiresReview=true | task → `awaiting_review`. Wait for `postReview`. |
| `success` + task.requiresReview=false | task → `done` automatically. |
| `fail` | task → `blocked`. blockedReason set from errorMessage. |
| `cancelled` (Gate rejected, user aborted) | task stays at current status; run is just abandoned. |
| `timeout` / `quota_exceeded` | task → `blocked`. |
| `output_invalid` | task → `blocked`. The reviewer flagged structured output not matching schema. |

## Multiple runs per task

Tasks can have many runs — each is one *attempt*. After a fail or rejected review, you start a fresh run:

```bash
RUN_2=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id attempt } }' \
  '{"i":{"taskID":"'$TASK'","agentID":"'$AGENT'"}}' \
  | jq -r '.data.startRun.id')
# attempt is auto-incremented (1, 2, 3, ...)
```

The Web UI's task detail page shows all runs as a stacked feed — runs from oldest to newest, each with its own checklist + summary + cost.

## Linking runs across attempts

Best practice: when retrying after a fail, the new run's `setRunPlan` summary should reference the prior run's failure:

```bash
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){ setRunPlan(runID:$id,summary:$s,steps:$st){id} }' '{
  "id":"'$RUN_2'",
  "s":"Retry of run_…(failed). Previous failure: ratelimit context lost. New approach: thread request ctx through jwtauth via Wrap() helper instead of New().",
  "st":[…]
}'
```
