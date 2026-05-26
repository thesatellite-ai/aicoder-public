# start-feature

User asks for a new feature. Set up Spec + Plan + Tasks via the GraphQL API before doing any work.

Assumes you've defined the `gql` shell helper from SKILL.md (curl + jq → POST to `https://$HOST/api/dash/query`).

## Steps

1. **Read the ask twice.** Identify:
    - Problem (what's broken / missing)
    - Goal (what "done" looks like — outcome, not output)
    - Constraints (tech, time, scope)

2. **Spec.**
    ```bash
    gql 'mutation($i:CreateSpecInput!) { createSpec(input:$i) { id } }' \
      '{"i":{"projectID":"prj_…","title":"<2–7 words>","summary":"<one paragraph>","problem":"<the problem>","goals":["<g1>","<g2>","<g3>"]}}'
    ```

3. **Plan.**
    ```bash
    gql 'mutation($i:CreatePlanInput!) { createPlan(input:$i) { id } }' \
      '{"i":{"projectID":"prj_…","specID":"spec_…","title":"<plan name>","strategy":"<paragraph: approach, what we touch, what we do not>"}}'
    ```

4. **Tasks.** 3–8. Verb-first titles. Each scoped to one Claude session.
    ```bash
    gql 'mutation($i:CreateTaskInput!) { createTask(input:$i) { id } }' \
      '{"i":{"projectID":"prj_…","title":"<verb-first>","description":"<what + acceptance>","kind":"feature","priority":"high","effort":"m"}}'

    gql 'mutation { addTaskToPlan(planID:"pln_…", taskID:"tsk_…", position:1) }'
    ```

5. **Hand off to the user.** Return:
    - Spec ID + URL: `https://aicoder.$HOST/s/<spec-id>`
    - Plan ID + status (`draft`) + URL: `https://aicoder.$HOST/p/<plan-id>`
    - Task IDs + URLs
    - **"Plan needs approval before agents execute. Approve in the UI."** (or via `mutation { approvePlan(id:"pln_…") { id } }`)

6. **Stop.** Do not start runs on the tasks.

## Tone

Terse. IDs + status only. No "I've successfully created…".
