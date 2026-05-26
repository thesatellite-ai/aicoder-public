# postmortem

A Run finished — successful or failed. Capture the residual value: lessons + decisions + summary.

## Steps

1. **Finish the run** with a 1-paragraph summary (see run-checklist.md for the full call).

2. **Save lessons.** For each *portable* thing learned (helps next time, on a different task):
    ```bash
    gql 'mutation($i:CreateMemoryInput!) { createMemory(input:$i) { id } }' \
      '{"i":{"projectID":"prj_…","tag":"lesson","title":"<5–10 words>","body":"<1–3 paragraphs>","sourceTaskID":"tsk_…","sourceRunID":"run_…"}}'
    ```
    Tag picker:
    - `lesson` — would tell a teammate over coffee
    - `pattern` — reusable code / config / doc shape
    - `incident` — bug + fix
    - `feedback` — user said "do/don't X" — verbatim
    - `note` — interesting but not yet a pattern

3. **Capture decisions** that emerged during the run (if not already recorded). Especially:
    - Trade-offs you made because of time / scope
    - Things you did *differently* than the plan suggested

4. **Surface to user.** End with:
    - Outcome (success / fail / partial)
    - 1-line of what shipped (or what's blocking)
    - Saved memory / decision IDs as Web UI links

## Antipatterns

- Saving every step as a memory — only *portable* ones.
- Recording the same lesson twice. Search first:
    ```bash
    gql '{ memories(first:5, where:{projectID:"prj_…", titleContainsFold:"<keyword>"}) { edges { node { id title } } } }'
    ```
- Skipping postmortem on success — successful runs often have the best lessons.

## Template output

```
Run <run-id> · success · "extract term streaming into pkg"
- 4 files changed: pkg/term/{stream,attach,record}.go
- saved memories: https://aicoder.$HOST/m/mem_abc, /m/mem_def
- decision: https://aicoder.$HOST/d/dec_xyz (chose pkg-level isolation over inline)
- next: human review on PR #123
```
