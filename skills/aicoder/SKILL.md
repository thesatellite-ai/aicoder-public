---
name: aicoder
description: Operate the aicoder task management system as a first-class participant. Use when the user asks to plan a feature, scope work, record a decision, save a lesson learned, start an agent run, request human approval, or do anything that lives in Tasks / Specs / Plans / Decisions / Memories / Gates / Runs / Reviews / Templates / Sources / Ideas / Areas / Comments. Mention "aicoder", "task system", "/workspace/", or any of those entity names → this skill applies. Ships with 10 end-to-end playbooks (spec-to-ship, run-lifecycle, multi-agent, knowledge-retrieval, recovery, Claude-Code orchestration, real-world walkthrough, ideas-to-shipped, areas design), 6 reusable prompts (api-cheatsheet, capture-decision, postmortem, run-checklist, start-feature, playbook), and a full API.md enumerating every Query/Mutation/Input/Enum.
license: MIT
metadata:
  author: khanakia
  version: "1.0.0"
---

# aicoder — skill

The aicoder task system is the project's source-of-truth for in-flight work. **Tasks** track units of work, **Specs** capture intent, **Plans** group tasks under an approved approach, **Decisions** record non-obvious choices (ADRs / brainstorms / tactical), **Memories** are retrievable lessons, **Gates** pause runs for human approval, **Runs** are agent attempts on a task, **RunSteps** are the live checklist inside a run, and **Reviews** verify finished runs.

You participate the same way humans do — through the Web UI, the `aicoder` CLI, or GraphQL. Always do it; this is how the user (and other agents) sees what you're doing.

## Reference layout

| Where | What it gives you |
|---|---|
| this file (`SKILL.md`) | mental model · auth (3 paths) · `gql` helper · always-do rules · playbook index · prompt index |
| [`API.md`](./API.md) | exhaustive flat reference — every Query, Mutation, Input, Enum, and Object type pulled straight from the SDL fragments (~13k lines) |
| [`entities/`](./entities/) | per-entity pages (21) — object type + Create/Update inputs + Where filter + enums used + related queries/mutations. Start at [`entities/README.md`](./entities/README.md). |
| [`playbooks/`](./playbooks/) | 10 end-to-end workflows (00→09) — read 00 first, then the one matching your task |
| [`prompts/`](./prompts/) | 6 reusable templates (api-cheatsheet, capture-decision, postmortem, run-checklist, start-feature, playbook) |

## Mental model — what each thing is for

```
Spec       — "what + why" doc. Problem, goals, constraints, success metrics.
Plan       — "how" doc. Hangs off a Spec. Approve before agents execute.
Task       — atomic unit of work. Belongs to project, optionally to a Plan.
Run        — one agent attempt at finishing a Task.
RunStep    — one step in a Run's checklist (started/completed/skipped/failed/blocked).
Review     — verdict on a finished Run (approve / reject / request_changes).
Decision   — kind=adr | choice | brainstorm. Captured *during* work.
Memory     — tag=lesson | pattern | incident | feedback | note. Retrievable.
Gate       — mid-run pause requesting human approval (e.g. before destructive op).
TaskTemplate — recipe to spawn similar tasks fast.
```

How they connect:

```
Project
 └── Spec            (one or many; the "why")
      └── Plan        (approve before work starts)
           └── Task   (via PlanTask junction; tasks may belong to many plans)
                ├── Run             (multiple attempts allowed)
                │    ├── RunStep    (the live checklist)
                │    └── Review     (verdict on a finished run)
                └── Gate            (pause requests during a run)

Decisions, Memories, Comments, Activity
  attach polymorphically to any of: Task, Spec, Plan, Decision (kind=brainstorm), Run.
```

## When to use the system (and when not)

**Use** when:
- User describes a multi-step feature → Spec + Plan + Tasks
- You're about to make a non-obvious architectural choice → Decision (kind=adr / choice)
- You learn a portable pattern or fix a real incident → Memory
- Work is consequential / irreversible → Gate before doing it
- User asks "what's next?" → `aicoder task ls --status todo`
- User asks "what did we decide about X?" → `aicoder decision ls` + grep / search
- User asks "what changed in the project today?" → `/workspace/<id>/activity`

**Don't use** when:
- One-shot questions ("what does this code do?") — answer directly
- Trivial fixes (typo, formatting) — fix it; no overhead
- The repo has its own task tooling and the user hasn't asked for aicoder

## How you actually call it

**Reality check:** there are two deployment shapes:

| Shape | Where you run from | Available interfaces |
|---|---|---|
| **Local dev** | Your own machine, repo checked out, `task saas:dev:portless` running | GraphQL at `https://api.aicoder.localhost`, plus `saasfly aicoder ...` CLI (built locally) |
| **VPS / hosted** | Claude Code on your laptop, aicoder running on a VPS | GraphQL at `https://api.<your-host>` ONLY — no CLI access from your laptop |

**→ For 99% of Claude Code use, you go through GraphQL HTTP. The CLI is a shell convenience, not the canonical interface.**

The skill assumes GraphQL-first. CLI examples are shown only for completeness, and only work on a host that has the `saasfly` binary on `$PATH` and DB connectivity.

### GraphQL endpoint

```
POST   https://api.<your-host>/api/dash/query
QUERY  ?pkey=<dev-key>      # dev playground only — see below
```

**Auth (three paths, pick one):**

1. **User API key (recommended for agents)** — mint a long-lived per-user key once and send it as `Authorization: Bearer <raw>` on every request. Tenancy is set per request via `X-Workspace-Id: <wsp_…>`. Mint with:

   ```bash
   # Either via the project Taskfile:
   task aicoder:apikey:create USER=usr_… NAME="my agent" TTL=720h SCOPES=read,write [WORKSPACE=wsp_…]

   # Or directly via the CLI:
   cd saas && go run ./cmd/cli apikey create \
     --user=usr_… --name="my agent" --ttl=720h --scopes=read,write
   ```

   The raw `ak_<prefix>_<secret>` is printed **once** (authmgr stores only the hash + prefix). Save it. Use as:

   ```bash
   curl -H "Authorization: Bearer ak_…" -H "X-Workspace-Id: wsp_…" \
        -H "Content-Type: application/json" \
        -d '{"query":"{ ping }"}' "$HOST/api/dash/query"
   ```

2. **User session JWT** — `authLogin(email, password)` → `accessToken` (~15 min) + `refreshToken`. Send `Authorization: Bearer <accessToken>`; on 401 (`"unauthorized: authentication required"`), call `authRefresh(refreshToken)` and retry once. Same `X-Workspace-Id` header.

3. **System / `X-Internal-Key`** — admin path: send `X-Internal-Key: <value>` (set in PKL config, also gates `/api/i/*`). Bypasses user auth (`@internal`-marked fields still gate further). Requests are unscoped — no workspace interceptor applies — so pass `projectID` etc. explicitly.

**Dev shortcut:** the playground accepts `?pkey=<dev-key>` for hand-running queries in a browser. Not for programmatic use.

**Author/actor identity:** every mutation that records who did something accepts an explicit `authorUserID` / `actorUserID` / `assigneeAgentID` / `capturedByUserID` / `createdByUserID` field. Pass the agent's user/agent id when calling on its behalf.

**The endpoint is the source of truth.** Anything the Web UI does, you can do — the UI is just a GraphQL client. Browse the playground (`/api/dash/query_playground?pkey=…` in dev) for the full surface. Live introspection at `/api/dash/query` works in dev but is **disabled in production-mode deployments** (returns `{"errors":[{"message":"introspection disabled"}]}`) — in that case fall back to the SDL fragments at `apidash/internal/graph/schemas/*.graphql` and the curated [`API.md`](./API.md) in this skill.

### Calling from Claude Code

Your two practical options:

1. **`curl` via the Bash tool** — the simplest, most portable:
   ```bash
   curl -s -X POST -H "Content-Type: application/json" \
     -d '{"query":"mutation { createMemory(input: { projectID: \"prj_…\", title: \"…\", body: \"…\", tag: lesson }) { id } }"}' \
     "https://api.<your-host>/api/dash/query?pkey=$AICODER_PKEY"
   ```

2. **The Web UI** — for things best done by a human (reading dashboards, approving plans, decisions about ambiguous trade-offs). Always include the URL when you create something:
   `https://aicoder.<your-host>/s/<specID>`

### CLI (when available)

The `saasfly aicoder ...` CLI exists for shell sessions on the host. If you happen to be running on the host (local dev, ssh into VPS), you can use it. Same surface as the GraphQL — every CLI subcommand maps 1:1 to a GraphQL mutation/query. See `prompts/api-cheatsheet.md` for the full GraphQL palette.

```
saasfly aicoder task ls / new / show / move / done
saasfly aicoder run start / plan / finish / cancel
saasfly aicoder spec ls / new / show
saasfly aicoder plan ls / new / approve / activate / add-task / tasks
saasfly aicoder decision ls / new
saasfly aicoder memory new / search
saasfly aicoder gate ls / request / approve / reject
```

Add `--json` for machine output. Set `AICODER_PROJECT=<id>` to scope.

**Key queries:**

```graphql
# List tasks in a project, optionally filtered
tasks(first: 50, where: { projectID: "prj_…", status: "todo" }) {
  edges { node { id title status priority kind dueDate } }
}

# Resolve a TaskList's actual tasks (handles static / virtual / hybrid)
resolveTaskList(listID: "tl_…", viewerUserID: "usr_…") {
  id title status
}

# Polymorphic activity feed for any host
activities(first: 100, where: { specID: "spec_…" }) {
  edges { node { id kind createdAt actorUserID after } }
}
# or: { taskID, planID, decisionID, memoryID }

# Inbox + badges
inbox(userID: "usr_…", filter: { unreadOnly: true }) { id eventKind ... }
inboxBadges(userID: "usr_…") { unreadTotal awaitingReview gates mentions failures }

# Linked task graph
linkedTasks(taskID: "tsk_…") { blocks blockedBy relatesTo references referencedBy }
```

**Key mutations:**

```graphql
# Tasks
createTask(input: { projectID, title, kind, priority, … })
updateTask(id, input: { … })
moveTask(taskID, status, position)
assignTask(taskID, userID, agentID)
archiveTask(taskID) / restoreTask(taskID)

# Specs / Plans / Decisions / Memories — entgql auto-generated
createSpec / updateSpec
createPlan / updatePlan / approvePlan / activatePlan / addTaskToPlan / removeTaskFromPlan
createDecision / updateDecision
createMemory / updateMemory

# Runs / Steps / Reviews
startRun(input: { taskID, model })
setRunPlan(runID, summary, steps: [{ title, rationale }])
requestPlanReview(runID)
finishRun(input: { runID, outcome, summary, costUsd, tokensIn, tokensOut, … })
cancelRun(runID)
startStep(stepID) / completeStep(stepID, notes, output)
skipStep(stepID, reason) / failStep(stepID, errorMessage) / blockStep(stepID, reason)
postReview(input: { taskID, runID, scope, verdict, feedback })

# Gates
requestGate(input: { taskID, runID, reason })
approveGate(id, decidedByUserID) / rejectGate(id, decidedByUserID, reason)

# Polymorphic comments — any host
createCommentOn(input: { taskID|specID|planID|decisionID|memoryID, body })
```

## The standard workflow

For non-trivial work (anything beyond "fix this typo"). All examples use GraphQL via curl — drop them straight into the Bash tool. Substitute `$HOST` (e.g. `api.aicoder.localhost` or `api.your-vps.com`) and `$PKEY` (dev key) or `$AUTH_HEADER` (prod).

A handy shell function for the rest of this section:

```bash
gql() {
  curl -s -X POST -H "Content-Type: application/json" \
    -d "$(jq -nc --arg q "$1" --argjson v "${2:-{\}}" '{query:$q, variables:$v}')" \
    "https://$HOST/api/dash/query?pkey=$PKEY"
}
```

### 1. Spec first when intent is fuzzy

When the user describes a *feature / outcome* without prescribing the how — capture it as a Spec.

```bash
gql 'mutation($i: CreateSpecInput!) { createSpec(input: $i) { id } }' \
  '{"i":{"projectID":"prj_…","title":"Auth migration","summary":"Move from session cookies to JWT","problem":"Cookies do not survive cross-domain SSO","goals":["Verify <100ms","No regression in /api/auth tests","Full rollback in <5min"]}}'
```

### 2. Plan — the approach

```bash
gql 'mutation($i: CreatePlanInput!) { createPlan(input: $i) { id } }' \
  '{"i":{"projectID":"prj_…","specID":"spec_xyz","title":"JWT auth migration","strategy":"Adopt RFC-7519 with HS256. 4 phases: scaffolding → middleware → callsites → cleanup. Out of scope: refresh-token rotation."}}'
```

**Status starts `draft`. Until it's `approved`, do not start runs against its tasks.** Surface to the user: "Plan ready for review. Approve via Web UI: `https://aicoder.$HOST/p/<plan-id>`"

### 3. Tasks — atomic units

3–8 tasks per plan. Verb-first titles, scoped to one Claude Code session each.

```bash
gql 'mutation($i: CreateTaskInput!) { createTask(input: $i) { id } }' \
  '{"i":{"projectID":"prj_…","title":"Wire JWT verifier into apidash.Boot","description":"## AC\n- [ ] /api/* verify JWT\n- [ ] Tests pass","kind":"code","priority":"high","effort":"m"}}'

# Then attach to the plan:
gql 'mutation { addTaskToPlan(planID:"pln_…", taskID:"tsk_…", position:1) }'
```

### 4. Run — one agent attempt

Always `start` → `plan` → walk steps → `finish`.

```bash
# 1. Start
RUN=$(gql 'mutation($i: StartRunInput!) { startRun(input:$i) { id } }' \
  '{"i":{"taskID":"tsk_…","model":"claude-opus-4-7"}}' | jq -r '.data.startRun.id')

# 2. Declare the plan BEFORE doing the work — the watcher sees a live checklist on /t/$task
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!) { setRunPlan(runID:$id, summary:$s, steps:$st) { id } }' \
  '{"id":"'$RUN'","s":"Wire JWT verifier into apidash.Boot","st":[
    {"title":"read apidash/Boot","rationale":"current order","position":1},
    {"title":"identify changes","rationale":"jwtauth → metrics → routes","position":2},
    {"title":"make the change","rationale":"edit Boot + add tests","position":3},
    {"title":"verify","rationale":"task test","position":4}
  ]}'

# 3. Walk the steps as you go
gql 'mutation { startStep(stepID:"stp_…") { id } }'
gql 'mutation { completeStep(stepID:"stp_…", notes:"Done; 2 files.") { id } }'
# ...

# 4. Finish
gql 'mutation($i:FinishRunInput!) { finishRun(input:$i) { id outcome } }' \
  '{"i":{"runID":"'$RUN'","outcome":"success","summary":"Wired jwtauth.New() into Boot. Tests pass.","costUsd":0.42,"tokensIn":12500,"tokensOut":3200}}'
```

### 5. Decisions captured along the way

Every non-obvious choice → record. Especially: trade-offs you made under time pressure, things you did differently than the plan suggested.

```bash
gql 'mutation($i:CreateDecisionInput!) { createDecision(input:$i) { id } }' \
  '{"i":{"projectID":"prj_…","taskID":"tsk_…","runID":"run_…","kind":"choice","title":"Use HS256 over RS256","context":"Considering JWT signature scheme. Single auth issuer.","decision":"HS256 with rotated shared secret in env.","alternatives":["RS256 (more standard, key rotation infra)","EdDSA (less library support)"],"consequences":"Commit to 90-day secret rotation cron."}}'
```

### 6. Memories at end-of-task

Save the *portable* lessons.

```bash
gql 'mutation($i:CreateMemoryInput!) { createMemory(input:$i) { id } }' \
  '{"i":{"projectID":"prj_…","tag":"pattern","title":"ent edges + Optional() pattern","body":"When making an edge column optional, use field.Optional().Nillable() AND drop .Required() from the edge.From() — otherwise migrations fail with NOT NULL.","sourceTaskID":"tsk_…"}}'
```

Tag picker:
- `lesson` — would tell a teammate over coffee
- `pattern` — reusable code / config / doc shape
- `incident` — bug + fix (so we don't re-debug)
- `feedback` — user said "do/don't X" — record verbatim
- `note` — interesting but not yet a pattern

### 7. Gates when something is consequential

About to delete files / drop a table / push an irreversible change? Open a Gate first.

```bash
gql 'mutation($i:RequestGateInput!) { requestGate(input:$i) { id status } }' \
  '{"i":{"taskID":"tsk_…","runID":"run_…","reason":"About to drop the v1_sessions table. Confirm rollout window has elapsed?"}}'
```

Block on the gate becoming `approved`. Don't proceed on rejection.

```bash
# Poll until decided
while true; do
  STATUS=$(gql '{ gates(first:1, where:{id:"gat_…"}) { edges { node { status } } } }' \
    | jq -r '.data.gates.edges[0].node.status')
  [ "$STATUS" = "open" ] || break
  sleep 30
done
```

## Web UI cheatsheet

Opening a project: `https://aicoder.localhost/workspace/<projectID>/...`

| Tab | What you see |
|---|---|
| `/board` | Kanban — todo / in_progress / awaiting_review / blocked / done columns. DnD between columns moves status. Filter by Kind / Priority / Status. |
| `/lists` | ClickUp-style table view. Each TaskList → table of tasks (Title / Status / Priority / Kind / Effort / Due / Updated). |
| `/knowledge` | Spec / Plan / Decision / Memory / Gate sub-tabs. Per-tab counts + search. |
| `/templates` | TaskTemplate recipes (kind/priority/effort defaults + descriptionTemplate). |
| `/activity` | Project-wide event log, date-grouped. |

Detail routes (any tab links into these):
- `/t/<taskID>` — task detail with Description, Subtasks, Linked, Runs (with live RunStep checklist), Knowledge (decisions/memories), Backlinks, Comments, Activity
- `/s/<specID>` — spec detail with Plans rail, aggregate task progress, decisions/memories/backlinks, activity, comments
- `/p/<planID>` — plan detail with mini kanban, runs feed, decisions/memories/backlinks, activity, comments
- `/d/<decisionID>` — decision detail with verdict box, "where this lives" rail, backlinks, activity, comments
- `/m/<memoryID>` — memory detail with source, related-by-tag, backlinks, activity, comments

**Power moves in the UI:**
- `⌘K` / `Ctrl+K` — palette. Search anything; type `+ <title>` to create; `+spec foo` / `+task fix login` for typed creation.
- `?` — keyboard cheatsheet
- `@` in any prose field — autocomplete entity link (renders as a typed chip)
- `/` in any prose field — slash commands (todo, code block, ADR scaffold, run-checklist, table, callouts)

## What goes where — decision matrix

| You have… | Capture as | Reason |
|---|---|---|
| A vague idea, "we should look into X" | Memory (tag=note) | Holding pen for things that aren't ready to act on |
| A concrete problem to solve, no solution | Spec | Problem + goals before approach |
| Approach for a Spec | Plan (links to spec) | Approval gate before work |
| A concrete unit of work | Task | The atomic piece |
| Architectural choice (multi-file, hard to reverse) | Decision (kind=adr) | Future-you needs to know why |
| Tactical choice during a Run | Decision (kind=choice, runID set) | Captures "I picked X because…" in context |
| Options listed before any commit | Decision (kind=brainstorm) | Speculative — frames the conversation |
| Something to remember next time | Memory (tag=lesson \| pattern) | Retrievable across tasks |
| A bug + its fix | Memory (tag=incident) | Don't re-debug |
| User said "do this / don't do that" | Memory (tag=feedback) | Verbatim — user style enforcement |
| About to do something risky | Gate | Pause and ask |

## Antipatterns — don't

- **Don't start a run on a task whose plan is `draft`.** Surface to user: "Plan needs approval first."
- **Don't fabricate IDs.** Run `ls` first.
- **Don't skip the `run plan` step** for non-trivial runs — the live checklist is what makes the watcher's UI useful.
- **Don't open a Gate** for ordinary edits. Gates are for *consequential* moves (deletes, deploys, irreversible writes).
- **Don't capture every micro-step as a Decision.** Only the *non-obvious* ones with real alternatives.
- **Don't save every step as a Memory** — only the *portable* ones (would apply on a different task).
- **Don't put helpers in `apidash/internal/graph/resolver/*`** — gqlgen owns those files; helpers go in `tasksystem_helpers.go` or other files in the package.

## Reference

### `playbooks/` — read these in order for the AI-agent mental model

The playbooks are themed and progressive — each builds on the prior. Read at least `00` + the one matching your current task.

- `playbooks/00-mental-model.md` — **read first.** ASCII diagrams of how the entities connect, the flow of authority (who can do what when), the two clocks (plan-time vs run-time), ID prefix legend.
- `playbooks/01-spec-to-ship.md` — full lifecycle: idea → Spec → Plan → tasks → run cycle → ship → postmortem.
- `playbooks/02-run-lifecycle.md` — zoom into the run inner loop: state machine, plan-before-act contract, walking steps, capturing decisions/memories mid-run, finishing with the right outcome.
- `playbooks/03-multi-agent.md` — sequential handoff (planner→executor→reviewer), parallel agents on independent tasks, brainstorm chains, continuous-review pattern, coordination without stepping on each other.
- `playbooks/04-knowledge-retrieval.md` — the "before you start" knowledge sweep, search-before-save, decisions hierarchy (brainstorm→ADR), spec-driven retrieval, cross-project knowledge, agent self-checkpointing.
- `playbooks/05-recovery.md` — when things go wrong: run failure retry, step-blocked-with-gate, review rejection loop, plan replan, stuck→ask-user, lost session recovery, abandoned-run GC.
- `playbooks/06-claude-code-orchestration.md` — Claude Code specific: planner vs executor session shape, session-start ritual, session-end checkpoint, when to use UI vs API, bash helper to source.
- `playbooks/07-real-world-walkthrough.md` — concrete end-to-end story: how a human + 2 agents build "streaming chat UI with tool calls + citations" through the system. Every artifact lives in the demo project (`prj_fi12w0suhyve0n8ce`) — clickable links throughout.

### `prompts/` — narrow single-purpose templates

Use when you know exactly which operation you need. Cross-references back to playbooks where useful.

- `prompts/playbook.md` — earlier flat playbook (12 scenarios; superseded by `playbooks/` directory but kept as a single-file reference)
- `prompts/api-cheatsheet.md` — comprehensive GraphQL examples grouped by mutation/query
- `prompts/start-feature.md` — Spec + Plan + Tasks scaffolding
- `prompts/capture-decision.md` — ADR / choice / brainstorm template
- `prompts/run-checklist.md` — structured run plan + step lifecycle
- `prompts/postmortem.md` — wrap up a run with memory + decision

## Backend code map (when you need to extend things)

| Change to make | Where |
|---|---|
| Add a new entity field | `dbent/schema/<entity>.go` → `task dbent:gm` (regen + migrate) |
| Add a service method | `saas/pkg/<entity>/service.go` |
| Add a GraphQL query/mutation | `apidash/internal/graph/schemas/tasksystem.graphql` → `task apidash:gql` (then implement resolver) |
| Add a CLI subcommand | `saas/cmd/cli/aicoder.go` |
| Regenerate frontend SDK | `cd ../aicoder-cli-web && task gqlkit:all` |

## Tone

When operating the system on the user's behalf:
- Be terse. The user will read your output to decide if the next step is right.
- Return IDs + status, not paragraphs of confirmation.
- No emojis in code or commit messages. Only ASCII chips like `✓` / `✗` are OK in CLI output.
- When you create something, end with a hyperlink: `https://aicoder.localhost/<route>/<id>`.
