# playbook — end-to-end scenarios

Real flows you'll hit week-to-week. Each entry: **scenario → goal → calls → sample response → variations**. All examples assume the `gql` helper from `SKILL.md` is defined.

```bash
HOST=api.aicoder.localhost          # or api.your-vps.com
PKEY=1234                            # dev only; prod uses X-Internal-Key header
PROJECT=prj_fi12w0suhyve0n8ce        # set per session
USER=usr_…                           # the human you're acting on behalf of
AGENT=agt_…                          # this Claude Code session's agent record

gql() { curl -s -X POST -H "Content-Type: application/json" \
  -d "$(jq -nc --arg q "$1" --argjson v "${2:-{\}}" '{query:$q, variables:$v}')" \
  "https://$HOST/api/dash/query?pkey=$PKEY"; }
```

---

## 1. New feature kickoff

**Scenario:** User says "we need to migrate auth to JWT."
**Goal:** Spec → Plan (status=draft) → 4 child Tasks attached to the Plan. Stop. Wait for human approval.

```bash
# 1. Spec
SPEC=$(gql 'mutation($i:CreateSpecInput!){ createSpec(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "title":"Auth migration",
    "summary":"Move /api/* from session cookies to JWT bearers.",
    "problem":"Cookies do not survive cross-domain SSO. Mobile clients have to roll their own session shim.",
    "goals":["Verify JWT in <100ms p95","Zero regression in /api/auth integration tests","Roll back in <5min"],
    "constraints":["No new infra in Phase 1","Maintain back-compat for v1 mobile clients (90 day window)"],
    "successMetrics":["p95 auth latency <100ms","Mobile client crash rate unchanged"]
  }
}' | jq -r '.data.createSpec.id')

# 2. Plan (draft)
PLAN=$(gql 'mutation($i:CreatePlanInput!){ createPlan(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "specID":"'$SPEC'",
    "title":"JWT auth migration — Phase 1",
    "strategy":"Adopt RFC-7519 with HS256, secret in env (rotate via cron). 4 phases: scaffolding (jwtauth pkg) → middleware swap → callsite update → cleanup. Out of scope: refresh-token rotation, RS256 key infra."
  }
}' | jq -r '.data.createPlan.id')

# 3. 4 child tasks
for spec in \
  'Build jwtauth package|kind:code,priority:high,effort:m' \
  'Wire jwtauth into apidash.Boot|kind:code,priority:high,effort:m' \
  'Update /api/auth/* callsites|kind:code,priority:medium,effort:l' \
  'Remove legacy session middleware|kind:chore,priority:low,effort:s'; do
  IFS='|' read -r title attrs <<< "$spec"
  TASK=$(gql 'mutation($i:CreateTaskInput!){ createTask(input:$i){ id } }' '{
    "i":{"projectID":"'$PROJECT'","title":"'"$title"'","kind":"code","priority":"high","effort":"m"}
  }' | jq -r '.data.createTask.id')
  gql 'mutation($p:ID!,$t:ID!){ addTaskToPlan(planID:$p, taskID:$t) }' \
    '{"p":"'$PLAN'","t":"'$TASK'"}'
done
```

**Hand off:**
```
Spec     https://aicoder.$HOST/s/$SPEC
Plan     https://aicoder.$HOST/p/$PLAN  (status: draft)
4 tasks attached.

Plan needs approval before agents execute. Approve in the UI, or:
  gql 'mutation { approvePlan(id:"'$PLAN'", approvedByUserID:"'$USER'") { id } }'
```

**Don't** start runs until plan status = `approved`.

---

## 2. Pick up the next task

**Scenario:** User says "what's next?"
**Goal:** Find the highest-priority approved task assigned to me / unassigned, then surface it.

```bash
gql '{
  tasks(first:10, where:{
    projectID:"'$PROJECT'",
    statusIn:["todo"],
    archivedAtIsNil:true
  }, orderBy:{field:PRIORITY, direction:DESC}) {
    edges { node { id title priority kind effort dueDate assigneeUserID assigneeAgentID } }
  }
}'
```

**Sample response:**
```json
{"data":{"tasks":{"edges":[
  {"node":{"id":"tsk_abc","title":"Wire jwtauth into apidash.Boot","priority":"high","kind":"code","effort":"m","dueDate":"2026-05-12T00:00:00Z","assigneeUserID":null,"assigneeAgentID":null}},
  {"node":{"id":"tsk_def","title":"Build jwtauth package","priority":"high","kind":"code","effort":"m","dueDate":null,"assigneeUserID":null,"assigneeAgentID":null}}
]}}}
```

Pick `tsk_abc`. Surface to user: "Next: `tsk_abc` (high · m · due May 12) — Wire jwtauth into apidash.Boot. Start a run?"

**Variations:**
- Filter to a single Plan: `where: { ..., plansViaPlanTasksMatch: { planID: "pln_..." } }` (entgql edge predicate)
- "What's blocking me": `where: { statusIn: ["blocked"] }`
- "What needs review": `where: { statusIn: ["awaiting_review"] }`

---

## 3. Run a task end-to-end

**Scenario:** User approved the plan and said "go."
**Goal:** start → plan checklist → walk steps → finish + capture lessons.

```bash
TASK=tsk_abc

# 1. Assign to my agent so the watcher knows who's working
gql 'mutation { assignTask(taskID:"'$TASK'", agentID:"'$AGENT'") { id assigneeAgentID } }'

# 2. Start
RUN=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id attempt } }' \
  '{"i":{"taskID":"'$TASK'","agentID":"'$AGENT'","model":"claude-opus-4-7"}}' \
  | jq -r '.data.startRun.id')

# 3. Plan BEFORE doing the work — watcher sees a live checklist
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){
  setRunPlan(runID:$id, summary:$s, steps:$st){ id }
}' '{
  "id":"'$RUN'",
  "s":"Wire jwtauth.New() into apidash.Boot middleware chain. Order: jwtauth → metrics → routes.",
  "st":[
    {"title":"read apidash/Boot/auth.go","rationale":"current middleware order","position":1},
    {"title":"add jwtauth import + constructor call","rationale":"keep secret from env","position":2},
    {"title":"reorder middleware chain","rationale":"jwtauth must run before metrics so unauthed requests dont pollute","position":3},
    {"title":"add integration test","rationale":"prevent regression","position":4},
    {"title":"task test","rationale":"verify","position":5}
  ]
}'

# Step IDs come back from the resolveTaskList query or a runSteps query
STEPS=$(gql '{ runSteps(first:20, where:{runID:"'$RUN'"}, orderBy:{field:POSITION, direction:ASC}){
  edges { node { id position title } }
}}' | jq -r '.data.runSteps.edges[] | .node.id')

# 4. Walk the steps as you go
for STEP in $STEPS; do
  gql 'mutation { startStep(stepID:"'$STEP'"){ id } }'
  # ... do the work ...
  gql 'mutation { completeStep(stepID:"'$STEP'", notes:"<what got done>"){ id } }'
done

# 5. Finish
gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id outcome } }' '{
  "i":{
    "runID":"'$RUN'",
    "outcome":"success",
    "summary":"Wired jwtauth.New() into Boot. Added integration test in apidash/auth_test.go. Tests pass; verified in dev.",
    "approach":"Inserted jwtauth before metrics in the chain. Secret read from JWT_SECRET env (matches existing pattern in saas/pkg/auth).",
    "model":"claude-opus-4-7",
    "tokensIn":18420,
    "tokensOut":4250,
    "costUsd":0.61,
    "durationMs":248000,
    "gitCommitSha":"a1b2c3d",
    "gitFiles":["apidash/Boot/auth.go","apidash/auth_test.go"]
  }
}'
```

If the run fails: `outcome:"fail"`, `errorKind:"<class>"`, `errorMessage:"<details>"`. Task auto-transitions to `blocked`.

---

## 4. Capture a decision mid-run

**Scenario:** Walking step 3 ("reorder middleware chain") you discover putting jwtauth before metrics would break the existing rate-limit middleware that depends on auth context. You opt for a different order.

```bash
gql 'mutation($i:CreateDecisionInput!){ createDecision(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "taskID":"tsk_abc",
    "runID":"'$RUN'",
    "kind":"choice",
    "title":"Place jwtauth after rate-limit, before metrics",
    "context":"Rate-limit middleware reads auth context to apply per-user limits. Putting jwtauth first breaks rate-limit context propagation.",
    "decision":"Order: ratelimit → jwtauth → metrics → routes. Rate-limit operates on raw IP for unauthed; jwtauth fills in user context for authed.",
    "alternatives":["jwtauth first (breaks rate-limit context)","jwtauth last (auth errors not rate-limited)","Refactor rate-limit to be auth-agnostic (out of scope)"],
    "consequences":"Rate-limit IP rules are now bypassed for authed users — acceptable. Document this in lace/jwtauth/README."
  }
}'
```

Now the decision shows on `/d/<id>`, the task's "Knowledge" rail, the run's `Decisions` list, and as a backlink anywhere `[…](/d/<id>)` appears.

---

## 5. Search prior art before deciding

**Scenario:** Before recording a decision, check if it (or a similar one) has been made.

```bash
# Free-text search across decision titles + bodies
gql '{
  decisions(first:20, where:{
    projectID:"'$PROJECT'",
    or:[
      {titleContainsFold:"jwt"},
      {decisionContainsFold:"jwt"},
      {contextContainsFold:"jwt"}
    ]
  }) {
    edges { node { id kind title decision createdAt } }
  }
}'
```

```bash
# Same shape for memories
gql '{
  memories(first:20, where:{
    projectID:"'$PROJECT'",
    or:[{titleContainsFold:"middleware"},{bodyContainsFold:"middleware"}]
  }) { edges { node { id tag title body } } }
}'
```

---

## 6. Open + resolve a Gate

**Scenario:** Step 4 ("remove legacy session middleware") is destructive — deleting code paths that may still have unmigrated callers in mobile apps.

```bash
# 1. Request the gate, set the run step to blocked
GATE=$(gql 'mutation($i:RequestGateInput!){ requestGate(input:$i){ id status } }' '{
  "i":{
    "taskID":"tsk_def","runID":"'$RUN'",
    "reason":"About to delete saas/pkg/auth/session.go. Confirm no v1 mobile clients still in the wild (last seen v1 ping was 2026-04-12)."
  }
}' | jq -r '.data.requestGate.id')

gql 'mutation { blockStep(stepID:"stp_…", reason:"Awaiting gate '$GATE'"){ id } }'

# 2. Poll until decided (run blocks here — caller can sleep & retry)
while true; do
  STATUS=$(gql '{ gates(first:1, where:{id:"'$GATE'"}){ edges { node { status note } } } }' \
    | jq -r '.data.gates.edges[0].node.status')
  case "$STATUS" in
    open)     sleep 60 ;;
    approved) echo "Approved, proceeding"; break ;;
    rejected)
      NOTE=$(gql '{ gates(first:1, where:{id:"'$GATE'"}){ edges { node { note } } } }' \
        | jq -r '.data.gates.edges[0].node.note')
      echo "Rejected: $NOTE"
      gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id } }' \
        "{\"i\":{\"runID\":\"$RUN\",\"outcome\":\"cancelled\",\"summary\":\"Gate rejected: $NOTE\"}}"
      exit 0 ;;
  esac
done

# 3. Approver clears the gate (this is what the human does in /workspace/.../knowledge gates tab)
gql 'mutation { approveGate(id:"'$GATE'", decidedByUserID:"'$USER'"){ id status decidedAt } }'
```

---

## 7. Project-wide standup

**Scenario:** Morning kickoff: what's in flight across the whole project?

```bash
# In-flight: anything not done/cancelled/archived
gql '{
  inflight: tasks(first:50, where:{
    projectID:"'$PROJECT'",
    statusNotIn:["done","cancelled"],
    archivedAtIsNil:true
  }, orderBy:{field:UPDATED_AT, direction:DESC}) {
    totalCount
    edges { node { id title status priority assigneeAgentID assigneeUserID updatedAt } }
  }

  # Open gates across all projects (operator view)
  gates(first:20, where:{status:open}) {
    edges { node { id taskID reason requestedAt } }
  }

  # Recently finished runs
  runs: runs(first:10, where:{outcomeIn:["success","fail"]}, orderBy:{field:CREATED_AT, direction:DESC}) {
    edges { node { id outcome taskID summary endedAt } }
  }

  # Awaiting review
  awaiting: tasks(first:20, where:{projectID:"'$PROJECT'", status:"awaiting_review"}) {
    totalCount
    edges { node { id title } }
  }

  # Plans pending approval
  draftPlans: plans(first:20, where:{projectID:"'$PROJECT'", status:"draft"}) {
    totalCount
    edges { node { id title } }
  }
}'
```

Compose into a 5-line standup:
```
- 12 in-flight (3 high, 9 medium-low)
- 2 awaiting review: tsk_abc, tsk_xyz
- 1 draft plan needing approval: pln_…
- 1 open gate: gat_… (waiting 4h)
- Last run: run_… succeeded 2h ago — "Wired jwtauth into Boot"
```

---

## 8. Activity feed for any entity

**Scenario:** "What changed on this spec / plan / task?"

```bash
# Per-entity (use the right ID column)
gql '{
  activities(first:30, where:{specID:"'$SPEC'"}, orderBy:{field:CREATED_AT, direction:DESC}) {
    edges { node { id kind actorUserID actorAgentID after createdAt } }
  }
}'
```

For a project-wide feed, the Web UI's `/workspace/<id>/activity` route does this in parallel across all entity types — query the same way per type if scripting.

---

## 9. Postmortem an incident

**Scenario:** A bug shipped. You reverted, fixed forward, want it remembered.

```bash
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "tag":"incident",
    "title":"Auth middleware reordering broke rate-limit context",
    "body":"## What happened\nDeployed jwtauth → metrics → ratelimit ordering. Authenticated users hit IP-based rate limits because the chain ran ratelimit BEFORE the user context was attached.\n\n## Root cause\nDid not run /api/auth integration tests against the new chain — they pin auth context but not rate-limit behaviour.\n\n## Fix\nReverted to ratelimit → jwtauth → metrics → routes. PR #142.\n\n## Prevention\n- Rate-limit middleware must document its dependency on auth context (done in 142).\n- Add a chain-order assertion test that fails if jwtauth moves before ratelimit.",
    "sourceTaskID":"tsk_abc",
    "sourceRunID":"'$RUN'"
  }
}'
```

Pair with a Decision (kind=adr) capturing the new chain order rule.

---

## 10. Comment on any entity

**Scenario:** Discussion / question on a Spec or Plan, not just a Task.

```bash
gql 'mutation($i:CreatePolyCommentInput!){ createCommentOn(input:$i){ id } }' '{
  "i":{
    "specID":"'$SPEC'",
    "body":"Bumped goals to include 90-day mobile-client back-compat window. See [decision](/d/dec_…).",
    "authorAgentID":"'$AGENT'"
  }
}'
```

`@`-mention syntax in the body becomes a backlink chip on the referenced entity. The polymorphic input takes exactly one of `taskID / specID / planID / decisionID / memoryID`.

---

## 11. Inbox + badges

**Scenario:** Process my notifications — what needs my attention right now?

```bash
gql '{
  badges: inboxBadges(userID:"'$USER'") {
    unreadTotal awaitingReview gates mentions failures assignments
  }

  inbox(userID:"'$USER'", filter:{unreadOnly:true, limit:50}) {
    id eventKind taskID createdAt readAt
  }
}'
```

After triaging:
```bash
gql 'mutation { markNotificationRead(id:"ntf_…"){ id } }'
gql 'mutation { archiveNotification(id:"ntf_…"){ id } }'
# Bulk:
gql 'mutation { markAllNotificationsRead(userID:"'$USER'") }'
```

---

## 12. Bulk reassignment

**Scenario:** Switch all open tasks from agent A to agent B (e.g. swapping which Claude model handles a class of work).

```bash
# 1. Find them
TASKS=$(gql '{ tasks(first:100, where:{projectID:"'$PROJECT'", assigneeAgentID:"'$OLD'", statusNotIn:["done","cancelled"]}) {
  edges { node { id } }
}}' | jq -r '.data.tasks.edges[].node.id')

# 2. Reassign
for T in $TASKS; do
  gql 'mutation { assignTask(taskID:"'$T'", agentID:"'$NEW'"){ id } }' >/dev/null
  echo "→ $T → $NEW"
done
```

Each reassignment emits an Activity row + a Notification to the new agent.

---

## Common idioms

| Need | Pattern |
|---|---|
| Fire and forget | `gql '...' >/dev/null` |
| Retrieve a single field | `gql '...' \| jq -r '.data.<mutation>.id'` |
| Variables for complex inputs | Pass JSON to `gql`'s second arg; never inline `${var}` into the GraphQL string |
| Error inspection | `gql '...' \| jq '.errors'` — surfaces validation errors with location info |
| Pagination | All connection queries support `first / after / orderBy`. Use the cursor in `pageInfo.endCursor` |
| Total count | Pass `first: 0` and select `totalCount` to skip rows entirely |

## Tips

- **Never construct queries via string concat.** Always pass values via the variables map. The `gql` helper does this with `jq -nc --argjson v`.
- **Prefer mutation idempotency** when the API guarantees it (`gateRequest`, `addTaskToList`). Re-runs are safe.
- **Always pass `actorUserID` or `actorAgentID`** so the Activity log is meaningful. The web UI shows a "system" actor when none is set, which is rarely what you want.
- **For long-running multi-step flows** (a Run with gates), persist `RUN`, `GATE` etc. in env or a state file — don't keep them only in shell variables that die with your session.
