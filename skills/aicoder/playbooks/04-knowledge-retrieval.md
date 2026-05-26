# 04 — Knowledge retrieval: how prior work feeds into current work

The system is only useful if agents *read* what was written before. This playbook is the retrieval-aware agent loop.

## The "before you start" check

Every non-trivial task should begin with a knowledge sweep. The cost is one round-trip; the upside is not redoing prior work.

```bash
TASK=tsk_…
TASK_INFO=$(gql '{
  tasks(first:1, where:{id:"'$TASK'"}){
    edges { node { title description kind projectID } }
  }
}' | jq -r '.data.tasks.edges[0].node')

KEYWORDS=$(echo "$TASK_INFO" | jq -r '.title' | tr ' ' '\n' | grep -E '^[a-zA-Z]{4,}$' | head -5)
PROJECT_ID=$(echo "$TASK_INFO" | jq -r '.projectID')
```

### 1. Look for prior decisions on this topic

```bash
for KW in $KEYWORDS; do
  gql '{
    decisions(first:5, where:{
      projectID:"'$PROJECT_ID'",
      or:[
        {titleContainsFold:"'$KW'"},
        {decisionContainsFold:"'$KW'"},
        {contextContainsFold:"'$KW'"}
      ]
    }) { edges { node { id kind title decision createdAt } } }
  }'
done
```

Read the matches. If a Decision (kind=adr or choice) covers what you're about to do, *use it as input to your run plan*. Cite it explicitly:

```
The chain order ratelimit→jwtauth was decided in [dec_xyz](/d/dec_xyz). Following that.
```

### 2. Look for relevant memories

```bash
gql '{
  memories(first:10, where:{
    projectID:"'$PROJECT_ID'",
    or:[…same keyword shape…]
  }, orderBy:{field:CREATED_AT, direction:DESC}) {
    edges { node { id tag title body sourceTaskID createdAt } }
  }
}'
```

Memory tags tell you the relevance:

| Tag | What it means for your current task |
|---|---|
| `incident` | A bug was hit here before. **Read it carefully** — chance of re-occurrence is high. |
| `pattern` | A reusable shape exists. Copy it instead of reinventing. |
| `lesson` | Watch out for this gotcha. Mention in your run plan. |
| `feedback` | The user has stated a preference about this area. Honor it. |
| `note` | Background context. Skim. |

### 3. Look at backlinks of related entities

If the task is in a Plan with a Spec, fetch what mentions either:

```bash
SPEC_ID=$(gql '{ plans(first:1, where:{tasks:{id:"'$TASK'"}}){ edges { node { specID } } } }' \
  | jq -r '.data.plans.edges[0].node.specID')

# Read the spec body — its goals + constraints are your acceptance rubric
gql '{ specs(first:1, where:{id:"'$SPEC_ID'"}){
  edges { node { title summary problem goals constraints successMetrics } }
}}'

# Find decisions that reference this spec by URL pattern
gql '{
  decisions(first:20, where:{
    projectID:"'$PROJECT_ID'",
    or:[
      {decisionContains:"/s/'$SPEC_ID'"},
      {contextContains:"/s/'$SPEC_ID'"},
      {consequencesContains:"/s/'$SPEC_ID'"}
    ]
  }){ edges { node { id title decision } } }
}'
```

## Pattern: search-before-save (for memories)

Don't save a memory without checking if a similar one exists. Duplicates pollute search.

```bash
TITLE="Ratelimit middleware silently depends on auth context"

EXISTING=$(gql '{
  memories(first:3, where:{
    projectID:"'$PROJECT_ID'",
    or:[
      {titleContainsFold:"ratelimit"},
      {bodyContainsFold:"auth context"}
    ]
  }){ edges { node { id title } } }
}' | jq -r '.data.memories.edges | length')

if [ "$EXISTING" -gt 0 ]; then
  echo "Similar memory exists. Update or link instead of duplicating."
else
  gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '...'
fi
```

## Pattern: linking a memory to its citations

When a run uses a prior memory, cite it in the run summary. The Web UI renders citation chips inline, and the cited memory's "Mentioned in" rail picks up the new run's summary.

```bash
gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id } }' '{
  "i":{
    "runID":"'$RUN'",
    "outcome":"success",
    "summary":"Followed [chain-order pattern](/m/mem_chain_order) and [auth-context dep memory](/m/mem_ratelimit_auth). No new surprises."
  }
}'
```

Now `mem_chain_order`'s page will show this run as a backlink — closing the loop.

## Pattern: the "decisions hierarchy" — brainstorm → ADR

Brainstorm decisions are speculative; they're meant to be superseded. The flow:

```
Day 1: Agent A explores 3 options as kind=brainstorm
   dec_001  brainstorm  "Option A: HS256"
   dec_002  brainstorm  "Option B: RS256"
   dec_003  brainstorm  "Option C: EdDSA"

Day 2: Human + agent decide together
   dec_004  adr         "Adopt HS256 (P1)"
                        ↑ context references dec_001/2/3 via mention chips

Day 90: New constraint emerges, decision revisited
   dec_010  adr         "Migrate to RS256 (supersedes dec_004)"
                        ↑ status of dec_004 → "superseded"
```

Mark a decision as superseded:

```bash
gql 'mutation { updateDecision(id:"'$DEC_004'", input:{status: superseded}){ id status } }'
```

Reading agents see the chain and know which is current.

## Pattern: spec-driven retrieval

Before starting work on a task, the spec gives you the *contract*. Print it explicitly into your run plan:

```bash
SPEC_GOALS=$(gql '{ specs(first:1, where:{id:"'$SPEC_ID'"}){
  edges { node { title goals constraints successMetrics } }
}}' | jq -r '.data.specs.edges[0].node')

# Use these as your run plan summary's framing:
gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){ setRunPlan(...) { id } }' '{
  "id":"'$RUN'",
  "s":"Working towards spec goals: '"$(echo "$SPEC_GOALS" | jq -r '.goals|join("; ")')"'. Constraints: '"$(echo "$SPEC_GOALS" | jq -r '.constraints|join("; ")')"'. This task: <task title>.",
  "st":[…]
}'
```

The watcher now sees how this run ties to the bigger goal — and so does future-you when you read the run summary 6 months later.

## Pattern: cross-project knowledge

A pattern saved in project A might apply to project B. The system doesn't auto-suggest cross-project, but you can search across:

```bash
# Drop the projectID filter
gql '{
  memories(first:20, where:{
    tag:"pattern",
    or:[{titleContainsFold:"middleware"},{bodyContainsFold:"middleware"}]
  }){ edges { node { id projectID title body } } }
}'
```

If you find an applicable pattern, copy or paraphrase it into the current project (don't mutate the source) — and cite the original via mention chip.

## Anti-pattern: ignoring the knowledge layer

Symptoms:
- Re-debugging a known issue (incident memory exists, you didn't read it)
- Re-litigating a decided trade-off (ADR exists, your run summary contradicts it)
- Re-implementing a pattern (pattern memory exists, your code reinvents it)

Cost: hours wasted, contradictions in the codebase, user trust burned.

The knowledge sweep at the top of every run is **non-optional** for non-trivial work.

## Pattern: knowledge as agent memory

For long-running multi-session agent work, save your own context as memories so the next session of the same agent can pick up:

```bash
# At end of session, before context compresses:
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT_ID'",
    "tag":"note",
    "title":"Mid-progress: jwt migration P1 — current state",
    "body":"## Where I am\n- jwtauth pkg: done, PR merged (a1b2c3d)\n- Boot wiring: in progress, branch jwt-boot, hit ratelimit dep issue\n- Open: still need to update /api/auth/* callsites\n\n## Decisions made\n- [Place jwtauth after ratelimit](/d/dec_xyz)\n\n## Next session\n- Resume on tsk_… (Wire jwtauth into Boot)\n- Re-read /m/mem_… (ratelimit auth-context dep)\n- Pick up at step 4 of run_… (test was failing at end of last session)",
    "sourceTaskID":"'$TASK'",
    "createdByAgentID":"'$AGENT'"
  }
}'
```

The next agent session searches memories for the project, sees this note, and resumes coherently.
