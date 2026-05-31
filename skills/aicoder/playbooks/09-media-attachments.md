# 09 — Media attachments (upload + attach to any entity)

Attach files to an entity — most usefully **proof on a run** (a screenshot, a test log, a diff). A run is one agent attempt at a task; attaching evidence to it gives the reviewer something concrete to look at before they approve or reject.

This works for **any** host, not just runs: source, task, spec, plan, decision, memory. The mechanism is the same; only the `hostType` string changes.

## The two pieces

Media is its own subsystem (`mediamgr`). It exposes exactly **two REST endpoints**; everything else is GraphQL.

| Call | Kind | Purpose |
|---|---|---|
| `POST /api/media/upload` | REST (multipart) | Upload raw bytes → returns a media row (`med_…`) |
| `GET  /api/media/:id/raw` | REST | Stream the bytes back |
| `attachMedia` / `detachMedia` | GraphQL | Link / unlink a media row to a host |
| `mediaAttachmentsByHost` | GraphQL | List what's attached to a host |

A media row is **not** attached to anything by itself. Upload first, then attach. Two steps.

## Step 1 — upload the bytes

Multipart form POST. Fields: `file` (the binary), `project_id`, and optional `folder_id`. Auth + tenancy headers are the same as every other call.

```bash
# $AICODER_HOST / $AICODER_KEY / $AICODER_WORKSPACE / $AICODER_PROJECT
# come from `eval "$(aicoder env --profile=…)"` (see SKILL.md "How you actually call it").

MEDIA_ID=$(curl -sf -X POST "$AICODER_HOST/api/media/upload" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "X-Workspace-Id: $AICODER_WORKSPACE" \
  -H "X-Project-Id: $AICODER_PROJECT" \
  -F "project_id=$AICODER_PROJECT" \
  -F "file=@/tmp/verify-screenshot.png" \
  | jq -r '.id')          # → med_…
echo "$MEDIA_ID"
```

Upload is **validated** (it's the gate, not the UI): an MIME allow-list (documents + images + structured text + zip), an extension blacklist, and a magic-byte executable detector. Renamed executables (`evil.exe` → `evil.png`) are rejected. Empty files are rejected. Screenshots (png/jpg), logs (txt), markdown, json, pdf, office docs all pass — which is everything you'd want as run proof.

## Step 2 — attach it to the host

`attachMedia(input:{ projectID, mediaID, hostType, hostID, role })`. **`hostType` is an opaque string** — `mediamgr` never validates it (the entity types live elsewhere). The convention:

| Host | `hostType` | `hostID` |
|---|---|---|
| Run | `run` | `run_…` |
| Source | `source` | `src_…` |
| Task | `task` | `tsk_…` |
| Spec | `spec` | `spec_…` |

`role` is a **free-form string** (defaults to `default`). For runs, use the canonical set the run UI renders + groups by:

| `role` | Use for |
|---|---|
| `proof` | verification evidence (the thing passed) |
| `screenshot` | a UI capture |
| `log` | test / build / run output |
| `file` | any other artifact |

```bash
gql() {
  curl -sf -X POST "$AICODER_HOST/api/dash/query" \
    -H "Authorization: Bearer $AICODER_KEY" \
    -H "X-Workspace-Id: $AICODER_WORKSPACE" \
    -H "X-Project-Id: $AICODER_PROJECT" \
    -H "Content-Type: application/json" -d "$1"
}

gql '{"query":"mutation($i: AttachMediaInput!){ attachMedia(input:$i){ id role } }",
      "variables":{"i":{
        "projectID":"'"$AICODER_PROJECT"'",
        "mediaID":"'"$MEDIA_ID"'",
        "hostType":"run",
        "hostID":"run_…",
        "role":"proof"}}}'
```

The attach is idempotent on `(mediaID, hostType, hostID, role)` — re-attaching the same file under the same role is a no-op, not a duplicate.

## List / detach

```bash
# What's attached to this run?
gql '{"query":"{ mediaAttachmentsByHost(hostType:\"run\", hostID:\"run_…\"){ id mediaID role media{ id filename mime url } } }"}'

# Detach — note: detach by the row's OWN role, not a guessed one.
gql '{"query":"mutation($i: DetachMediaInput!){ detachMedia(input:$i) }",
      "variables":{"i":{"mediaID":"'"$MEDIA_ID"'","hostType":"run","hostID":"run_…","role":"proof"}}}'
```

## The agent flow: finish a run with proof

When you (an agent) finish a run and have evidence — a screenshot from a browser check, a captured test log — attach it so the reviewer sees it:

```
1. Do the work + verify.
2. Capture evidence to a file (screenshot, log, diff).
3. POST /api/media/upload          → MEDIA_ID
4. attachMedia(hostType:"run", hostID:<run>, role:"proof", mediaID:MEDIA_ID)
5. finishRun(outcome:"success", …)
```

Attribution: register via `ensureAgent` first and pass the agent id (`createdByAgentID`) so the attachment is credited to you, not the human key owner. See `entities/Agent.md`.

## Where it shows

The run detail page renders attachments grouped by role, with a role picker on upload:

```
https://aicoder.localhost/prj/<projectID>/r/<runID>
```

(Also reachable from any task page → the run row's "Open" button.)

## Antipatterns

- **Don't** skip the upload and try to `attachMedia` a file path — `mediaID` must be a real `med_…` from `/api/media/upload`.
- **Don't** invent a new REST endpoint for media — only `upload` + `:id/raw` are REST; everything else is GraphQL.
- **Don't** attach executables — the upload gate rejects them; that's by design.
- **Don't** treat `role` as an enum on the backend — it's a free string. The `proof/screenshot/log/file` set is a frontend convention for runs; honor it so the UI groups your attachment correctly.
