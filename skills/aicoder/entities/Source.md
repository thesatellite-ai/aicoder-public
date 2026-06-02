# Source

Per-entity reference for the `Source` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Enums used by this entity

GraphQL enum literals are **bare identifiers**, never quoted strings. `kind: DIAGRAM` not `kind: "DIAGRAM"`. See SKILL.md → "GraphQL gotchas".

| Enum | Valid values |
|---|---|
| `SourceKind` | `NOTE`, `LINK`, `TRANSCRIPT`, `CHAT`, `DIAGRAM`, `RECORDING`, `SCREENSHOT` |
| `SourceBodyFormat` | `MARKDOWN`, `PLAIN`, `CODE`, `JSON`, `EXCALIDRAW`, `TLDRAW`, `STATEMACHINE` |

Common pairings:

- Tldraw diagram → `kind: DIAGRAM`, `bodyFormat: TLDRAW`
- Excalidraw diagram → `kind: DIAGRAM`, `bodyFormat: EXCALIDRAW`
- Markdown note → `kind: NOTE`, `bodyFormat: MARKDOWN`
- Web link → `kind: LINK`, `bodyFormat: PLAIN`
- Chat transcript → `kind: CHAT`, `bodyFormat: MARKDOWN`
- XState state machine → `kind: NOTE`, `bodyFormat: STATEMACHINE`

## Body content shape per `bodyFormat` (read this before writing `body`)

`body` is **always a string**. For text formats it's the literal text; for diagram/structured formats it's a JSON string the renderer parses on read. The renderer is strict — wrong shape silently renders blank.

### `MARKDOWN`, `PLAIN`, `CODE`

Plain string. No envelope, no JSON. Newlines are real newlines (escape `\n` in GraphQL string literals).

```
# Heading

Some text.

- item 1
- item 2
```

### `JSON`

A JSON document — you stringify whatever object you want and store the resulting string. The renderer pretty-prints it.

```json
{"any":"shape","you":["want"],"nested":{"is":"fine"}}
```

### `STATEMACHINE`

An **XState v5 statechart**, rendered as an interactive diagram (graph + live simulator + self-running tests), laid out with ELK like Stately. `body` is a JSON string in one of two shapes:

```jsonc
// preferred — machine + optional tests
{ "machine": <xstate-config>, "tests": [ { "name": "...", "steps": [{ "event": "E" }], "expect": { "state": "X" } } ] }
// also accepted — a bare XState config (tests default to [])
<xstate-config>
```

Supported XState features (all rendered as edges/nodes): `id`, `description`, `initial`; `states` (a state with its own `states` is **compound**; `type:"final"` for finals; `{}` is a valid leaf); `on` event transitions (array of guarded branches, first-match-wins, or `{EVENT:"target"}` shorthand); **`after`** delayed transitions; **`onDone`** on compounds; `guard` (string or `{type}`); `actions` (string / `{type,params}` / array); targets as a sibling name or an absolute id `#MachineId.PARENT.CHILD`.

Minimal example body:

```json
{"machine":{"id":"toggle","initial":"off","states":{"off":{"description":"idle","on":{"FLIP":"on"}},"on":{"on":{"FLIP":"off"}}}},"tests":[{"name":"flip on","steps":[{"event":"FLIP"}],"expect":{"state":"on"}}]}
```

The renderer's contract (arrow direction, node order, hierarchy, label placement) is documented and regression-tested in the frontend repo at `src/components/smart-rich-editor/parts/statemachine/FLOW.md`.

### `EXCALIDRAW`

**Canonical shape — use exactly these top-level keys, nothing else:**

```json
{
  "elements": [],
  "appState": {"viewBackgroundColor": "#ffffff", "gridSize": 20},
  "files": {}
}
```

Required: `elements` (array) + `appState` (object). Optional: `files` (object — only needed if your scene embeds images; otherwise pass `{}` or omit).

**Do NOT include** `type`, `version`, `source` — those are the wrapper keys Excalidraw adds when you **download** a `.excalidraw` file. They belong on disk, not in our DB. Storing them bloats the row, drifts with Excalidraw version bumps, and obscures the actual scene content. The renderer ignores them today, but treat them as forbidden so future strict validation can't break your data.

Workflow to produce a real scene:

1. Draw in <https://excalidraw.com>
2. Menu → "Save to … JSON" → opens the downloaded file
3. Take ONLY `elements` and `appState` from that file
4. Wrap as `{elements, appState, files: {}}` and store as the `body` string

Full element example (single rectangle):

```json
{
  "elements": [
    {
      "id": "rect-1",
      "type": "rectangle",
      "x": 100, "y": 100,
      "width": 240, "height": 120,
      "angle": 0,
      "strokeColor": "#1e1e1e",
      "backgroundColor": "transparent",
      "fillStyle": "solid",
      "strokeWidth": 2,
      "strokeStyle": "solid",
      "roughness": 1,
      "opacity": 100,
      "groupIds": [],
      "frameId": null,
      "index": "a0",
      "roundness": {"type": 3},
      "seed": 1,
      "version": 1,
      "versionNonce": 1,
      "isDeleted": false,
      "boundElements": null,
      "updated": 0,
      "link": null,
      "locked": false
    }
  ],
  "appState": {
    "viewBackgroundColor": "#ffffff",
    "gridSize": 20
  },
  "files": {}
}
```

Schema reference: <https://github.com/excalidraw/excalidraw/blob/master/dev-docs/docs/codebase/json-schema.mdx>

### `TLDRAW`

**Canonical shape — exactly two top-level keys: `document` + `session`.** This is the runtime store snapshot returned by `editor.store.getSnapshot()`, which the renderer feeds to `loadSnapshot()`. **It is NOT the same as the `.tldr` export file** — `.tldr` files won't render.

> ⚠ **Do NOT hand-author shape records for tldraw 5+.** Every shape type has a strict per-version prop schema enforced by `loadSnapshot()`. Recent versions made the label a **TipTap richText document**, not a plain string — `text` is no longer a valid prop on geo / note / arrow / text shapes. Get a single prop wrong → the validator silently rejects the snapshot → blank canvas with no error. The shape props also evolve every minor tldraw release. **Generating snapshots by hand is a footgun. Use the DevTools recipe below.**

**The only reliable workflow** (use this for every diagram, including 2-shape mockups):

1. Open <https://tldraw.com> (or whatever tldraw build matches the deployed version — check `node_modules/tldraw/package.json` if unsure)
2. Draw the diagram
3. Open browser DevTools → console
4. Run: `copy(JSON.stringify(editor.store.getSnapshot()))`
5. Paste the clipboard contents as the `body` string

If you don't have a browser available (running headless from an agent), produce a `.tldr`-shape Source as a `bodyFormat: MARKDOWN` placeholder with a TODO instead and surface the limitation to the user — that's strictly better than shipping a broken snapshot.

**What goes wrong when you hand-author** (every one of these caused a blank canvas before the renderer hardening — read each row to know what's still strict vs auto-fixed):

| Symptom | Cause | Status |
|---|---|---|
| ~~`Expected an index key, got "<X>"`~~ | tldraw uses **fractional indexing** for the `index` field on every record. The format is strict — most "obvious" keys you'd reach for are INVALID:<br><br>**❌ Never use:** `a0` (reserved sentinel — beginning-of-list marker, not a usable index), `a10`/`a11`/`b15` (two-digit numeric suffixes — the `0`/digit after another digit is a format reserved char), plain integers like `0`, `1`, `2`, plain strings like `"first"`, `"x"`, `"shape-1"`.<br><br>**✓ Valid alphabet:** `a1, a2, …, a9, aA, aB, …, aZ, aa, ab, …, az, b1, b2, …`. Always starts with a lowercase bucket letter (`a`–`z`), then ONE char from `[1-9 A-Z a-z]`. To go past `a9` in one bucket, jump to `aA` — never `a10`. To go past `az`, jump to bucket `b1`. | **AUTO-FIXED.** The renderer sanitizes the snapshot before `loadSnapshot()` — invalid indices (including `a0`, `a10`, integers, garbage) are rewritten to fresh valid keys using tldraw's own `getIndices(n)` helper, preserving dictionary-insertion order per `parentId`. So you CAN emit `a10, a11, …` and it'll render. Still prefer canonical keys so the DB carries clean data and so the sanitizer is a safety net, not a crutch. |
| Blank canvas, no console error → red overlay says `richText: required` | `props.text` used instead of `props.richText` (tldraw 5+ migration v10–11). `richText` is required on every label-bearing shape (`geo`, `text`, `note`, `arrow`) and is a TipTap document, not a string. | **STILL STRICT.** Always emit `richText: {type:"doc",content:[{type:"paragraph",content:[{type:"text",text:"…"}]}]}`. Empty label → `richText: {type:"doc",content:[]}`. |
| Blank canvas | `schema.sequences` declares a version higher than what your records actually conform to (e.g. `com.tldraw.shape.geo: 11` but shapes still use the v9 prop shape) | Still strict — emit the same `sequences` block as the skeleton below. |
| Blank canvas | Missing required prop on a shape (e.g. `growY`, `scale`, `verticalAlign`, `font`, `align`, `richText`) | Still strict — copy ALL props from the skeleton, don't trim what looks unused. |
| Blank canvas | `session.currentPageId` references a `page:` id that isn't in `document.store` | Still strict — `currentPageId` must match a page record. |
| Blank canvas | A `shape:*` record has `parentId` pointing at a non-existent page/shape | Still strict — parentId must resolve to a `page:` or another `shape:`. |

**How to see what the renderer rejected:** if the canvas is blank, open the Source page and look for a red overlay in the top-left of the canvas — it surfaces `loadSnapshot`'s exact validator message (e.g. `At shape(type = geo).props.richText: Expected an object, got undefined`). The overlay is also logged to the browser console. Use the message to fix your snapshot.

**Renderer guarantee (current behaviour):** the only thing auto-fixed is fractional indices. Everything else is strict — you must emit what tldraw 5's validator expects. The sanitizer is a forgiveness layer for the most-mistaken field, not a free pass on shape correctness.

There is no error telemetry — `loadSnapshot` swallows validation failures by design. Debug by opening the page, then in console: `JSON.stringify(editor.store.getSnapshot())` BEFORE loading your body, compare structure to yours.

For tldraw versions installed in this repo, check `node_modules/@tldraw/tlschema/dist-cjs/shapes/TL<Shape>Shape.js` to see the exact prop schema enforced. As of tldraw 5.0 (latest tested):

- `geo`, `note`, `text`, `arrow` shapes label = `richText: {type:"doc",content:[…]}` (TipTap JSON), NOT a string
- `line`, `draw` shapes have no label
- All shapes require `meta: {}`, `parentId`, `index`, `typeName`, `id`

The first time an agent ships a tldraw Source in a new repo, **assume hand-authoring will fail** and use the DevTools recipe even for trivial diagrams.

```json
{
  "document": {
    "store": {
      "document:document": {"gridSize": 10, "name": "", "meta": {}, "id": "document:document", "typeName": "document"},
      "page:page": {"meta": {}, "id": "page:page", "name": "Page 1", "index": "a1", "typeName": "page"},
      "shape:rect-1": {
        "x": 100, "y": 100,
        "rotation": 0,
        "isLocked": false,
        "opacity": 1,
        "meta": {},
        "id": "shape:rect-1",
        "type": "geo",
        "parentId": "page:page",
        "index": "a1",
        "typeName": "shape",
        "props": {
          "w": 240, "h": 120,
          "geo": "rectangle",
          "color": "black",
          "fill": "none",
          "dash": "draw",
          "size": "m",
          "labelColor": "black",
          "font": "draw",
          "align": "middle",
          "verticalAlign": "middle",
          "growY": 0,
          "url": "",
          "scale": 1,
          "richText": {"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"My label"}]}]}
        }
      }
    },
    "schema": {
      "schemaVersion": 2,
      "sequences": {
        "com.tldraw.store": 5,
        "com.tldraw.document": 2,
        "com.tldraw.page": 1,
        "com.tldraw.shape": 4,
        "com.tldraw.shape.geo": 11
      }
    }
  },
  "session": {
    "version": 0,
    "currentPageId": "page:page",
    "exportBackground": true,
    "isFocusMode": false,
    "isDebugMode": false,
    "isToolLocked": false,
    "isGridMode": false,
    "pageStates": [
      {"pageId": "page:page", "camera": {"x": 0, "y": 0, "z": 1}, "selectedShapeIds": [], "focusedGroupId": null}
    ]
  }
}
```

Reference: <https://tldraw.dev/reference/store/getSnapshot>

### Sending the body via curl

Two reliable patterns:

**A) Inline JSON inside the GraphQL string** (small bodies only — escape `"` as `\"`):

```bash
-d '{"query":"mutation { createSource(input:{projectID:\"prj_…\", kind:DIAGRAM, bodyFormat:EXCALIDRAW, title:\"Mockup\", body:\"{\\\"elements\\\":[],\\\"appState\\\":{\\\"viewBackgroundColor\\\":\\\"#fff\\\"}}\"}) { id } }"}'
```

**B) GraphQL variables + `jq -nc`** (recommended — no escaping):

```bash
BODY=$(jq -nc '{elements:[], appState:{viewBackgroundColor:"#ffffff", gridSize:20}, files:{}}')
jq -nc \
  --arg q 'mutation($body:String!){ createSource(input:{projectID:"prj_…", kind:DIAGRAM, bodyFormat:EXCALIDRAW, title:"Mockup", body:$body}){id} }' \
  --arg body "$BODY" \
  '{query:$q, variables:{body:$body}}' \
| curl -sf -X POST "$AICODER_HOST/api/dash/query" \
    -H "Authorization: Bearer $AICODER_KEY" \
    -H "X-Workspace-Id: $AICODER_WORKSPACE" \
    -H "X-Project-Id: $AICODER_PROJECT" \
    -H "Content-Type: application/json" \
    -d @-
```

## Object type

_Defined in `ent.graphql`._

```graphql
type Source implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  areaID: ID
  kind: SourceKind!
  bodyFormat: SourceBodyFormat!
  title: String!
  summary: String
  body: String
  externalURL: String
  fileID: String
  mime: String
  tags: [String!]
  capturedByUserID: String
  capturedByAgentID: String
  archivedAt: Time
  project: Project!
  area: Area
}
```

## Create input

```graphql
input CreateSourceInput {
  workspaceID: String
  kind: SourceKind
  bodyFormat: SourceBodyFormat
  title: String!
  summary: String
  body: String
  externalURL: String
  fileID: String
  mime: String
  tags: [String!]
  capturedByUserID: String
  capturedByAgentID: String
  archivedAt: Time
  projectID: ID!
  areaID: ID
}
```

## Update input

```graphql
input UpdateSourceInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  kind: SourceKind
  bodyFormat: SourceBodyFormat
  title: String
  summary: String
  clearSummary: Boolean
  body: String
  clearBody: Boolean
  externalURL: String
  clearExternalURL: Boolean
  fileID: String
  clearFileID: Boolean
  mime: String
  clearMime: Boolean
  tags: [String!]
  appendTags: [String!]
  clearTags: Boolean
  capturedByUserID: String
  clearCapturedByUserID: Boolean
  capturedByAgentID: String
  clearCapturedByAgentID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  areaID: ID
  clearArea: Boolean
}
```

## Where filter (top-level connection)

```graphql
input SourceWhereInput {
  not: SourceWhereInput
  and: [SourceWhereInput!]
  or: [SourceWhereInput!]
  """
  id field predicates
  """
  id: ID
  idNEQ: ID
  idIn: [ID!]
  idNotIn: [ID!]
  idGT: ID
  idGTE: ID
  idLT: ID
  idLTE: ID
  idEqualFold: ID
  idContainsFold: ID
  """
  workspace_id field predicates
  """
  workspaceID: String
  workspaceIDNEQ: String
  workspaceIDIn: [String!]
  workspaceIDNotIn: [String!]
  workspaceIDGT: String
  workspaceIDGTE: String
  workspaceIDLT: String
  workspaceIDLTE: String
  workspaceIDContains: String
  workspaceIDHasPrefix: String
  workspaceIDHasSuffix: String
  workspaceIDIsNil: Boolean
  workspaceIDNotNil: Boolean
  workspaceIDEqualFold: String
  workspaceIDContainsFold: String
  """
  created_at field predicates
  """
  createdAt: Time
  createdAtNEQ: Time
  createdAtIn: [Time!]
  createdAtNotIn: [Time!]
  createdAtGT: Time
  createdAtGTE: Time
  createdAtLT: Time
  createdAtLTE: Time
  createdAtIsNil: Boolean
  createdAtNotNil: Boolean
  """
  updated_at field predicates
  """
  updatedAt: Time
  updatedAtNEQ: Time
  updatedAtIn: [Time!]
  updatedAtNotIn: [Time!]
  updatedAtGT: Time
  updatedAtGTE: Time
  updatedAtLT: Time
  updatedAtLTE: Time
  updatedAtIsNil: Boolean
  updatedAtNotNil: Boolean
  """
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  kind field predicates
  """
  kind: SourceKind
  kindNEQ: SourceKind
  kindIn: [SourceKind!]
  kindNotIn: [SourceKind!]
  """
  body_format field predicates
  """
  bodyFormat: SourceBodyFormat
  bodyFormatNEQ: SourceBodyFormat
  bodyFormatIn: [SourceBodyFormat!]
  bodyFormatNotIn: [SourceBodyFormat!]
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  summary field predicates
  """
  summary: String
  summaryNEQ: String
  summaryIn: [String!]
  summaryNotIn: [String!]
  summaryGT: String
  summaryGTE: String
  summaryLT: String
  summaryLTE: String
  summaryContains: String
  summaryHasPrefix: String
  summaryHasSuffix: String
  summaryIsNil: Boolean
  summaryNotNil: Boolean
  summaryEqualFold: String
  summaryContainsFold: String
  """
  body field predicates
  """
  body: String
  bodyNEQ: String
  bodyIn: [String!]
  bodyNotIn: [String!]
  bodyGT: String
  bodyGTE: String
  bodyLT: String
  bodyLTE: String
  bodyContains: String
  bodyHasPrefix: String
  bodyHasSuffix: String
  bodyIsNil: Boolean
  bodyNotNil: Boolean
  bodyEqualFold: String
  bodyContainsFold: String
  """
  external_url field predicates
  """
  externalURL: String
  externalURLNEQ: String
  externalURLIn: [String!]
  externalURLNotIn: [String!]
  externalURLGT: String
  externalURLGTE: String
  externalURLLT: String
  externalURLLTE: String
  externalURLContains: String
  externalURLHasPrefix: String
  externalURLHasSuffix: String
  externalURLIsNil: Boolean
  externalURLNotNil: Boolean
  externalURLEqualFold: String
  externalURLContainsFold: String
  """
  file_id field predicates
  """
  fileID: String
  fileIDNEQ: String
  fileIDIn: [String!]
  fileIDNotIn: [String!]
  fileIDGT: String
  fileIDGTE: String
  fileIDLT: String
  fileIDLTE: String
  fileIDContains: String
  fileIDHasPrefix: String
  fileIDHasSuffix: String
  fileIDIsNil: Boolean
  fileIDNotNil: Boolean
  fileIDEqualFold: String
  fileIDContainsFold: String
  """
  mime field predicates
  """
  mime: String
  mimeNEQ: String
  mimeIn: [String!]
  mimeNotIn: [String!]
  mimeGT: String
  mimeGTE: String
  mimeLT: String
  mimeLTE: String
  mimeContains: String
  mimeHasPrefix: String
  mimeHasSuffix: String
  mimeIsNil: Boolean
  mimeNotNil: Boolean
  mimeEqualFold: String
  mimeContainsFold: String
  """
  captured_by_user_id field predicates
  """
  capturedByUserID: String
  capturedByUserIDNEQ: String
  capturedByUserIDIn: [String!]
  capturedByUserIDNotIn: [String!]
  capturedByUserIDGT: String
  capturedByUserIDGTE: String
  capturedByUserIDLT: String
  capturedByUserIDLTE: String
  capturedByUserIDContains: String
  capturedByUserIDHasPrefix: String
  capturedByUserIDHasSuffix: String
  capturedByUserIDIsNil: Boolean
  capturedByUserIDNotNil: Boolean
  capturedByUserIDEqualFold: String
  capturedByUserIDContainsFold: String
  """
  captured_by_agent_id field predicates
  """
  capturedByAgentID: String
  capturedByAgentIDNEQ: String
  capturedByAgentIDIn: [String!]
  capturedByAgentIDNotIn: [String!]
  capturedByAgentIDGT: String
  capturedByAgentIDGTE: String
  capturedByAgentIDLT: String
  capturedByAgentIDLTE: String
  capturedByAgentIDContains: String
  capturedByAgentIDHasPrefix: String
  capturedByAgentIDHasSuffix: String
  capturedByAgentIDIsNil: Boolean
  capturedByAgentIDNotNil: Boolean
  capturedByAgentIDEqualFold: String
  capturedByAgentIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
}
```

## Related queries (1)

```graphql
  sources(
    """
    Returns the elements in the list that come after the specified cursor.
    """
    after: Cursor
    """
    Returns the first _n_ elements from the list.
    """
    first: Int
    """
    Returns the elements in the list that come before the specified cursor.
    """
    before: Cursor
    """
    Returns the last _n_ elements from the list.
    """
    last: Int
    """
    Ordering options for Sources returned from the connection.
    """
    orderBy: [SourceOrder!]
    """
    Filtering options for Sources returned from the connection.
    """
    where: SourceWhereInput
  ): SourceConnection!
```

## Related mutations (4)

```graphql
  archiveSource(id: ID!): Source!
  createSource(input: CreateSourceInput!): Source!
  unarchiveSource(id: ID!): Source!
  updateSource(id: ID!, input: UpdateSourceInput!): Source!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
