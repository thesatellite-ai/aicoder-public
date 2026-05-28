# Agent

Identity record for a non-human caller — Claude Code, an SDK agent, the `aicoder` CLI, or any other tool acting on behalf of a user. Every mutation that records *who* did something accepts an Agent ID; without one, authorship is attributed to the API-key owner instead of the agent that did the work.

## Why this matters

If you don't register an agent and stamp it onto your writes, the dashboard shows you (the human) as the author of everything the agent created. That collapses agent-vs-human attribution, breaks per-agent activity dashboards, and ruins downstream analytics. **First mutation in a session should be `ensureAgent`.**

## Object type

```graphql
type Agent implements Node {
  id: ID!                # agt_…
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  userID: String!        # the human this agent acts for
  name: String!          # e.g. "claude-code @ thesatellite"
  kind: AgentKind!
  sessionID: String      # optional terminal/session id
  hostname: String
  tty: String
  cwd: String
  gitBranch: String
  lastSeenAt: Time
}
```

## Enums used by this entity

| Enum | Valid values |
|---|---|
| `AgentKind` | `CLAUDE_CODE`, `CLI`, `OTHER` |

## Register / upsert — `ensureAgent`

There is **no `createAgent` mutation**. The canonical write is `ensureAgent` — idempotent register-or-update keyed on `(userID, name)`. Same args → same agent; first call inserts, subsequent calls refresh `hostname` / `cwd` / `gitBranch` / `lastSeenAt`.

```graphql
mutation EnsureAgent(
  $u: ID!
  $n: String!
  $k: AgentKind
  $host: String
  $tty: String
  $cwd: String
  $branch: String
  $session: String
) {
  ensureAgent(
    userID: $u
    name: $n
    kind: $k
    hostname: $host
    tty: $tty
    cwd: $cwd
    gitBranch: $branch
    sessionID: $session
  ) { id name kind hostname cwd gitBranch lastSeenAt }
}
```

Variables (real session shape):

```json
{
  "u":      "usr_abc123…",
  "n":      "claude-code @ thesatellite",
  "k":      "CLAUDE_CODE",
  "host":   "macbook-pro.local",
  "tty":    "ttys004",
  "cwd":    "/Volumes/D/www/projects/khanakia/aicoder",
  "branch": "main",
  "session":"$(uuidgen)"
}
```

Returns `agt_…`. Cache it for the lifetime of the session and pass it on every subsequent write.

### One-liner (variables form — recommended)

```bash
eval "$(aicoder env)" && curl -sf -X POST "$AICODER_HOST/api/dash/query" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "X-Workspace-Id: $AICODER_WORKSPACE" \
  -H "Content-Type: application/json" \
  -d "$(jq -nc \
    --arg q 'mutation($u:ID!,$n:String!,$k:AgentKind){ensureAgent(userID:$u,name:$n,kind:$k,hostname:env.HOST,cwd:env.PWD){id name}}' \
    --arg u "$AICODER_USER_ID" \
    --arg n "claude-code @ $(basename $PWD)" \
    --arg k "CLAUDE_CODE" \
    '{query:$q, variables:{u:$u, n:$n, k:$k}}')" | jq .
```

If you don't know your `$AICODER_USER_ID`, fetch it via `authMe`:

```bash
curl -sf -X POST "$AICODER_HOST/api/dash/query" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query":"query { authMe { id email } }"}' | jq -r '.data.authMe.id'
```

## Using the agent ID on writes

Every entity that records authorship exposes an `…AgentID` field on its create/update input. Set it on the same call:

| Entity | Field |
|---|---|
| Task | `assigneeAgentID` |
| Run | `actorAgentID` |
| Decision | `createdByAgentID` |
| Memory | `capturedByAgentID` |
| Source | `capturedByAgentID` |
| Comment | `authorAgentID` |
| Spec | `authorAgentID` |
| Plan | `createdByAgentID` |

```graphql
mutation($a: ID!) {
  createDecision(input: {
    projectID: "prj_…"
    kind: CHOICE
    title: "Use HS256"
    decision: "…"
    createdByAgentID: $a       # ← stamp it
  }) { id createdByAgentID }
}
```

## Backfill

Forgot to stamp on the first N writes? Backfill via the corresponding update mutation:

```graphql
mutation($id: ID!, $a: ID!) {
  updateDecision(id: $id, input: { createdByAgentID: $a }) { id }
}
```

Run once per entity. Future writes in this session already carry the ID, so this is a one-time cleanup.

## Inspect agents

```graphql
query {
  agents(first: 50) {
    edges { node { id name kind hostname cwd gitBranch lastSeenAt } }
  }
}
```

Or use the dashboard: `/w/<wsId>/settings/agents` — read-only list of every registered agent for the workspace.

## Recipe — first-mutation pattern

1. Resolve credentials: `eval "$(aicoder env --profile=…)"`
2. Fetch user id once: `authMe { id }`
3. `ensureAgent` → cache `agt_…` for the session
4. Every subsequent create/update mutation includes the appropriate `…AgentID` field
5. Re-call `ensureAgent` periodically (or on cwd/branch change) — it'll refresh `lastSeenAt` + cwd

Do steps 1–3 once at session start. Skipping them is the most common cause of "all my work shows up under the human user instead of the agent".
