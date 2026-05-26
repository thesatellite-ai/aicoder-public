# 00 — Mental model: how the entities thread together

This is the diagram every other playbook assumes you've read. Print it.

## The graph

```
                      ╔═════════════╗
                      ║   PROJECT   ║   workspace boundary, owns everything below
                      ╚══════╦══════╝
                             │
        ┌────────────────────┼────────────────────┐
        ▼                    ▼                    ▼
  ╔═══════════╗        ╔═══════════╗        ╔═══════════╗
  ║   SPEC    ║───┐    ║   TASK    ║◀───┐   ║   AGENT   ║
  ║ what+why  ║   │    ║  unit of  ║    │   ║  Claude/  ║
  ╚═════╦═════╝   │    ║   work    ║    │   ║  human    ║
        │ 1..n    │    ╚═════╦═════╝    │   ╚═════╦═════╝
        ▼         │          │          │         │ assignee
  ╔═══════════╗   │   ┌──────┼──────┐   │         │
  ║   PLAN    ║───┘   ▼      ▼      ▼   │         │
  ║ approach  ║   ╔══════╗ ╔══════╗ ╔════════╗    │
  ║ + approve ║   ║Subt. ║ ║ RUN  ║ ║Comment ║    │
  ╚═════╦═════╝   ║Task  ║ ║agent ║ ║disc.   ║    │
        │         ╚══════╝ ║attmp.║ ╚════════╝    │
        │                  ╚═══╦══╝               │
        │  PlanTask            │                  │
        │  (m..m junction)     │ 1..n             │
        ▼                      ▼                  │
  ┌──────────┐         ╔═════════════╗            │
  │   Task   │         ║   RUNSTEP   ║            │
  │  list    │         ║ live ckl.   ║            │
  └──────────┘         ╚══════╤══════╝            │
                              │                   │
                              │ on finish ▼       │
                              │     ╔═════════╗   │
                              └────▶║ REVIEW  ║   │
                                    ║ verdict ║   │
                                    ╚═════════╝   │
                                                  │
        ┌──────────┬──────────┬──────────┬────────┘
        ▼          ▼          ▼          ▼
   ╔═══════╗  ╔════════╗ ╔══════╗   ╔═════════╗
   ║DECISN.║  ║MEMORY  ║ ║GATE  ║   ║ACTIVITY ║
   ║ADR/   ║  ║lesson/ ║ ║mid-  ║   ║immutable║
   ║choice/║  ║pattern║  ║run   ║   ║log per  ║
   ║b-storm║  ║incdnt  ║ ║approv║   ║entity   ║
   ╚═══════╝  ╚════════╝ ╚══════╝   ╚═════════╝
       │           │         │           │
       └───────────┴─────────┴───────────┘
              all polymorphic →
              attach to ANY of:
              Task / Spec / Plan / Decision / Run
```

## The flow of authority (who can do what when)

```
USER asks: "let's build feature X"
   │
   ▼
AGENT creates Spec  (status: draft)        ─── always allowed
   │
   ▼
AGENT creates Plan  (status: draft)        ─── always allowed
   │
   ▼
AGENT creates Tasks under Plan             ─── always allowed
   │
   ▼
   ⏸  STOP. Hand off to USER.
   │
   ▼
USER approves Plan  → status: approved     ─── ONLY user can do this
   │                                            (or another authorized human)
   ▼
AGENT may now start runs on tasks
   │
   ▼
For each run:
  start → setRunPlan → walk steps → finish
  ↑                       │
  │                       ▼ (if step is consequential)
  │                   AGENT requests Gate
  │                       │
  │                       ▼
  │                   ⏸  STOP step. Wait for human approve/reject.
  │                       │
  │                       ▼
  │                   USER approves Gate → AGENT continues
  │                       │
  │                       ▼ (if rejected)
  │                   AGENT cancels run, surfaces decision
  │
  ▼
On finish:
  outcome=success    → task may auto → "awaiting_review" if requiresReview
  outcome=fail       → task → "blocked"
  Review attached    → verdict approve/reject/request_changes
                          ├─ approve         → task → done
                          ├─ request_changes → task → todo, agent retries
                          └─ reject          → task → blocked
```

## The polymorphic attachments

Decisions, Memories, Comments, Activity rows all attach to **exactly one** host:

| Host | When you attach to it |
|---|---|
| Task | The decision/memory/comment is about this single unit of work |
| Run | The thought happened *during* this specific agent attempt |
| Plan | A trade-off about the approach (e.g. "we chose 3-phase vs big-bang") |
| Spec | A constraint update or scope clarification |
| Decision | A *brainstorm* feeding into a later concrete decision (decisions can chain) |

**Key point:** because attachments are polymorphic, the same Decision/Memory can surface across multiple views (the parent task, the parent plan, the spec backlinks). You don't need to copy data — link once, surface everywhere.

## The two clocks

```
┌─ Plan time ──────────────────┐    ┌─ Run time ──────────────────────┐
│                              │    │                                 │
│   Draft Plan                 │    │   Run.start()                   │
│     ↓ (humans deliberate)    │    │     ↓ (agent works the steps)   │
│   Approved Plan              │    │   Run.finish()                  │
│     ↓                        │    │     ↓                           │
│   Active                     │    │   Review                        │
│     ↓                        │    │                                 │
│   Done / Cancelled           │    │   (per task: many runs)         │
└──────────────────────────────┘    └─────────────────────────────────┘
   measured in days/weeks              measured in minutes/hours
```

A Plan is the *human-rate* unit. A Run is the *agent-rate* unit. A Task is the bridge — humans approve plans, agents execute runs, both meet on the task.

## Identity prefixes (so you can read raw IDs)

```
prj_     project          tsk_     task         dec_     decision
spec_    spec             run_     run          mem_     memory
pln_     plan             stp_     run step     gat_     gate
pt_      plan-task junc.  rev_     review       cmt_     comment
tl_      task list        act_     activity     ntf_     notification
brd_     board            agt_     agent        usr_     user
tmpl_    task template
```

When reading logs / GraphQL responses, the prefix tells you the kind without an extra round-trip.

## Where this skill applies

This mental model is what every other file in `playbooks/` and `prompts/` assumes. If a flow violates it (e.g. an agent approving its own plan, a run starting on a draft plan), that's a bug in the flow — flag it before proceeding.
