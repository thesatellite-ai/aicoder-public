# 05 — Recovery: when things go wrong

Failures are first-class. The system has explicit states for them; treat them as data, not exceptions.

## Failure modes

```
                        ┌──────────────────┐
                        │   FAILURE TYPE   │
                        └────────┬─────────┘
                                 │
        ┌────────────┬───────────┼───────────┬────────────┐
        ▼            ▼           ▼           ▼            ▼
   Run failed   Step blocked  Gate         Review      Plan went
                              rejected     rejected    stale
        │            │           │           │            │
        ▼            ▼           ▼           ▼            ▼
   task→blocked  pause+gate  cancel run   task→todo   archive plan
   retry pattern  patterns   capture lesn  retry      replan
```

## Pattern 1: Run failure → retry

A run failed mid-step. Don't just restart blindly — capture what failed, fix the cause, then retry.

```bash
# 1. Examine the failed run + its steps
gql '{
  runs(first:1, where:{id:"'$RUN'"}){
    edges { node { id outcome errorKind errorMessage summary unresolved gitFiles } }
  }
  runSteps(first:20, where:{runID:"'$RUN'"}, orderBy:{field:POSITION}){
    edges { node { id position title status errorMessage notes } }
  }
}'
```

```bash
# 2. Capture an incident memory
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT_ID'",
    "tag":"incident",
    "title":"Run '$RUN' failed: <one-line cause>",
    "body":"## What happened\n<step that failed + error>\n\n## Root cause\n<your analysis>\n\n## Fix for retry\n<what will change>",
    "sourceTaskID":"'$TASK'",
    "sourceRunID":"'$RUN'"
  }
}'
```

```bash
# 3. Move task back to todo (it's currently blocked from the fail)
gql 'mutation { moveTask(taskID:"'$TASK'", status:"todo", position:0){ id } }'

# 4. Start a new run with the lessons baked in
RUN_2=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id attempt } }' \
  '{"i":{"taskID":"'$TASK'","agentID":"'$AGENT'"}}' | jq -r '.data.startRun.id')

# 5. Plan that references the prior failure + new approach
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){ setRunPlan(...) { id } }' '{
  "id":"'$RUN_2'",
  "s":"Retry of '$RUN' (failed: '"$ERROR"'). New approach: '$NEW_APPROACH'. See [incident](/m/'$MEM_INCIDENT').",
  "st":[…]
}'
```

The Web UI's task detail page now shows two stacked runs — the old failure with its summary, the new retry with its plan. Watcher sees the progression.

## Pattern 2: Step blocked → gate request

A step needs human input before it can proceed (consequential change, ambiguous design call, missing info).

```bash
# Block the step + raise a gate, atomically as far as the watcher is concerned
gql 'mutation { blockStep(stepID:"'$STEP'", reason:"Needs human approval — see gate"){ id } }'

GATE=$(gql 'mutation($i:RequestGateInput!){ requestGate(input:$i){ id } }' '{
  "i":{
    "taskID":"'$TASK'",
    "runID":"'$RUN'",
    "reason":"About to drop saas/pkg/auth/session.go. Confirm v1 mobile clients fully migrated (last v1 ping was 2026-04-12)."
  }
}' | jq -r '.data.requestGate.id')

# Now wait. Don't busy-loop — sleep + poll.
while true; do
  S=$(gql '{ gates(first:1, where:{id:"'$GATE'"}){edges{node{status note}}} }' \
    | jq -r '.data.gates.edges[0].node.status')
  case "$S" in
    open)
      sleep 60
      ;;
    approved)
      gql 'mutation { startStep(stepID:"'$STEP'"){ id } }'   # unblock
      break
      ;;
    rejected)
      NOTE=$(gql '...' | jq -r '...note')
      # Cancel the run cleanly — don't leave it in_progress
      gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id } }' \
        '{"i":{"runID":"'$RUN'","outcome":"cancelled","summary":"Gate '$GATE' rejected: '"$NOTE"'"}}'
      # Capture a decision so the rejection is searchable
      gql 'mutation($i:CreateDecisionInput!){ createDecision(input:$i){ id } }' '{
        "i":{
          "projectID":"'$PROJECT_ID'","taskID":"'$TASK'","runID":"'$RUN'",
          "kind":"choice",
          "title":"Deferred: legacy session middleware removal",
          "context":"Attempted in run '$RUN', gated for review.",
          "decision":"Defer until v1 mobile sunset.",
          "alternatives":["Remove now (rejected — v1 still in use)"],
          "consequences":"Add a tracking task for 2026-08-12 to revisit."
        }
      }'
      exit 0
      ;;
  esac
done
```

## Pattern 3: Review rejected → request_changes loop

The reviewer agent rejects the run output and asks for changes.

```bash
# After postReview verdict=request_changes, task is back to todo.
# Read the feedback:
FEEDBACK=$(gql '{
  reviews(first:1, where:{taskID:"'$TASK'", verdict:"request_changes"}, orderBy:{field:CREATED_AT, direction:DESC}){
    edges { node { feedback feedbackStructured reviewerAgentID } }
  }
}' | jq -r '.data.reviews.edges[0].node.feedback')

echo "Reviewer wants: $FEEDBACK"
```

```bash
# Start a new run that explicitly addresses the feedback
RUN_3=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id } }' '...' | jq -r '.data.startRun.id')

gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){ setRunPlan(...) { id } }' '{
  "id":"'$RUN_3'",
  "s":"Address review feedback from rev_… : '"$FEEDBACK"'. Adding chain-order assertion test as requested.",
  "st":[
    {"title":"add chain-order assertion test", "rationale":"reviewer requirement", "position":1},
    {"title":"task test (verify it fails on bad order, passes on good)", "rationale":"prove the test is real", "position":2},
    {"title":"update run summary", "rationale":"so reviewer sees the addition", "position":3}
  ]
}'
```

## Pattern 4: Plan went stale (replan)

Sometimes a plan's strategy is invalidated mid-execution (constraint change, external blocker, learnings showed the approach is wrong).

```bash
# 1. Cancel the current plan — don't leave it active with mismatched tasks
gql 'mutation { updatePlan(id:"'$PLAN'", input:{status: cancelled}){ id status } }'

# 2. Move in-flight tasks back to todo or archive them
gql '{ tasks(first:50, where:{plansVia:{id:"'$PLAN'"}, statusNotIn:["done","cancelled"]}){
  edges { node { id status } }
}}'
# For each:
#   if it's still useful → moveTask back to todo, remove from plan
#   if obsolete → archiveTask

# 3. Save a memory explaining what changed and why we replanned
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT_ID'","tag":"lesson",
    "title":"Replanned auth migration — RS256 chosen mid-flight",
    "body":"## Why we replanned\nMid-execution discovery: legal flagged HS256 single-secret as compliance risk. Switching to RS256 with rotated keypair.\n\n## Plan that was killed\n[Old plan](/p/'$PLAN') — status cancelled.\n\n## New plan\n[New plan](/p/'$NEW_PLAN') — RS256 strategy.\n\n## Tasks salvaged vs dropped\n…"
  }
}'

# 4. Create the new plan + tasks
NEW_PLAN=$(gql '...createPlan...' | jq -r '.id')
```

## Pattern 5: Stuck → ask the user

You're stuck. The decision needs human input that no Gate or memory will solve. Use a polymorphic comment on the entity that's stuck:

```bash
gql 'mutation($i:CreatePolyCommentInput!){ createCommentOn(input:$i){ id } }' '{
  "i":{
    "taskID":"'$TASK'",
    "body":"Stuck on this. Two viable approaches:\n\n1. Refactor ratelimit to be auth-agnostic (cleanest but ~3 days, out of P1 scope)\n2. Document the dep + add chain-order test (cheap, leaves the implicit dep)\n\nLeaning option 2 for P1; will write an ADR and a P2 ticket for option 1. **Confirm?**",
    "authorAgentID":"'$AGENT'"
  }
}'

# Block your run on a Gate so progress doesn't continue silently
gql 'mutation($i:RequestGateInput!){ requestGate(input:$i){ id } }' '{
  "i":{"taskID":"'$TASK'","runID":"'$RUN'","reason":"Awaiting user confirmation on approach — see comment"}
}'
```

## Pattern 6: Lost session / context recovery

A Claude session ends mid-work. Next session needs to resume without forgetting state.

```bash
# Mid-session checkpoint memory (do this before context fills)
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT_ID'","tag":"note",
    "title":"Session checkpoint — '$(date +%FT%T)'",
    "body":"## Active task: '$TASK'\n## Active run: '$RUN' (in_progress)\n## Steps completed: 1, 2, 3\n## Steps remaining: 4 (test), 5 (verify)\n## Open question: <if any>\n## Last code state: branch=jwt-boot, sha=a1b2c3d, dirty=true\n## Resume:\n1. Read /t/'$TASK'\n2. Pull steps where status=pending: gql ...\n3. Continue from step 4",
    "sourceTaskID":"'$TASK'",
    "sourceRunID":"'$RUN'"
  }
}'
```

Next session:

```bash
# Resume protocol
LATEST_NOTE=$(gql '{
  memories(first:1, where:{
    projectID:"'$PROJECT_ID'", tag:"note",
    titleContainsFold:"Session checkpoint"
  }, orderBy:{field:CREATED_AT, direction:DESC}){
    edges { node { id body sourceRunID sourceTaskID } }
  }
}')

# Read the body, find the active run, pick up where you left off
```

## Pattern 7: Garbage collection — abandoned runs

Runs sometimes get orphaned (process killed, network died, agent crashed). Periodically cancel anything stuck:

```bash
# Runs in_progress for >2 hours with no recent steps — likely orphans
gql '{
  runs(first:50, where:{
    outcome:"in_progress",
    startedAtLT:"'$(date -v-2H -u +%FT%TZ)'"
  }){
    edges { node { id taskID startedAt agentID } }
  }
}' | jq -r '.data.runs.edges[].node.id' | while read RUN; do
  echo "Cancelling orphaned $RUN"
  gql 'mutation { cancelRun(runID:"'$RUN'"){ id } }'
done
```

Pair with a memory entry describing the orphan situation if recurring — it's likely a bug worth fixing.

## What NOT to do under failure

| Don't | Why | Do instead |
|---|---|---|
| Silently retry without capturing the failure | Future you can't tell what was tried | Save an incident memory before retrying |
| Mutate a failed run's outcome to "success" | Activity log gets corrupted | Start a new run; the old one stays as evidence |
| Delete decisions after a project pivot | Decisions are append-only history | Mark old ones `superseded`, write a new one |
| Skip the postReview when a run is rejected | Reviewer feedback is the trail | Always `postReview` even for rejection |
| Bury a Gate denial without explanation | The next agent will repeat the attempt | Capture a Decision documenting the rejection + why |

## Recovery is data

Every failure path here leaves searchable evidence: incident memories, cancelled runs, rejected gates, superseded decisions, replan-lesson memories. That's the system working as designed — failures are *information for next time*, not noise to suppress.
