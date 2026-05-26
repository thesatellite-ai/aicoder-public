---
name: 08-ideas-to-shipped
description: Real-world walkthrough — from a brain-dump of ideas about a UI component, triaging them by subject, promoting the right ones into Tasks or Plans, and tracing lineage back when something ships.
---

# Ideas → Shipped — a real walkthrough

A worked example: building out the **Datagrid** component in the DesignKit
project. The same flow applies to any subject — Sidebar, Combobox, theming,
docs site, anything.

## Mental model

```
Brain-dump   →   Idea       →   Task / Plan      →   Code     →   Shipped
("we should  ─→ {kind=idea, ─→ {via promote*,    ─→ PR + run ─→ idea.status =
add ...")    ─→  votes=0}    ─→  status=accepted, ─→ activity ─→ "shipped"
                              ─→  converted_*_id} ─→            ─→ converted_task
                                                                     points back}
```

Key invariants:

- An Idea always has a **subject** (free string, e.g. `Datagrid`) so it
  groups naturally with sibling ideas without needing a Subject table.
- Promotion is **soft** — the Idea row is preserved with `status=accepted`
  and a back-pointer FK (`converted_task_id` or `converted_plan_id`). You
  never lose the brainstorm context.
- Ideas don't gate anything. They're zero-cost to dump in bulk.

## Phase 1 — Brain-dump (cost: 30 seconds)

Tell the AI:

> Look at our Datagrid component and dump 12 features we should add. Use
> subject "Datagrid". Mix small and big ones.

The AI calls `createIdea` 12 times. Each row has `{subject: "Datagrid", title, body}`,
`status="idea"`, `votes=0`. Total cost: 12 inserts. No status meeting, no
priority assignment, no plan to attach to.

```graphql
mutation {
  createIdea(input: {
    projectID: "prj_xyz",
    subject: "Datagrid",
    title: "Virtual scrolling for 100k rows",
    body: "Renders only viewport rows. Body is **markdown** so we can sketch the API:\n\n```ts\n<Datagrid virtualize rowHeight={32} />\n```"
  }) { id }
}
```

You can have AI generate ideas for **multiple subjects in one prompt**:

> Datagrid: 5 ideas. Sidebar: 5 ideas. Combobox: 5 ideas.

Each idea lands in the right subject bucket. The Ideas page (`/workspace/$projectId/ideas`)
shows all subjects as filter chips.

## Phase 2 — Triage (cost: a few minutes per session)

Open `/workspace/$projectId/ideas`. Status filter defaults to `idea` so you
see only un-triaged ones. Filter by subject `Datagrid` to focus.

For each idea, decide:

- **Quick view (eye icon)** → read the body, ⌘+number to vote, decide.
- **Open full page (Maximize2)** → if the idea needs more thinking, open the
  full page and edit the body to flesh it out.
- **Skip for now** → just leave it. Filtered list keeps it visible next time.

### When to promote to Task vs Plan

| Signal | Promote to |
|---|---|
| Single-PR scope | **Task** |
| One person could ship in 1-3 days | **Task** |
| Body is mostly "do X to file Y" | **Task** |
| 5+ sub-tasks become obvious as you read | **Plan** |
| Crosses multiple files / packages | **Plan** |
| Touches the public API surface | **Plan** (so the spec / approval gate kicks in) |
| You want a sub-checklist with progress | **Plan** |

Heuristic: if you can write the implementation in a sentence, it's a Task.
If you need a paragraph, it's a Plan.

### Real example

```
Idea: "Multi-column sort" (Datagrid)
Body: "Shift-click second column to add a secondary sort key.
       Visual: ↑1 ↓2 markers in headers."
       
→ Promote to Task. Single PR. Body already describes the implementation.
```

vs

```
Idea: "Virtual scrolling for 100k rows" (Datagrid)
Body: "Renders only viewport rows. Need to coordinate with column resize,
       row pinning, sticky headers, keyboard nav. Probably 5-6 PRs across
       3 files. Affects the public Datagrid component API."

→ Promote to Plan. Body becomes the plan's strategy. You'll attach
  individual feature tasks under the plan as you scope them.
```

## Phase 3 — Execution (Task or Plan flow)

After promotion, the idea has `status=accepted` and `converted_task_id` (or
`converted_plan_id`) set. Click "Open task" / "Open plan" from the idea's
detail page to jump to it.

From here it's the normal flow:

- **Task** → drag across Board columns; assign to agent or yourself;
  ship the PR; activity log records it.
- **Plan** → flesh out child tasks; approve the plan; agents pick up tasks;
  reviews / gates as needed.

The idea itself stays around as `accepted`. You can flip it to
`status=shipped` when the work lands, or leave it as `accepted` — both
queries are fine.

## Phase 4 — Tracing lineage

Two questions you can answer cheaply:

### "Where did this Task come from?"

Tasks list `convertedFromIdeas` as a relation:

```graphql
{
  task(id: "tsk_abc") {
    title
    convertedFromIdeas { id title subject }
  }
}
```

Useful for:
- Code review context — see the original brainstorm body
- Releases notes — pull the idea body for the changelog entry
- Retros — find which ideas converted vs got rejected

### "Which ideas under subject X got promoted?"

```graphql
{
  ideas(where: {
    projectID: "prj_xyz",
    subject: "Datagrid",
    statusIn: [accepted, shipped]
  }) {
    edges { node { title status convertedTaskID convertedPlanID } }
  }
}
```

Gives you a backlog burn-down per component.

## Phase 5 — Voting (optional)

When working with a team, votes help triage. The current implementation is
one-way `+1` (anyone can click — no per-user dedup). Sort the ideas page
by Votes descending and the popular ideas float to the top.

Plan: when this becomes a real bottleneck, swap to a per-user `IdeaVote`
join table — schema change is small.

## Anti-patterns

- **Don't put implementation tasks in Ideas.** "Refactor `TaskListBoard.tsx`
  to use a hook" is a Task, not an Idea — the decision to do it is already made.
  Idea = "should we even do this?".
- **Don't reject ideas you might revisit.** Use `duplicate` or just leave
  them in `idea` status. Rejection is for ideas you've actively decided
  against (with a reason in the body via the Reject dialog).
- **Don't promote without reading the body.** It's tempting to bulk-promote
  good-looking titles, but the body usually has the "why" — promotion is
  cheap to undo at the GraphQL level but not from the UI yet.
- **Don't skip the subject.** Empty subject defeats the grouping. Always
  pick one — even "misc" if you must.

## CLI shortcuts (future)

```bash
# Brain-dump from a markdown file
aicoder idea bulk-import --project @current --subject Datagrid \
  --from .ai/datagrid-brainstorm.md

# Promote a batch by selector
aicoder idea promote --where "subject=Datagrid status=idea votes>=3" --to task

# Show the lineage of a shipped task back to its idea
aicoder task lineage tsk_abc
```

(Not yet implemented — but the entity supports them.)

## See also

- `01-spec-to-ship.md` — when an idea becomes a Plan, this is the next playbook.
- `04-knowledge-retrieval.md` — how Memory differs from Idea (Memory = lessons
  from past work; Idea = future work).
