# api-cheatsheet — GraphQL examples

> **Enum syntax (read once, never forget).** GraphQL enum literals are **bare identifiers in UPPER_SNAKE_CASE** — `kind: CODE`, never `kind: "code"` or `kind: "CODE"`. Strings get rejected with `Enum cannot represent non-enum value: "X"` even when the spelling is right. When in doubt use variables (the `gql` helper below already supports them) — `kind: $k` with `{"k":"CODE"}` is JSON-safe.

GraphQL endpoint: `https://api.<your-host>/api/dash/query`
Playground (dev): `https://api.<your-host>/api/dash/query_playground?pkey=<dev-key>`

Local dev host: `api.aicoder.localhost` · dev pkey is `1234`. Production hosts replace those — set `$HOST` and pick **one** auth path (see SKILL.md → Auth):

```bash
# Recommended for agents: mint a long-lived user API key once.
task aicoder:apikey:create USER=usr_… NAME="my agent" TTL=720h SCOPES=read,write
# -> prints ak_<prefix>_<secret> once; reuse as the Bearer below.

KEY="ak_…"            # user API key OR a session accessToken from authLogin/authRefresh
WSP="wsp_…"            # current workspace
gql() {
  curl -s -X POST "$HOST/api/dash/query" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $KEY" \
    -H "X-Workspace-Id: $WSP" \
    -d "$(jq -nc --arg q "$1" --argjson v "${2:-{\}}" '{query:$q, variables:$v}')"
}

# System/admin path (skip Bearer + X-Workspace-Id, send X-Internal-Key instead):
gql_admin() {
  curl -s -X POST "$HOST/api/dash/query" \
    -H "Content-Type: application/json" \
    -H "X-Internal-Key: $INTERNAL_KEY" \
    -d "$(jq -nc --arg q "$1" --argjson v "${2:-{\}}" '{query:$q, variables:$v}')"
}
```

## Listing & searching

```graphql
# All open tasks in a project
{ tasks(first: 50, where: { projectID: "prj_…", archivedAtIsNil: true })
  { edges { node { id title status priority kind dueDate updatedAt } } } }

# Tasks awaiting review
{ tasks(first: 20, where: { projectID: "prj_…", status: "awaiting_review" })
  { edges { node { id title } } } }

# Specs with their plans (one round-trip)
{ specs(first: 10, where: { projectID: "prj_…" })
  { edges { node { id title status plans { id title status } } } } }

# Plans with task progress (one round-trip)
{ plans(first: 10, where: { projectID: "prj_…" })
  { edges { node { id title status tasks { id status } } } } }

# Find a memory
{ memories(first: 20, where: { projectID: "prj_…", titleContainsFold: "auth" })
  { edges { node { id title tag body } } } }

# Open gates across all projects
{ gates(first: 20, where: { status: OPEN })
  { edges { node { id taskID runID reason requestedAt } } } }

# Activity for a single entity (host = spec)
{ activities(first: 50, where: { specID: "spec_…" })
  { edges { node { id kind after createdAt actorUserID } } } }

# Count totals (use totalCount on the connection)
{ tasks(first: 0, where: { projectID: "prj_…" }) { totalCount } }
```

## Creating

```graphql
mutation {
  createTask(input: {
    projectID: "prj_…"
    boardID: "brd_…"       # REQUIRED — fetch via { boards(first:1, where:{projectID:"prj_…"}){edges{node{id}}} }
    title: "Migrate auth to JWT"
    description: "## AC\n- [ ] verify in <100ms"
    kind: CODE             # TaskKind: CODE | BUG | FEATURE | CHORE | RESEARCH | AUTOMATION | DOCS | OPS
    priority: HIGH         # TaskPriority: NONE | LOW | MEDIUM | HIGH | URGENT
    effort: M              # TaskEffort:   NONE | S | M | L | XL
    status: "todo"         # String (not enum): todo | in_progress | done | etc.
  }) { id }
}

mutation {
  createSpec(input: {
    projectID: "prj_…"
    title: "Auth migration"
    summary: "Move from session cookies to JWT"
    problem: "Cookies don't survive cross-domain SSO"
    goals: ["Verify <100ms", "No regression in /api/auth tests"]
  }) { id }
}

mutation {
  createPlan(input: {
    projectID: "prj_…"
    specID: "spec_…"
    title: "JWT auth migration"
    strategy: "Adopt RFC-7519 with HS256. 4 phases…"
  }) { id }
}

mutation {
  createDecision(input: {
    projectID: "prj_…"
    taskID: "tsk_…"
    runID: "run_…"
    kind: CHOICE           # DecisionKind: ADR | BRAINSTORM | CHOICE
    status: PROPOSED       # DecisionStatus: PROPOSED | ACCEPTED | SUPERSEDED | REJECTED  (no DRAFT)
    title: "Use HS256 over RS256"
    context: "Single auth issuer, want minimal infra."
    decision: "HS256 with rotated shared secret in env."
    alternatives: ["RS256 (more standard, key rotation infra)", "EdDSA (less library support)"]
    consequences: "Commit to 90-day secret rotation cron."
  }) { id }
}

mutation {
  createSource(input: {
    projectID: "prj_…"
    kind: DIAGRAM           # SourceKind: NOTE | LINK | TRANSCRIPT | CHAT | DIAGRAM | RECORDING | SCREENSHOT
    bodyFormat: TLDRAW      # SourceBodyFormat: MARKDOWN | PLAIN | CODE | JSON | EXCALIDRAW | TLDRAW
    title: "Auth flow mockup"
    body: "{...tldraw JSON...}"
  }) { id }
}

mutation {
  createMemory(input: {
    projectID: "prj_…"
    tag: PATTERN           # MemoryTag: FEEDBACK | LESSON | PATTERN | INCIDENT | NOTE
    title: "ent edges + Optional() pattern"
    body: "When making an edge column optional, use field.Optional().Nillable() AND drop .Required()."
    sourceTaskID: "tsk_…"
  }) { id }
}

# Polymorphic comment (one of taskID/specID/planID/decisionID/memoryID)
mutation {
  createCommentOn(input: {
    specID: "spec_…"
    body: "Bumped goals to include a 90-day rotation step. See [decision](/d/dec_xyz)."
  }) { id }
}
```

## Run lifecycle

```graphql
# 1. Start
mutation { startRun(input: { taskID: "tsk_…", model: "claude-opus-4-7" }) { id attempt } }

# 2. Plan (summary + ordered steps)
mutation {
  setRunPlan(
    runID: "run_…"
    summary: "Wire JWT verifier into apidash.Boot"
    steps: [
      { title: "read apidash/Boot",     rationale: "understand current order", position: 1 }
      { title: "identify changes",      rationale: "new sequence: jwtauth → metrics → routes", position: 2 }
      { title: "make the change",       rationale: "edit Boot + add tests",    position: 3 }
      { title: "verify",                rationale: "task test",                position: 4 }
    ]
  ) { id }
}

# 3. Walk the steps
mutation { startStep(stepID: "stp_…") { id status } }
mutation { completeStep(stepID: "stp_…", notes: "Done; 4 files changed.", output: { files: 4 }) { id } }
# or: skipStep / failStep / blockStep

# 4. Finish
mutation {
  finishRun(input: {
    runID: "run_…"
    outcome: success
    summary: "Wired jwtauth.New() into Boot. Tests pass."
    costUsd: 0.42
    tokensIn: 12500
    tokensOut: 3200
    durationMs: 142000
    gitCommitSha: "abcd1234"
    gitFiles: ["apidash/Boot/auth.go", "apidash/Boot/auth_test.go"]
  }) { id outcome }
}
```

## Plan approval gate

```graphql
mutation { approvePlan(id: "pln_…", approvedByUserID: "usr_…") { id status } }
mutation { activatePlan(id: "pln_…") { id status } }
mutation { addTaskToPlan(planID: "pln_…", taskID: "tsk_…", position: 1) }
```

## Gate (mid-run human approval)

```graphql
mutation {
  requestGate(input: {
    taskID: "tsk_…"
    runID: "run_…"
    reason: "About to drop v1_sessions table. Confirm rollout window has elapsed?"
  }) { id status }
}
mutation { approveGate(id: "gat_…", decidedByUserID: "usr_…") { id } }
mutation { rejectGate(id: "gat_…", decidedByUserID: "usr_…", reason: "Not yet.") { id } }
```

## Reviews

```graphql
mutation {
  postReview(input: {
    taskID: "tsk_…"
    runID: "run_…"
    scope: run_output       # or: plan
    verdict: approve         # approve | reject | request_changes
    reviewerUserID: "usr_…"
    feedback: "LGTM. Shipped."
  }) { id verdict }
}
```

## Inbox + badges

```graphql
{ inbox(userID: "usr_…", filter: { unreadOnly: true, limit: 50 })
  { id eventKind taskID createdAt readAt } }

{ inboxBadges(userID: "usr_…")
  { unreadTotal awaitingReview gates mentions failures assignments } }

mutation { markNotificationRead(id: "ntf_…") { id readAt } }
mutation { markAllNotificationsRead(userID: "usr_…") }
```

## Auth (current state)

The dash playground uses `?pkey=1234` for development. There's no JWT-style auth on the GraphQL surface yet — Phase 4 wires real auth. For now: any user/agent ID you pass in `authorUserID` / `actorUserID` / `assigneeUserID` is trusted.
