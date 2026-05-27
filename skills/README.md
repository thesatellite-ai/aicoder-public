# skills

[skills.sh](https://skills.sh)-installable agent skills for the **aicoder** product. Drop them into any AI agent / Claude Code project so the agent can operate against an aicoder backend as a first-class participant.

```bash
# install into the consuming project
npx skills add thesatellite-ai/aicoder-cli-go
```

Sources live here under `skills/<name>/` at the repo root (NOT under `.claude/`) so they're versioned, audited, and distributable. The consumer's `skills add` drops them into that project's `.claude/skills/` per skills.sh convention.

## Available skills

| Skill | What it gives the agent |
|---|---|
| [`aicoder`](./aicoder/SKILL.md) | Full operating manual for the aicoder task system. **[`SKILL.md`](./aicoder/SKILL.md)** — mental model, auth (user API key / session JWT / `X-Internal-Key`), `gql` helper, always-do rules. **[`API.md`](./aicoder/API.md)** — exhaustive flat reference (~13k lines): every Query, Mutation, Input, Enum, Object type. **[`entities/`](./aicoder/entities/)** — 21 per-entity pages (Task, Spec, Plan, Decision, Memory, Source, Idea, Area, Project, TaskList, Board, Comment, Label, ListView, MarkdownFile, ProjectDirectory, ProjectMember, Designation, TaskLink, TaskTemplate, TermSession) with object type + create/update inputs + where filter + enums + related ops. **[`playbooks/`](./aicoder/playbooks/)** — 10 workflows (mental model, spec-to-ship, run lifecycle, multi-agent, knowledge retrieval, recovery, Claude-Code orchestration, real-world walkthrough, ideas-to-shipped, areas design). **[`prompts/`](./aicoder/prompts/)** — 6 templates (api-cheatsheet, capture-decision, postmortem, run-checklist, start-feature, playbook). |

## Layout

```
skills.sh.json                 ← skills.sh manifest (grouping → which skills ship)
skills/
  README.md                     ← this file
  aicoder/
    SKILL.md                    ← entry point (YAML frontmatter + overview)
    API.md                      ← generated reference of every Query / Mutation / Input / Enum
    playbooks/                  ← long-form workflows (10 files)
    prompts/                    ← reusable prompt templates (6 files)
```

## Adding a new skill

1. `skills/<slug>/SKILL.md` with YAML frontmatter:
   ```
   ---
   name: <slug>
   description: <when the AI should load this — used for relevance>
   license: MIT
   metadata:
     author: <name>
     version: "1.0.0"
   ---
   ```
2. Add `"<slug>"` to a grouping in [`../skills.sh.json`](../skills.sh.json).
3. Drop supporting `.md` files (playbooks, references, prompts) alongside `SKILL.md` — agents can read them on demand.

Format reference: <https://agentskills.io/>.

## Regenerating `aicoder/API.md`

The API.md is generated from the live SDL fragments at `apidash/internal/graph/schemas/*.graphql`. After a schema change, re-run the generator (see `aicoder/API.md` header — endpoint + introspection one-liner; or just `task apidash:gql` then `python3 scripts/gen-skill-api.py` if you add one).
