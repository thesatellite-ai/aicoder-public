# prompt — attach proof to a run

Narrow template: you finished (or are finishing) a run and want to attach evidence. Full detail + list/detach + host conventions live in `playbooks/09-media-attachments.md`.

Two steps: upload bytes → attach the returned media id to the run.

```bash
# Assumes: eval "$(aicoder env --profile=…)" already exported
#   AICODER_HOST / AICODER_KEY / AICODER_WORKSPACE / AICODER_PROJECT
RUN_ID="run_…"
FILE="/tmp/proof.png"          # screenshot | log | diff | pdf — NOT an executable
ROLE="proof"                   # proof | screenshot | log | file

# 1. Upload (multipart) → media id
MEDIA_ID=$(curl -sf -X POST "$AICODER_HOST/api/media/upload" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "X-Workspace-Id: $AICODER_WORKSPACE" \
  -H "X-Project-Id: $AICODER_PROJECT" \
  -F "project_id=$AICODER_PROJECT" \
  -F "file=@${FILE}" | jq -r '.id')

# 2. Attach to the run (hostType is the opaque string "run")
curl -sf -X POST "$AICODER_HOST/api/dash/query" \
  -H "Authorization: Bearer $AICODER_KEY" \
  -H "X-Workspace-Id: $AICODER_WORKSPACE" \
  -H "X-Project-Id: $AICODER_PROJECT" \
  -H "Content-Type: application/json" \
  -d '{"query":"mutation($i: AttachMediaInput!){ attachMedia(input:$i){ id role } }",
       "variables":{"i":{
         "projectID":"'"$AICODER_PROJECT"'",
         "mediaID":"'"$MEDIA_ID"'",
         "hostType":"run",
         "hostID":"'"$RUN_ID"'",
         "role":"'"$ROLE"'"}}}'
```

Then `finishRun(...)`. Shows on `https://aicoder.localhost/prj/<projectID>/r/<runID>`.

Notes:
- `role` is a free string; for runs use `proof | screenshot | log | file` so the UI groups it.
- Register via `ensureAgent` and pass `createdByAgentID` so the attachment is credited to the agent.
- Same pattern attaches to any host — swap `hostType` (`source`/`task`/`spec`/…) + `hostID`.
