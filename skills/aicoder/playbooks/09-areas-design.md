---
name: 09-areas-design
description: Why we introduced the Area entity, what it replaces (free-text Idea.subject), and how it ties together every other entity in the task system.
---

# Areas — design doc

## What is an Area?

An **Area** is a named, durable slice of work within a project. It lives
longer than any single Task / Plan / Spec it contains.

Concrete examples:

- `Datagrid` — the data-grid component you ship in DesignKit.
- `Diagram Viewer` — the diagram-viewer component.
- `Combobox`, `Sidebar`, `Auth flow`, `Onboarding` — same shape.

Every Area has:

- A **name** (display) + **slug** (URL-safe, derived). Unique within a project.
- A **status**: `active | shipped | on_hold | deprecated`.
- An optional **lead user** (DRI), **description**, **position** (sort order).

Areas collect related work via opt-in FKs from other entities:

```
Project ─ has many ─→ Area
                          ↑ ↑ ↑
Idea (required) ─────────┘ │ │
Task (optional) ───────────┘ │
TaskList (optional) ─────────┘
```

When you visit `/a/$areaId` you see every Idea / Task / TaskList that opted
into that area — a single dashboard for all the work touching that
component / surface / module.

## Why we needed it

The original v1 of Ideas used a free-text `subject: string` column. Looked
fine for 5 ideas. Broke fast because:

1. **Pills don't scale.** With 50+ subjects the filter chip row blew up
   the page width. There was no way to navigate through them.
2. **No state.** A subject is just a label; you can't say "Datagrid v1 is
   shipped, archive its filter from the default view." Areas have a
   `status` field exactly for this.
3. **No ownership.** A subject doesn't have a DRI / lead — it's a string.
4. **No spelling guard rails.** "Datagrid" + "DataGrid" + "data-grid"
   would split your ideas into three buckets silently. Areas dedupe by
   slug at the DB level (unique `(project_id, slug)` index).
5. **Doesn't compose.** A Task can't be "tagged Datagrid" via a free
   string — the taxonomy lives only on Idea. We want Area to be a
   cross-entity dimension.
6. **Can't navigate from an idea to its peers.** With Areas, every Idea
   row links to `/a/$areaId` which lists every other Idea + every Task +
   every TaskList in the same area. You discover the Datagrid backlog
   bottom-up.

## Why we picked the name "Area"

Considered:

| Name | Verdict |
|---|---|
| Component | Right when project is a UI library; wrong when it's a SaaS app (`Auth flow` isn't a component) |
| Module | Generic, software-y, slightly cold |
| **Area** | **Picked** — neutral; works for UI libs *and* SaaS; Linear normalised it so users recognise it |
| Topic | Too vague |
| Surface | Too jargon-y |
| Initiative | Implies time-bound; doesn't fit `Datagrid` (forever) |

Area wins on neutrality. If your DesignKit project ever spins up a non-UI
project under aicoder, Area still makes sense; `Component` would force you
into "well, an auth-flow isn't really a component but…".

## Schema

```
Area
├── id                  area_xxxxx (BaseMixin)
├── project_id          required FK
├── name                "Datagrid"
├── slug                "datagrid"  (lower-kebab, unique within project)
├── description?        free text
├── status              active | shipped | on_hold | deprecated
├── lead_user_id?       optional DRI
├── position            float for ordering
├── archived_at?        soft-delete
└── created_at, updated_at  (BaseMixin)
```

Indexes: `unique(project_id, slug)`, `(project_id, status)`.

### Status — lifecycle stages

```
planned    →    wip    →    live
                              │
                              └→ deprecated
                              
              ⤴ on_hold (pause from any of planned / wip / live)
```

| Status | Meaning |
|---|---|
| `planned` | Scoped, on roadmap, no work yet |
| `wip` | Someone is actively building this right now |
| `live` | Shipped, in production |
| `on_hold` | Paused; will resume |
| `deprecated` | Going away; don't add new work |

Default when creating a new Area: **`planned`**. The auto-flip rule
(below) bumps it to `wip` the first time an Idea is promoted to a Task
under that area.

#### Status options we considered

This taxonomy went through a few iterations before settling. The
v1 was `active | shipped | on_hold | deprecated` — `active` was a
junk-drawer that conflated three very different lifecycle stages.

**Option A (chosen)** — 5 statuses, no exploration phase:

```
planned · wip · live · on_hold · deprecated
```

The Idea entity already covers exploration ("should we even build
this?"). By the time you create an Area you've already decided to
build. So `planned` is the natural starting state.

**Option B (rejected)** — 6 statuses including `exploring`:

```
exploring · planned · wip · live · on_hold · deprecated
```

Adds a stage most projects won't actively use. Ideas + Areas already
have natural division of labor (idea = exploration, area = commitment),
so introducing `exploring` on Areas duplicates the Ideas function.

**Option C (rejected)** — Linear-style 4 + cancelled:

```
backlog · in_progress · done · cancelled
```

Drops the `on_hold` ↔ `deprecated` distinction. They feel different in
practice (`on_hold` = expect to resume; `deprecated` = don't touch),
and projects we've watched lose information when forced into one bucket.

**Why not include `maintenance`?** Adds a sixth bucket without clear
value — `live` areas naturally drift into maintenance over time. If
you stop adding new features but keep fixing bugs, `live` still
describes the state accurately. We can add `maintenance` later if real
need shows up.

#### Auto-flip rule: planned → wip on first promotion

When you `promoteIdeaToTask` against an idea whose Area is `planned`,
the resolver bumps the area to `wip` automatically. Reasoning: the
first task being written *is* the start of work. Manual override still
works (you can flip an area back to `planned` from the UI).

The rule lives in `idea.PromoteToTask`, calls `area.AdvanceToWIPIfPlanned`,
and is no-op for any non-`planned` area. Failure to advance doesn't
fail the promotion — area drift is recoverable.

## How other entities link to it

### Idea — `area_id` is the canonical home

`Idea.subject` (legacy free string) is **kept for now** but deprecated. New
writes set `area_id`; the resolver back-fills `subject` from `area.name`
during the migration window so nothing breaks.

The `createIdea` resolver accepts either form:

- `areaID` only → load Area, copy `area.name` → `subject`. (Preferred.)
- `subject` only → `ensureAreaByName(subject)` → set `area_id`. (Legacy.)
- Neither → reject.

Once the UI never sends `subject`, we drop the column.

### Task — `area_id?` is optional opt-in

A task may or may not be tagged. When it is, the area dashboard surfaces
it. Tasks created from idea-promotion don't auto-inherit the idea's area
yet (TODO — easy follow-up).

### TaskList — `area_id?` for "the Datagrid task list"

You said: *"I create a tasklist one for Datagrid"*. With this column the
list opts into the Datagrid area; the area dashboard shows it under
**Task lists**.

Two kinds of tasklists scope nicely to areas:

- **Manual tasklist** named "Datagrid v2 launch" with `area_id =
  area_datagrid` — hand-picked tasks for the launch.
- **Smart tasklist** with a filter rule that includes `area_id =
  area_datagrid AND status = todo` — auto-collects every open Datagrid
  task without manual curation.

Both surfaces under the same area dashboard.

### Other entities — yes, eventually

Plan / Spec / Decision / Memory all benefit from `area_id?` too — they're
just not wired yet. Adding them is a one-field-per-schema change plus
column display in the area dashboard. Deferred to v2 to keep the initial
patch small.

## UI

### `/workspace/$projectId/areas` — listing

Server-paginated table. Columns: Status · Name · Created. Search by
`nameContainsFold`, status filter, "New area" dialog. Each row links to
the area's detail page.

### `/a/$areaId` — area detail

Single dashboard for one area. Three sections:

1. **Ideas** (with status pill, votes, quick view) — sorted by created.
2. **Tasks** (status pill, priority, quick view) — only non-archived.
3. **Task lists** (kind: manual / smart) — links to focused list page.

Each section has a "→" link to the full corresponding tab so you can
break out into the wider view.

The header shows the area name, status pill, description, and a "All
areas" link back to the listing.

### Area picker (`<AreaPicker>`)

Replaces the old free-text + datalist combo. Renders as a small button
trigger (`Layers` icon + current selection or "All areas"). Click →
popover with:

- Search input (server-side `nameContainsFold` lookup, debounced)
- "All areas" sentinel (only when `allowAll`)
- Up to 10 matching areas, each shown with status badge
- "Create area '<typed name>'" inline button when nothing matches and the
  user typed something — calls `ensureAreaByName` and selects the result

Used in two places today:

- **Ideas page filter bar** — pick one area or "All areas".
- **New idea dialog** — pick an area or create one inline (required field).

Future: same picker on Task / Plan / Spec / TaskList edit forms.

### Idea status picker

Replaces the static `<StatusPill>` on each Idea row with a clickable
trigger that opens a tiny popover listing the 5 statuses. Click → calls
`updateIdea(status)`, optimistically updates the row.

The detail page's promote/reject action bar still works — that's the
"opinionated path" for `idea → accepted` (with a converted task/plan FK).
The status picker is the manual override for direct flips like `idea →
duplicate` or `accepted → shipped`.

## GraphQL surface

```graphql
type Mutation {
  createArea(input: CreateAreaInput!): Area!
  updateArea(id: ID!, input: UpdateAreaInput!): Area!
  ensureAreaByName(projectID: ID!, name: String!): Area!
}

type Query {
  areas(first, after, where: AreaWhereInput, orderBy: [AreaOrder!]):
    AreaConnection!
}
```

`ensureAreaByName` is the inline-create primitive. It looks up the area by
`(project_id, slug)` and either returns it or creates one. Idempotent.
Used by the AreaPicker's "Create area" affordance.

## Use cases — worked examples

### 1. Brainstorm session for the Datagrid component

You open `/workspace/$projectId/ideas`, hit "New idea", AreaPicker shows
existing areas plus "Create area 'Datagrid'" if it doesn't exist. Pick or
create. Type "Virtual scrolling for 100k rows", paste a markdown body
sketching the API, save. 10 more like that.

Switch back to the listing, AreaPicker filter → "Datagrid". Now you see
only your Datagrid ideas. Vote, triage, promote.

### 2. Cross-area planning

Open `/workspace/$projectId/areas`. See `Datagrid · 12 ideas`,
`Diagram Viewer · 4 ideas`, `Sidebar · 2 ideas`. Click `Datagrid` → see
ideas + already-promoted tasks + task lists tagged. Spot duplicates with
Diagram Viewer? Click that area, scan its ideas.

### 3. "Datagrid is shipped, hide it from default views"

Update `Datagrid` area's status to `shipped`. The areas page default
filter is `active`, so it disappears from the default browse. Ideas
still queryable via `?status=all` or by direct URL.

### 4. Tasklist for Datagrid v2 launch

Create a static tasklist "Datagrid v2 launch", set `area_id =
area_datagrid`. Hand-pick tasks. Lists overview shows it under the
Datagrid area. Lists overview's "All lists" still shows it; area
dashboard shows it under "Task lists". Two routes, one entity.

### 5. Smart tasklist "All open Datagrid tasks"

Create a virtual tasklist with filter `kind=virtual` and rule `area_id =
area_datagrid AND status = todo`. (Filter rule support for area is a
small follow-up — todo for v2.) Auto-collects every open Datagrid task.

## Migration of existing data

Existing ideas had `subject ∈ {Datagrid, Sidebar, Combobox}`. Migration
script:

1. For each distinct subject in a project → `ensureAreaByName(...)` →
   one Area created per unique subject.
2. For each idea → set `area_id` to the matching Area.
3. `subject` column kept for back-compat.

Result: 7 ideas, 3 areas, all linked. No data loss; old queries that
read `subject` still work.

## What's not built (yet)

- Area FK on Plan / Spec / Decision / Memory — deferred. The columns will
  add cleanly when needed; UI plumbing per entity.
- Auto-inherit Area when promoting an Idea to a Task — straightforward
  follow-up: `idea.area_id → task.area_id` in `PromoteToTask`.
- Color + icon per area — deferred; just `name + status` for v1.
- Per-user voting on Ideas — still one-way `+1`. A `IdeaVote` join table
  is the right next step when team voting matters.
- Smart tasklist filter rule for `area_id` — extend `filterql` to know
  about area_id; requires both backend and the `<AreaPicker>` integration
  in the smart-list rule editor.
- Drag to reorder areas — `position` field exists; UI not wired.

## Anti-patterns

- **Don't create a new Area for every variant.** "Datagrid", "DataGrid v2",
  "Datagrid (legacy)" — bad. Either rename the existing area, or model
  versions through `status` (active vs shipped vs deprecated).
- **Don't put work-context state in Area.description.** That's what
  Specs / Memories are for — Area description is a sentence, not a
  document.
- **Don't reuse Area for short-term initiatives.** "Q3 push" is a Plan or
  a Spec, not an Area. Area = the durable thing the work touches.
- **Don't migrate `subject` ↔ `area` mid-flight.** During the deprecation
  window, read both but write only `area_id`. Drop `subject` in one
  follow-up commit once nothing reads it.

## See also

- `08-ideas-to-shipped.md` — what happens to an Idea after triage.
- `04-knowledge-retrieval.md` — how Memory/Decision differs (per-event
  vs durable surface).
