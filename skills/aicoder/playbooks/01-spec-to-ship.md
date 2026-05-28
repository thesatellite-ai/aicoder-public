# 01 — Full lifecycle: spec to ship

End-to-end. The user says "build X." You take it from idea to merged PR with everything captured.

## The arc

```
   USER says        AGENT (you)            HUMAN gate
   ────────        ────────────           ──────────
   "build X"  ───▶  draft Spec
                    draft Plan
                    create Tasks
                          │
                          ▼
                                       ◀── approve Plan
                          │
                          ▼
                    pick Task →
                    Run cycle (×N)
                       start
                       setRunPlan
                       walk Steps
                       capture Decisions / Memories along the way
                       finish
                          │
                          ▼
                                       ◀── Review (approve/reject)
                          │
                          ▼
                    Task → done
                    Plan → done (when all tasks done)
                    Postmortem memories saved
   ────────        ────────────
```

## Concrete example

User: "We need to migrate `/api/auth/*` from session cookies to JWT bearers. Mobile clients need 90 days back-compat."

### Phase 1 — Capture intent (Spec)

```bash
# Read the ask. Identify:
#   problem: cross-domain SSO breaks with cookies
#   goals:   verify <100ms, no /api/auth regression, rollback in <5min
#   constraints: 90-day mobile back-compat, no new infra in P1

SPEC=$(gql 'mutation($i:CreateSpecInput!){ createSpec(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "title":"Auth migration to JWT",
    "summary":"Move /api/* from session cookies to JWT bearers. Maintain 90-day v1 mobile back-compat.",
    "problem":"Session cookies do not survive cross-domain SSO. Mobile clients have to roll session shims.",
    "goals":["Verify JWT in <100ms p95","Zero regression in /api/auth tests","Roll back in <5min"],
    "constraints":["No new infra in Phase 1","90-day v1 mobile client back-compat window"],
    "successMetrics":["p95 auth latency <100ms","Mobile client crash rate unchanged","All /api/auth integration tests pass"]
  }
}' | jq -r '.data.createSpec.id')

echo "Spec: https://aicoder.$HOST/s/$SPEC"
```

### Phase 2 — Approach (Plan)

The Plan answers "how." Strategy = the paragraph that would convince a sceptical reviewer this is the right approach.

```bash
PLAN=$(gql 'mutation($i:CreatePlanInput!){ createPlan(input:$i){ id status } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "specID":"'$SPEC'",
    "title":"Auth migration — Phase 1",
    "strategy":"Adopt RFC-7519 JWT with HS256 + env-secret rotation. Four phases: (1) build jwtauth pkg in lace/, (2) wire into apidash.Boot middleware chain, (3) update /api/auth/* callsites, (4) remove legacy session middleware. Mobile back-compat via dual-mode middleware that accepts either cookie OR bearer for 90 days. Out of scope: refresh-token rotation, RS256 key infra."
  }
}' | jq -r '.data.createPlan.id')

# Status: draft. NOT approved. NOT executable yet.
```

### Phase 3 — Decompose (Tasks)

Break the plan into atomic work units. Each Task must fit in one Claude session (~few hours of focused work).

```bash
declare -a TASKS

for spec in \
  'Build lace/jwtauth package|kind:code,priority:high,effort:m,desc:Implement HS256 sign + verify. Tests for expiry/rotation/malformed.' \
  'Wire jwtauth into apidash.Boot|kind:code,priority:high,effort:m,desc:Insert in middleware chain after ratelimit before metrics. Document dependency.' \
  'Add dual-mode middleware (cookie OR bearer)|kind:code,priority:high,effort:s,desc:For 90-day mobile back-compat window.' \
  'Update /api/auth/* callsites|kind:code,priority:medium,effort:l,desc:18 endpoints. Use the new context helper.' \
  'Add chain-order assertion test|kind:code,priority:medium,effort:s,desc:Fails if jwtauth moves before ratelimit. Prevents reorder regressions.' \
  'Remove legacy session middleware|kind:chore,priority:low,effort:s,desc:After v1 mobile sunset (90d). NOT in P1.'; do
  IFS='|' read -r title attrs <<< "$spec"
  T=$(gql 'mutation($i:CreateTaskInput!){ createTask(input:$i){ id } }' \
    '{"i":{"projectID":"'$PROJECT'","title":"'"$title"'","kind":"code","priority":"high","effort":"m"}}' \
    | jq -r '.data.createTask.id')
  gql 'mutation($p:ID!,$t:ID!){ addTaskToPlan(planID:$p, taskID:$t) }' \
    '{"p":"'$PLAN'","t":"'$T'"}'
  TASKS+=("$T")
done
```

### ⏸ STOP. Hand off.

```
Spec     https://aicoder.$HOST/s/$SPEC
Plan     https://aicoder.$HOST/p/$PLAN  (status: DRAFT — needs approval)
6 tasks attached.

Plan needs approval before agents execute. Approve in the UI, or:
  approvePlan(id: "$PLAN", approvedByUserID: "...")
```

**Do not proceed.** The user must approve the plan. This is the load-bearing human gate of the whole system — agents draft, humans decide.

### Phase 4 — Run cycle (per task, multiple runs allowed)

After approval, for each task you pick up:

```bash
# Pre-flight: confirm plan is approved before starting any run
PLAN_STATUS=$(gql '{ plans(first:1, where:{id:"'$PLAN'"}){ edges { node { status } } } }' \
  | jq -r '.data.plans.edges[0].node.status')

if [ "$PLAN_STATUS" != "approved" ] && [ "$PLAN_STATUS" != "active" ]; then
  echo "Plan is $PLAN_STATUS. Refusing to start runs. Surface to user."
  exit 0
fi

# Pick the highest-priority task assigned to me / unassigned
TASK=$(gql '{
  tasks(first:1, where:{
    projectID:"'$PROJECT'",
    statusIn:["todo"],
    or:[{assigneeAgentID:"'$AGENT'"},{assigneeAgentIDIsNil:true}],
    archivedAtIsNil:true
  }, orderBy:{field:PRIORITY, direction:DESC}){
    edges { node { id title } }
  }
}' | jq -r '.data.tasks.edges[0].node.id')

# Claim it
gql 'mutation { assignTask(taskID:"'$TASK'", agentID:"'$AGENT'") { id } }' >/dev/null
```

The full Run cycle is in `02-run-lifecycle.md` — read that next.

### Phase 5 — Plan completion

When all tasks under the plan are `done`:

```bash
gql 'mutation { updatePlan(id:"'$PLAN'", input:{ status: DONE }){ id status } }'
```

Then save a **plan-level postmortem memory** capturing what shipped vs what didn't:

```bash
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "tag":"lesson",
    "title":"JWT migration — what we learned in P1",
    "body":"## Shipped\n- jwtauth pkg, dual-mode middleware, all /api/auth callsites\n\n## Deferred\n- Legacy session middleware removal (waits for v1 mobile sunset 2026-08-12)\n\n## Surprises\n- Rate-limit middleware DEPENDS on jwtauth running first for user-context-aware limits. Documented in lace/jwtauth/README. Chain-order test prevents future regression.\n\n## Cost\n- 12 runs across 5 tasks. 4.2M tokens, ~$28 total. ~14h elapsed.",
    "sourceTaskID":null
  }
}'
```

## What the user sees during all of this

| Phase | Where the user looks |
|---|---|
| Draft Spec/Plan | `/workspace/<id>/knowledge` → Specs / Plans tabs |
| Plan needs approval | `/p/<plan>` — Approve button in header |
| In-flight runs | `/workspace/<id>/board` — assigned tasks; `/t/<task>` shows live RunStep checklist |
| Pending gate | Sidebar status footer ("N open gates"); `/workspace/<id>/knowledge` → Gates tab |
| Activity | `/workspace/<id>/activity` — date-grouped feed |
| Backlinks discovery | Any detail page, "Mentioned in" rail |

## Anti-pattern: skipping the Spec

Tempting to jump from "user asked for X" → Plan or Tasks. Don't. The Spec is the *intent contract*. Plans can change. Tasks can be re-decomposed. The Spec is what the work is being measured against. Without it:
- Future agents can't tell if a refactor still serves the original goal
- Decisions can't reference "in service of constraint Y from spec Z"
- Postmortems lose their grading rubric (success metrics)

For genuinely small fixes (a typo, a one-line bug fix), skip Spec/Plan and just create a single Task. The threshold: if the work would benefit from being explained to the *next* engineer, write the Spec.
