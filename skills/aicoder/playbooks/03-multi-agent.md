# 03 — Multi-agent collaboration

Different agents specialize. The system handles the handoff.

## The role split

```
        Planner Agent              Executor Agent           Reviewer Agent
        (claude-opus,              (claude-sonnet,          (claude-opus,
         high reasoning)            cost-efficient)          critical eye)

       ┌──────────────┐            ┌──────────────┐         ┌──────────────┐
       │ scope        │            │ run on task  │         │ verify run   │
       │ create Spec  │ ──draft──▶ │ start/plan/  │ ──fini▶ │ postReview   │
       │ create Plan  │            │ steps/finish │         │ verdict      │
       │ break tasks  │            │ capture decs │         │ flag memory  │
       └──────────────┘            └──────────────┘         └──────────────┘
              │                            │                        │
              │                            │                        │
              ▼                            ▼                        ▼
                        ╔═══════════════════════════════╗
                        ║       SHARED GROUND           ║
                        ║                               ║
                        ║   Spec / Plan / Tasks         ║
                        ║   Decisions / Memories        ║
                        ║   Activity log                ║
                        ║                               ║
                        ║  (Each agent reads what       ║
                        ║   others wrote.)              ║
                        ╚═══════════════════════════════╝
```

The system is the **shared blackboard**. Agents don't message each other directly — they write to and read from the entity graph.

## Pattern 1: Sequential handoff (planner → executor → reviewer)

### Planner

```bash
# (claude-opus session)
SPEC=$(gql 'mutation($i:CreateSpecInput!){ createSpec(input:$i){ id } }' '...' | jq -r '.data.createSpec.id')
PLAN=$(gql 'mutation($i:CreatePlanInput!){ createPlan(input:$i){ id } }' '...' | jq -r '.data.createPlan.id')

# Create tasks. Mark them as requiring review after run.
for ...; do
  TASK=$(gql 'mutation($i:CreateTaskInput!){ createTask(input:$i){ id } }' '{
    "i":{
      "projectID":"'$PROJECT'",
      "title":"...",
      "requiresReview":true,
      "createdByUserID":"'$AGENT_PLANNER'"
    }
  }' | jq -r '.data.createTask.id')
  gql 'mutation { addTaskToPlan(planID:"'$PLAN'", taskID:"'$TASK'") }'
done

# Mark plan ready for human approval. STOP.
gql 'mutation { requestPlanReview(runID:"...") }'    # if it was a run-driven plan
# OR just exit and tell the user: "Plan ready. Approve at /p/$PLAN"
```

### Executor (separate session, may be a different model)

```bash
# (claude-sonnet session — cheaper)
# Pre-flight: only operate on approved plans
PLAN_STATUS=$(gql '{ plans(first:1, where:{id:"'$PLAN'"}){edges{node{status}}} }' \
  | jq -r '.data.plans.edges[0].node.status')
[ "$PLAN_STATUS" != "approved" ] && [ "$PLAN_STATUS" != "active" ] && { echo "plan $PLAN_STATUS"; exit; }

# Activate the plan if still approved (status=approved → status=active)
[ "$PLAN_STATUS" = "approved" ] && gql 'mutation { activatePlan(id:"'$PLAN'"){ id } }'

# Pull next task assigned to me / unassigned
TASK=$(gql '{ tasks(first:1, where:{
  projectID:"'$PROJECT'", statusIn:["todo"],
  or:[{assigneeAgentID:"'$AGENT_EXECUTOR'"},{assigneeAgentIDIsNil:true}]
}, orderBy:{field:PRIORITY, direction:DESC}){ edges { node { id } } } }' \
  | jq -r '.data.tasks.edges[0].node.id')

# Run it (see 02-run-lifecycle.md for the full cycle)
# After successful finish, since requiresReview=true, task → awaiting_review
```

### Reviewer (yet another session)

```bash
# (claude-opus session — careful eye)
# Find tasks awaiting review
gql '{
  tasks(first:10, where:{projectID:"'$PROJECT'", status:"awaiting_review"}){
    edges { node { id title } }
  }
}'

# For each, fetch the latest successful run
RUN=$(gql '{
  runs(first:1, where:{taskID:"'$TASK'", outcome:"success"}, orderBy:{field:CREATED_AT, direction:DESC}){
    edges { node { id summary approach reasoning gitFiles gitCommitSha } }
  }
}' | jq '.data.runs.edges[0].node')

# Review the run output (read git diff, run tests, etc.)
# Decide:

# Approve
gql 'mutation($i:PostReviewInput!){ postReview(input:$i){ id verdict } }' '{
  "i":{
    "taskID":"'$TASK'",
    "runID":"'$RUN_ID'",
    "scope":"run_output",
    "verdict":"approve",
    "reviewerAgentID":"'$AGENT_REVIEWER'",
    "feedback":"LGTM. Test coverage solid. Decision dec_… correctly captures the trade-off."
  }
}'
# task → done

# Or request changes
gql 'mutation($i:PostReviewInput!){ postReview(input:$i){ id } }' '{
  "i":{
    "taskID":"'$TASK'",
    "runID":"'$RUN_ID'",
    "scope":"run_output",
    "verdict":"request_changes",
    "reviewerAgentID":"'$AGENT_REVIEWER'",
    "feedback":"Missing chain-order assertion test. Add per dec_… consequences. Tests should fail if jwtauth moves before ratelimit."
  }
}'
# task → todo. Executor agent picks up again, fixes, re-runs.
```

## Pattern 2: Parallel agents on independent tasks

Plan has 6 tasks, no dependencies. Spin up multiple executor sessions:

```bash
# In session A:
TASK_A=$(claim-next-task agentID=agt_executor_a)
run-task $TASK_A   # see 02-run-lifecycle.md

# In session B (parallel):
TASK_B=$(claim-next-task agentID=agt_executor_b)
run-task $TASK_B
```

`assignTask` is the lock — once an agent claims, others won't pick the same task (filter `assigneeAgentIDIsNil:true OR assigneeAgentID:<self>` in the next-task query).

For tasks WITH dependencies, model them via TaskLinks:

```bash
# Task B blocks on Task A finishing
gql 'mutation { addTaskLink(taskID:"'$TASK_B'", targetTaskID:"'$TASK_A'", kind:blocked_by) { id } }'

# Then in the executor's next-task query, filter out tasks with open blockers:
gql '{
  tasks(first:1, where:{
    projectID:"'$PROJECT'", statusIn:["todo"],
    not:{ hasBlockedByWith:{ statusNotIn:["done","cancelled"] } }
  }){ edges { node { id } } }
}'
```

## Pattern 3: Brainstorm session (multi-agent ideation)

User wants to explore options before committing. Use Decision(kind=brainstorm) — these are speculative; multiple can exist for the same question.

```bash
# Agent A proposes option 1
DEC_A=$(gql 'mutation($i:CreateDecisionInput!){ createDecision(input:$i){id} }' '{
  "i":{
    "projectID":"'$PROJECT'", "specID":"'$SPEC'",
    "kind":"brainstorm",
    "title":"Option A: HS256 with env-rotated secret",
    "context":"JWT signing scheme — exploring tradeoffs.",
    "decision":"HS256 + 90-day env secret rotation cron.",
    "alternatives":["RS256","EdDSA","Paseto"],
    "consequences":"Simple infra, smaller tokens. Single shared secret = blast radius if leaked."
  }
}' | jq -r '.data.createDecision.id')

# Agent B proposes option 2
DEC_B=$(gql '...' '{
  "i":{... "title":"Option B: RS256 with rotated keypair", ...}
}')

# Agent C summarizes and proposes the winner — kind=adr because it's THE decision
DEC_FINAL=$(gql '...' '{
  "i":{... 
    "kind":"adr",
    "title":"Use HS256 (ADR — supersedes brainstorms)",
    "context":"After comparing options A (HS256) and B (RS256). See [Option A](/d/'$DEC_A') and [Option B](/d/'$DEC_B').",
    "decision":"HS256 wins for P1 simplicity. Revisit at v2 when we have multi-issuer needs.",
    ...
  }
}')
```

The chain is now visible: brainstorm A + brainstorm B → ADR final, all linked via mention chips in the prose.

## Pattern 4: Continuous review (security/style auditor agent)

A specialized agent watches for newly-created tasks and pre-emptively comments on risky ones:

```bash
# Polling loop (e.g. cron every 5min)
NEW_TASKS=$(gql '{
  tasks(first:20, where:{
    projectID:"'$PROJECT'",
    createdAtGT:"'$(date -v-5M -u +%FT%TZ)'",
    kind:"code"
  }){
    edges { node { id title description } }
  }
}' | jq -r '.data.tasks.edges[]')

# For each, run a heuristic / call out concerns via polymorphic comment
echo "$NEW_TASKS" | while read TASK_JSON; do
  ID=$(echo "$TASK_JSON" | jq -r '.node.id')
  if echo "$TASK_JSON" | jq -r '.node.description' | grep -qi 'auth\|password\|token\|secret'; then
    gql 'mutation($i:CreatePolyCommentInput!){ createCommentOn(input:$i){ id } }' '{
      "i":{
        "taskID":"'$ID'",
        "body":"Heads up — this touches auth. Please record an ADR before shipping. See [security checklist](/m/mem_security_review).",
        "authorAgentID":"'$AGENT_REVIEWER'"
      }
    }'
  fi
done
```

## How agents discover each other's work

There's no agent registry / pubsub yet (Phase 4). Agents discover via **polling the entity graph**:

| To find | Query |
|---|---|
| New tasks since I last checked | `tasks(where:{createdAtGT: $cursor})` |
| Tasks awaiting review | `tasks(where:{status:"awaiting_review"})` |
| Open gates needing decision | `gates(where:{status:open})` |
| Failed runs needing retry | `runs(where:{outcome:"fail"})` ordered by createdAt desc |
| Recently captured memories | `memories(where:{createdAtGT: $cursor})` |
| Decisions on a topic I'm working on | `decisions(where:{titleContainsFold:"<keyword>"})` |

A "watch daemon" pattern (Phase 4 deferred) would push these via NATS — for now, polling is fine.

## Coordinating without stepping on each other

| Risk | Mitigation |
|---|---|
| Two agents start runs on same task | Filter `assigneeAgentIDIsNil OR assigneeAgentID:<self>`; assign before starting |
| Race on plan approval | Only humans approve plans by convention; agents `requestPlanReview` instead |
| Conflicting decisions | All decisions are append-only — never mutate. Later decision can supersede via `kind:adr` + reference link |
| Memory dedup | Search before saving (`titleContainsFold`) |
| Activity firehose | Activities are append-only and indexed per host — read-side filters cheaply |

## Tone for AI agent comments / decisions / memories

When an agent (vs human) writes:
- Set `authorAgentID` / `actorAgentID` / `createdByAgentID` — never spoof a userID
- Lead with the agent's identity in long bodies ("Agent {name} via Claude {model}: …") so the reader can grade the take
- Never use first-person plural "we" — use "this agent" or the agent's name
- Cite sources: link the run, the decision, the spec
