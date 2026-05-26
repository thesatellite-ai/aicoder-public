# 06 — Claude Code orchestration

How Claude Code (the CLI Claude tool you're running inside right now) specifically maps onto aicoder. This is the practical "what to do at the start/middle/end of a Claude Code session."

## Two roles

A single Claude Code session can wear either hat — sometimes both:

```
┌─ Claude Code as PLANNER ──────────────────┐
│  User says "build X"                      │
│  → I draft Spec + Plan + Tasks            │
│  → I STOP and hand off                    │
│  Cost: low (read-only on the codebase)    │
└────────────────────────────────────────────┘

┌─ Claude Code as EXECUTOR ─────────────────┐
│  User says "do task T" (after plan        │
│  approved)                                 │
│  → I startRun + setRunPlan                │
│  → I edit files, run tests                │
│  → I capture decisions + memories         │
│  → I finishRun                            │
│  Cost: high (lots of edit/test cycles)    │
└────────────────────────────────────────────┘
```

Decide which role at the top of each session based on what the user asked.

## Session start ritual

```bash
# 1. Identify the project + my agent identity
PROJECT="prj_…"                # from URL the user shared, or AICODER_PROJECT env
AGENT_NAME="claude-code-$(hostname)-$(date +%Y%m%d)"

# 2. Make sure my Agent record exists (idempotent)
AGENT=$(gql 'mutation($u:ID!,$n:String!){
  ensureAgent(userID:$u, name:$n, kind:claude_code, hostname:"'$(hostname)'", cwd:"'$PWD'", gitBranch:"'$(git branch --show-current 2>/dev/null)'") { id }
}' '{"u":"'$USER'","n":"'$AGENT_NAME'"}' | jq -r '.data.ensureAgent.id')

echo "Acting as agent: $AGENT"
```

Now every mutation can pass `actorAgentID:"$AGENT"` so the activity log shows your specific session.

## Session-start ritual: when picking up an existing task

Before doing anything, **read the entity graph for context**. This is the difference between an effective Claude Code session and one that re-litigates settled questions.

```bash
TASK=tsk_…

# 1. Read the task itself
gql '{
  tasks(first:1, where:{id:"'$TASK'"}){
    edges { node { id title description status priority kind dueDate
                   plansViaPlanTasks { edges { node { id title status spec { id title summary problem goals constraints } } } } } }
  }
}'

# 2. Read prior runs (especially any failures)
gql '{
  runs(first:5, where:{taskID:"'$TASK'"}, orderBy:{field:CREATED_AT, direction:DESC}){
    edges { node { id attempt outcome summary errorMessage createdAt } }
  }
}'

# 3. Read decisions linked to the task / its plan / its spec
gql '{
  decisions(first:10, where:{
    or:[
      {taskID:"'$TASK'"},
      {planID:"<plan-id from step 1>"}
    ]
  }, orderBy:{field:CREATED_AT, direction:DESC}){
    edges { node { id kind title decision } }
  }
}'

# 4. Read recent memories tagged for this work
# (use keywords from the task title)
```

Output to user:
```
Task: tsk_… "Wire jwtauth into Boot" (high · m · todo)
Spec goals: <…>
Plan: pln_… (active, 4 of 6 tasks done)
Prior runs: 2 attempts, both failed (ratelimit context dep)
Decisions in scope: dec_… (chain order ratelimit→jwtauth)
Memories in scope: mem_… (incident: ratelimit auth-context dep)

Resuming with the chain-order rule from dec_… and the dep documented in mem_…
Starting run.
```

## Session-end ritual

Before context fills (or before user signs off), persist state.

```bash
# 1. If a run is open, finish it (success / partial / cancelled — pick honestly)
gql '{ runs(first:5, where:{agentID:"'$AGENT'", outcome:"in_progress"}){
  edges { node { id taskID } }
}}' | jq -r '.data.runs.edges[].node.id' | while read R; do
  # Decide per run — partial work might be:
  #   finishRun outcome:"cancelled" with summary explaining state
  # OR continue + finish if the work IS in fact done
  : # handle each
done

# 2. Save a session-checkpoint memory
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'", "tag":"note",
    "title":"Claude Code session '$AGENT_NAME' — '$(date +%FT%T)'",
    "body":"## Worked on\n- '$TASK': '<status>'\n- Decisions made: '<list>'\n- Memories saved: '<list>'\n\n## Pending\n<list of unfinished items>\n\n## Resume hint\n<what next session should do first>",
    "createdByAgentID":"'$AGENT'"
  }
}' >/dev/null

# 3. Surface the session URL trail to the user
echo "Session done. State saved."
echo "Last task: https://aicoder.$HOST/t/$TASK"
echo "Last run:  https://aicoder.$HOST/t/$TASK#run-$RUN"
```

## When to use the system in Claude Code

| User input | Do |
|---|---|
| "Build feature X" / "plan X for me" | **Planner mode**: Spec + Plan + Tasks, stop |
| "What's next?" / "What should I work on?" | Read inbox + next-task query, surface options |
| "Take task T" / "do task T" | **Executor mode**: full run cycle |
| "Why did we…?" / "Have we decided…?" | Knowledge sweep, return decisions/memories |
| "I'm stuck on…" | Read context, propose options as a Decision(brainstorm) |
| "What changed today?" | Activity feed, summarize |
| "I want to remember X" | Save a Memory immediately |
| "Approve plan X" / "approve gate Y" | Verify auth context — usually requires the user to do this; you can guide |
| Trivial 1-line code change | **Don't use the system**. Fix it. |

## When to use the Web UI vs the API

```
                        Use the Web UI if…             Use the API if…
                        ──────────────────────         ──────────────────────────
Reading the system      Yes (much richer)              Only when scripting
Approving plans/gates   Yes (the canonical UX)         Only for automation tests
Free-form discussion    Yes (comments + mentions)      Yes (createCommentOn)
Mutations during a run  No (ergonomic mismatch)        Yes (this is the inner loop)
Bulk operations         No (no bulk UI yet)            Yes (loop over results)
End-of-session report   Yes (better link to UI)        n/a
```

When the user is *driving*, route them to the Web UI URL. When *you* are driving (during a run), use the API.

## Linking back to the conversation

Every important entity you create — link it back to the user in your reply, with an `https://aicoder.$HOST/<route>/<id>` URL. The user can click through.

Don't paraphrase what you saved — show the URL. Less risk of reality drift between what you said you saved and what actually got saved.

```
Created:
  Spec  https://aicoder.$HOST/s/spec_…
  Plan  https://aicoder.$HOST/p/pln_…   (status: draft, needs your approval)
  Tasks https://aicoder.$HOST/t/tsk_…
        https://aicoder.$HOST/t/tsk_…
        https://aicoder.$HOST/t/tsk_…

Approve the plan in the UI to unblock execution.
```

## Slash commands inside Claude Code (in the CLI)

If the user runs Claude Code with this skill loaded, certain phrases auto-fire:

| User says (in chat) | Claude Code behavior |
|---|---|
| "plan a feature for X" | invoke this skill, planner mode |
| "start a run on T" | invoke this skill, executor mode for task T |
| "save this as a memory" | save Memory with the current conversation context as body |
| "what did we decide about X?" | knowledge sweep, return matching Decisions |
| "show activity" | fetch + render project activity feed |
| "open gate G" / "approve gate G" | guide user (they're the human) |

These are conventions, not hard-wired magic — but the skill description in `SKILL.md` mentions them so Claude Code's auto-trigger picks them up.

## Bash helper: source this at session start

Drop into `~/.aicoder.env` or per-project `.env`:

```bash
# ~/.aicoder.env
export AICODER_HOST="api.aicoder.localhost"      # or your VPS
export AICODER_PKEY="1234"                        # dev only
export AICODER_PROJECT="prj_…"
export AICODER_USER="usr_…"

gql() {
  curl -s -X POST -H "Content-Type: application/json" \
    -d "$(jq -nc --arg q "$1" --argjson v "${2:-{\}}" '{query:$q, variables:$v}')" \
    "https://$AICODER_HOST/api/dash/query?pkey=$AICODER_PKEY"
}

# Convenience wrappers
aic-task-ls() {
  gql '{ tasks(first:20, where:{projectID:"'$AICODER_PROJECT'", archivedAtIsNil:true}, orderBy:{field:UPDATED_AT, direction:DESC}){
    edges { node { id title status priority } }
  }}' | jq -r '.data.tasks.edges[].node | "\(.status[:4])\t\(.priority[:3])\t\(.id)\t\(.title)"' | column -t -s $'\t'
}

aic-show-task() {
  gql '{ tasks(first:1, where:{id:"'$1'"}){ edges { node { id title status description } } } }' \
    | jq -r '.data.tasks.edges[0].node | "# \(.title) (\(.status))\n\n\(.description // "")"'
}

aic-board() { open "https://aicoder.${AICODER_HOST/api./}/workspace/$AICODER_PROJECT/board"; }
```

Then:
```bash
source ~/.aicoder.env
aic-task-ls
aic-show-task tsk_…
aic-board
```
