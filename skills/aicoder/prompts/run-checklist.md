# run-checklist

Started a Run on a Task. Declare your plan **before** doing the work — the watcher (human or agent) sees a live checklist on `/t/<task>`.

## Why

Without a plan step, the watcher sees a black-box run — they wait for `finish` to know what you did. Always plan first, even for simple runs.

## Start the run

```bash
RUN=$(gql 'mutation($i:StartRunInput!) { startRun(input:$i) { id attempt } }' \
  '{"i":{"taskID":"tsk_…","model":"claude-opus-4-7"}}' | jq -r '.data.startRun.id')
```

## Set the plan

```bash
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!) { setRunPlan(runID:$id, summary:$s, steps:$st) { id } }' \
  '{"id":"'$RUN'","s":"<paragraph: what you are about to attempt>","st":[
    {"title":"read the relevant files","rationale":"get current state","position":1},
    {"title":"identify the change","rationale":"write down the new state","position":2},
    {"title":"make the change","rationale":"edit the files","position":3},
    {"title":"verify","rationale":"run task test","position":4}
  ]}'
```

## Step format

- Title is **verb-first, present tense**: "read X", "write Y", "verify Z" — not "reading", "should write".
- Rationale answers **why this step?**, not **what does this step do?** — the title is the what.
- 3–8 steps. Fewer than 3, you're under-planning. More than 8, the task is too big — split it.

## Walking the steps

```bash
gql 'mutation { startStep(stepID:"stp_…") { id status } }'
gql 'mutation { completeStep(stepID:"stp_…", notes:"Done; 4 files changed.", output:{files:4}) { id } }'
gql 'mutation { skipStep(stepID:"stp_…", reason:"…") { id } }'
gql 'mutation { failStep(stepID:"stp_…", errorMessage:"…") { id } }'
gql 'mutation { blockStep(stepID:"stp_…", reason:"need approval") { id } }'   # pair with requestGate
```

## Finishing

```bash
gql 'mutation($i:FinishRunInput!) { finishRun(input:$i) { id outcome } }' \
  '{"i":{"runID":"'$RUN'","outcome":"success","summary":"<one paragraph>","costUsd":0.42,"tokensIn":12500,"tokensOut":3200,"durationMs":142000,"gitCommitSha":"abcd1234","gitFiles":["path/a","path/b"]}}'
```

If `outcome:"fail"`, the parent Task transitions to `blocked` and a Review may be required.
