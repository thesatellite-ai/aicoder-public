# Playbook — pick the right project

The skill activation makes you a participant in the aicoder system. **Before any project-scoped action**, you must figure out which project the user means. This playbook is the canonical procedure.

## When this playbook applies

Any action that touches a project-scoped entity:

- Creating, reading, updating, deleting any Task / Plan / Spec / Decision / Memory / Idea / Source / TermSession / etc.
- Running aicoder mutations that take `projectID` or run inside a project context.
- Looking up "open tasks", "recent decisions", "the spec for X" — anything project-bounded.

Activities that are NOT project-scoped and skip this playbook:

- Workspace-level admin (creating projects, inviting members, listing all workspaces).
- Looking up user profile / auth state (`authMe`, `authMyApiKeys`).
- Internal / cron paths that take an `X-Internal-Key` header.

## Procedure

### 1. Discover the menu

```bash
aicoder config list --json
```

Three possible outcomes:

| Output | Meaning | Next step |
|---|---|---|
| Single profile (e.g. `{ profiles: { default: { … } } }`) | Repo wired to one aicoder project | Use it — skip to step 4 |
| Multiple profiles | Repo wired to several aicoder projects | Continue to step 2 |
| Error: no `.aicoder/config.json` found | Repo not wired yet | Stop, ask user to run `aicoder init` then `aicoder render` |
| Error: no host / no credentials | User not logged in | Stop, ask user to run `aicoder login` |
| Repo wired but no `.aicoder/AICODER.md` / no pointer in `CLAUDE.md` | User skipped `aicoder render` | Suggest user run `aicoder render` so future sessions auto-load this repo's bridge file (non-blocking) |

### 2. Read each profile's description

The output's `profiles` object has one entry per available project:

```json
{
  "profiles": {
    "main":  { "project": "prj_main",     "description": "Default — coordination, cross-cutting tasks" },
    "slack": { "project": "prj_slack",    "description": "Slack integration — bot, slash commands, webhooks" },
    "contacts": { "project": "prj_contacts", "description": "Contact manager — CRM, segmentation" }
  }
}
```

The **`description`** field is your routing signal. Treat it as a topic boundary — what kinds of work belong in this project.

### 3. Match the user's intent to one description

Apply these rules in order:

1. **Exactly one description clearly matches** → pick that profile. Confidence high; proceed silently.
2. **Multiple descriptions match** → ASK the user. Cite the descriptions back; do not guess.
3. **No description matches** → check whether the user implied "across projects" or "the default":
   - "How many tasks total?" / "All open work" → use the active profile, mention you're scoped to it.
   - Otherwise → ask.

Examples:

| User says | Match | Action |
|---|---|---|
| "Add a task: Slack bot times out" | slack | Pick `slack` |
| "Fix CRM export bug" | contacts | Pick `contacts` |
| "Log a decision about retry policy" | none clear | Ask ("which project does the retry policy belong to?") |
| "Investigate webhook delivery" | slack + contacts | Ask ("Slack webhook handlers or Contacts import/export — both fit") |
| "Refactor shared error helper" | main | Pick `main` (cross-cutting) |

### 4. Load credentials for the picked profile

```bash
eval "$(aicoder env --profile=<picked>)"
```

After this, your shell has `AICODER_HOST`, `AICODER_KEY`, `AICODER_WORKSPACE`, `AICODER_PROJECT` set.

### 5. Make the GraphQL call

```bash
curl -sf -X POST "$AICODER_HOST/api/dash/query" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "X-Workspace-Id: $AICODER_WORKSPACE" \
  -H "X-Project-Id: $AICODER_PROJECT" \
  -H "Content-Type: application/json" \
  -d '{"query":"…", "variables": …}'
```

The server's tenant interceptor uses the headers to scope all reads + stamp all writes. You don't need to pass `projectID` in the mutation input — the header drives it (and overrides any value in input for project-scoped keys).

## Anti-patterns

- **Don't cache the picked profile across unrelated requests.** Different user intents → repeat the routing decision.
- **Don't pick by file path proximity alone.** Description match wins. `cd src/slack` is hint, not authority — the user may be working on cross-cutting things from that dir.
- **Don't write to multiple profiles "to be safe".** Pick one. If you're unsure, ask, then write once.
- **Don't hand-construct `Authorization` headers from `~/.config/aicoder/credentials`.** Always go through `aicoder env` or `aicoder config print --json` — the layering (env vars → profile → credentials) is non-trivial, the CLI gets it right.

## When the user explicitly names a project

If the user says "in the slack project, add a task" or "for `prj_slack`, log a decision", skip the description-match and use the explicit naming:

```bash
eval "$(aicoder env --profile=slack)"
# or, by ID:
export AICODER_PROJECT=prj_slack
```

Acknowledge the override in your response (e.g. "Logging this in `slack` per your request").

## Verifying you're in the right scope

Quick sanity check at the start of a project-scoped operation — list one row of project metadata before mutating:

```bash
curl -sf -X POST "$AICODER_HOST/api/dash/query" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "X-Workspace-Id: $AICODER_WORKSPACE" \
  -H "X-Project-Id: $AICODER_PROJECT" \
  -d '{"query":"{ project(id: \"$AICODER_PROJECT\") { id name } }"}'
```

If the response is `null` or the name doesn't match what the user said, your scoping is wrong — rerun step 1.
