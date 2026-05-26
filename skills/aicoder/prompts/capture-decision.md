# capture-decision

You made a non-obvious choice. Alternatives existed; you picked one; the reason matters. Record it via the GraphQL API.

## Pick the kind

| Kind | When |
|---|---|
| `adr` | Architectural — multi-file impact / future work / hard to reverse |
| `choice` | Tactical — single Task or Run, "I picked X over Y because…" |
| `brainstorm` | Speculative — listing options before any commit |

## Template

```bash
gql 'mutation($i:CreateDecisionInput!) { createDecision(input:$i) { id } }' \
  '{"i":{
    "projectID":"prj_…",
    "taskID":"tsk_…",                # link if there is one
    "runID":"run_…",                  # if captured during a Run
    "planID":"pln_…",                 # if it is a plan-level call
    "kind":"choice",                  # adr | choice | brainstorm
    "title":"<one line: subject + verb>",
    "context":"<situation that requires a decision>",
    "decision":"<what was chosen>",
    "alternatives":["<option 1>","<option 2>","<option 3>"],
    "consequences":"<what changes as a result>"
  }}'
```

The decision then surfaces:
- On `/d/<decision-id>` (its own page)
- On the linked Task / Plan / Run "Decisions" rail
- On Spec / Plan / Task "Mentioned in" rails if its body links back via `[title](/t/...)` syntax

## Rules

- **Title is descriptive, not generic.** "Use Postgres LISTEN/NOTIFY for term streaming" — not "Realtime decision".
- **Context first.** What was the world like when this decision was made? Future-you needs to know if the world changed.
- **Alternatives must exist.** If there were no alternatives, it's not a decision — it's a fact. Don't record it.
- **Consequences = new obligations.** "We now need reconnect logic in the client" — not "We use LISTEN/NOTIFY".

## Antipatterns

- `"alternatives":[]` → if no alternatives, don't record.
- Recording every line of code as a decision — only the *non-obvious* ones.
- Recording the implementation as the decision ("Use a `for` loop") — that's just code.
