# 07 — Real-world walkthrough: building a streaming chat UI

A concrete, end-to-end story of how a human + AI agent partnership uses the
aicoder system to build a real feature. Every artifact in this story is
seeded into the demo project (`prj_fi12w0suhyve0n8ce`) so you can click
through and see what the watcher actually sees.

The use case: **"Replace request/response chat with a streaming UI that shows
tool calls and source citations inline."** Picked because it's representative
of work that touches transport, frontend, perf, and UX — exactly the kind of
project where decisions and memories accumulate.

---

## Cast

```
HUMAN                    PLANNER AGENT             EXECUTOR AGENT
"the lead"               (Claude Opus, careful)    (Claude Sonnet/Opus,
                                                    cost-tuned)
   │                          │                          │
   │ "let's stream the chat"  │                          │
   │─────────────────────────▶│                          │
   │                          │ drafts Spec + Plan       │
   │                          │◀─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
   │                          │                          │
   │ approves Plan            │                          │
   │─────────────────────────────────────────────────────▶│
   │                          │                          │ runs tasks
   │                          │                          │
   │                          │                          │ captures decisions
   │                          │                          │ saves memories
   │                          │                          │
   │ approves Gate ────────────────────────────────────────▶│ flips FF
```

---

## Hour 0 — Human asks for a thing

User opens Claude Code, types:

> "Our chat feels slow. Can we stream tokens? Also when the agent uses a
> tool, users have no idea what's happening — they just see a spinner.
> And we should show sources for any factual claim."

Three problems wrapped in one ask. Vague-ish. Classic.

The agent's first move: **don't write code**. Run the **start-feature**
prompt template. Capture intent before approach.

```bash
gql 'mutation($i:CreateSpecInput!){ createSpec(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "title":"Streaming chat UI with tool calls + citations",
    "summary":"Replace the request/response chat with token-by-token streaming, inline tool-call rendering, and source citations as the agent speaks.",
    "problem":"Current chat returns full responses after the agent finishes — users wait 4–12s staring at a spinner. Tool calls are invisible until completion, so failed tool runs feel like the agent silently froze. Sources are not attributed to outputs, so users cannot verify claims. The spinner-based UX makes the agent feel slower than competitors that stream.\n\n## Goals\n- Token-level streaming with TTFB <100ms p95\n- Inline tool-call lifecycle (start → running → result/error)\n- In-band citations: each factual claim links to a source\n- Reconnect on connection drop without losing context\n- Backwards-compatible with existing /api/chat clients\n\n## Constraints\n- Ship over standard fetch — no WebSocket infra in Phase 1\n- SSE format only (compatible with our Cloudflare proxy)\n- Must keep existing /api/chat JSON shape as a fallback\n- Mobile must work — keep above-the-fold latency <200ms\n- No new infra services (use existing Redis for resume state)\n\n## Success metrics\n- TTFB <100ms p95 (currently ~3s)\n- User-perceived response time cut by 50%\n- Reconnect zero-loss rate >95%\n- Citation click-through >40%\n- Chat session abandonment cut from 18% → <8%"
  }
}'
```

Result: **`spec_yr4p4gnjxv4hdjtos`** (status: `active`).

> The agent didn't write a line of streaming code yet. It wrote the *intent
> contract*. Future agents who read this spec will know what "done" means.

---

## Hour 1 — Plan the work

The Spec is the *what*. The Plan is the *how*. The agent splits the work into
two phases — streaming infra first (P1), citation UX second (P2). P1 is
strictly necessary; P2 builds on top.

```bash
gql 'mutation($i:CreatePlanInput!){ createPlan(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "specID":"spec_yr4p4gnjxv4hdjtos",
    "title":"Phase 1 — Streaming infra",
    "strategy":"SSE over POST. Tokens flow as newline-delimited JSON frames. Tool calls emit start/result/error frames. Reconnect uses Last-Event-ID header. 5 phases: SSE transport in apidash → frame protocol contract → frontend incremental render → tool-call frame UX → reconnect glue. Out of scope for P1: citations (Phase 2), TTS, attachments."
  }
}'
# → pln_h78pvyn3pjkf4qswl  (status: draft)
```

Then 5 child tasks, each scoped to one Claude Code session:

```
tsk_wr72…  Wire SSE transport into apidash chat handler  (code, high, m)
tsk_cdm1…  Define stream frame protocol (NDJSON)         (docs, high, s)
tsk_ccp8…  Adapt frontend chat to incremental render     (code, high, l)
tsk_bwwo…  Tool call frame UX — collapsed by default     (code, medium, m)
tsk_ry2u…  Reconnect with Last-Event-ID                  (code, medium, m)
```

Plan 2 (Phase 2) created the same way: `pln_9q3sjqkhj79wxanrz` with 3 tasks.
Stays in `draft` status. **Cannot be executed until a human approves.**

> **The agent stops here.** Hands off to the human:
>
> > Spec: https://aicoder.localhost/s/spec_yr4p4gnjxv4hdjtos
> > Plan-1: https://aicoder.localhost/p/pln_h78pvyn3pjkf4qswl (draft — needs approval)
> > Plan-2: https://aicoder.localhost/p/pln_9q3sjqkhj79wxanrz (draft)
> > 8 tasks attached. Plan-1 needs approval before agents execute.

---

## Hour 2 — Human approves Plan 1, leaves Plan 2 for later

Human reads the strategy. It looks right. Approves Phase 1. Phase 2 stays
draft because they want to see how Phase 1 lands before committing to the
citation approach.

```bash
gql 'mutation { approvePlan(id:"pln_h78pvyn3pjkf4qswl") { id status } }'
gql 'mutation { activatePlan(id:"pln_h78pvyn3pjkf4qswl") { id status } }'
# → status: active
```

Now agents may execute against Plan 1 tasks. Plan 2 tasks are visible but
*off-limits* — the system enforces this by convention: agents check
`plan.status === "approved" || "active"` before starting a run.

---

## Day 2 — Executor agent picks up the first task

Cheaper executor agent (Claude Sonnet) wakes up, queries for next task:

```bash
gql '{
  tasks(first:1, where:{
    projectID:"'$PROJECT'", statusIn:["todo"],
    or:[{assigneeAgentIDIsNil:true}, {assigneeAgentID:"'$AGENT'"}]
  }, orderBy:{field:PRIORITY, direction:DESC}){
    edges { node { id title } }
  }
}'
# → tsk_wr72… "Wire SSE transport into apidash chat handler"
```

Claims it (`assignTask`), starts a run, **declares the plan first** so the
watcher sees a live checklist:

```bash
RUN=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id } }' \
  '{"i":{"taskID":"tsk_wr72…","model":"claude-opus-4-7"}}' | jq -r '.data.startRun.id')

gql 'mutation($id:ID!,$s:String!,$st:[RunStepInput!]!){ setRunPlan(runID:$id,summary:$s,steps:$st){id} }' '{
  "id":"'$RUN'",
  "s":"Wire jwtauth.New() into apidash.Boot middleware chain. Position: after ratelimit, before metrics.",
  "st":[
    {"title":"read apidash/Boot/auth.go", "rationale":"current order", "position":1},
    {"title":"add SSE response writer", "rationale":"text/event-stream + flush", "position":2},
    {"title":"defeat Cloudflare buffering", "rationale":"X-Accel-Buffering:no + no-transform", "position":3},
    {"title":"add chain-order test", "rationale":"prevent regression", "position":4},
    {"title":"task test", "rationale":"verify", "position":5}
  ]
}'
```

> The watcher reloads the task page and sees the live checklist. Each step
> updates as the agent walks: ✓ ✓ ⏳ pending pending. **They can grade
> progress without reading code.** That's the load-bearing UX.

---

## Day 2 — Mid-run discovery: ratelimit middleware breaks

Walking step 3 (defeating Cloudflare buffering), the agent does a sanity
check on the surrounding middleware chain. **Discovers** that the existing
ratelimit middleware reads auth context. If we put the SSE handler before
ratelimit (which a naive read of the strategy might suggest), authed users
get IP-based throttling.

This is exactly the kind of thing decisions are for — a non-obvious choice
with real alternatives. Captures it immediately:

```bash
gql 'mutation($i:CreateDecisionInput!){ createDecision(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'",
    "taskID":"tsk_wr72…",
    "runID":"'$RUN'",
    "kind":"choice",
    "title":"Place SSE handler after ratelimit, before metrics",
    "context":"Ratelimit reads auth context for per-user limits…",
    "decision":"Order: ratelimit → SSE → metrics → routes.",
    "consequences":"Document this dependency in README. Add chain-order assertion test."
  }
}'
# → dec_…
```

The decision now appears on the run, the task, and the parent plan as a
backlink chip in any prose that mentions it.

---

## Day 2 — Run finishes successfully, lessons saved

Step 5 (`task test`) passes. Run completes:

```bash
gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id } }' '{
  "i":{
    "runID":"'$RUN'", "outcome":"success",
    "summary":"Wired SSE handler at apidash/Boot/chat.go. Headers: text/event-stream + X-Accel-Buffering:no + Cache-Control:no-cache,no-transform. Per-write flush via gin.Context. Existing /api/chat untouched. PR #218 merged.",
    "approach":"Added a sibling /api/chat/stream endpoint. Reused the existing chat orchestrator; only the response writer differs.",
    "costUsd":0.42, "tokensIn":18420, "tokensOut":4250, "durationMs":240000,
    "gitCommitSha":"a1b2c3d", "gitFiles":["apidash/Boot/chat.go","apidash/Boot/chat_test.go","saas/pkg/chatstream/types.go"]
  }
}'
```

Then runs the **postmortem** prompt — saves the *portable* lessons:

```bash
# Memory 1: a pattern future agents will reuse
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'", "tag":"pattern",
    "title":"SSE over POST in Go — flush every write",
    "body":"## Code shape\n…\n## Gotchas\n- Cloudflare buffers without X-Accel-Buffering: no…\n- Compression middleware breaks streaming if not bypassed…",
    "sourceTaskID":"tsk_wr72…"
  }
}'

# Memory 2: an incident worth never repeating
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'", "tag":"incident",
    "title":"Cloudflare proxy buffered SSE until connection close",
    "body":"## Symptom\nLocal worked, staging didnt. Dump came at connection-close…\n## Root cause\nCF buffers text/event-stream by default…\n## Fix\nThree headers: Content-Type + Cache-Control: no-cache,no-transform + X-Accel-Buffering:no…\n## Prevention\nSmoke test in CI: assert TTFB <200ms.",
    "sourceTaskID":"tsk_wr72…"
  }
}'
```

> Anyone (human or agent) starting a streaming task next month can
> `aicoder memory search --q "SSE"` and find both. Knowledge compounds.

---

## Day 3 — Frontend task: failed run + retry

Different agent picks up `tsk_ccp8…` (Adapt frontend chat to incremental
render). Runs the cycle. Tests pass. But manual smoke reveals the page hangs
30-100ms per token at high token rates.

This is a **failure** worth logging properly:

```bash
gql 'mutation($i:FinishRunInput!){ finishRun(input:$i){ id } }' '{
  "i":{
    "runID":"'$RUN3a'", "outcome":"fail",
    "errorKind":"perf",
    "errorMessage":"Streamdown re-parses entire markdown tree on every token. Main thread hangs 30-100ms/token on long messages.",
    "summary":"Made the wiring work but discovered a Streamdown perf cliff. Captured incident memory. Need an incremental parser before this can ship.",
    "costUsd":0.31, "tokensIn":12200, "tokensOut":2400
  }
}'
```

Task auto-transitions to `blocked`. Watcher sees the failure on the spec
page (red dot + 1 fail in the run feed).

The agent saves an **incident memory** so the next attempt doesn't repeat:

```bash
gql 'mutation($i:CreateMemoryInput!){ createMemory(input:$i){ id } }' '{
  "i":{
    "projectID":"'$PROJECT'", "tag":"incident",
    "title":"Streamdown re-parsed the entire markdown tree on every token",
    "body":"## Symptom\nFrontend at 100tps hung the main thread 30-100ms/token. Mobile especially bad.\n\n## Root cause\nStreamdown re-parses the *entire* markdown source on each render. With long messages this is O(n) per token = O(n²) per message.\n\n## Fix\nOnly re-render the trailing message bubble. Memo earlier messages (immutable once finalized).\n\n## Numbers\n80ms p50 → 6ms p50 at message length 4000.\n\n## Prevention\nMeasure render frame time at every token. CI flags PRs that regress >10ms.",
    "sourceTaskID":"tsk_ccp8…", "sourceRunID":"'$RUN3a'"
  }
}'
```

Then **starts a fresh run** on the same task with the new approach baked in:

```bash
RUN3b=$(gql 'mutation($i:StartRunInput!){ startRun(input:$i){ id } }' \
  '{"i":{"taskID":"tsk_ccp8…","model":"claude-opus-4-7"}}' | jq -r '.data.startRun.id')
# Plan: same as before, but with "memo earlier bubbles" baked in step 2
```

Run is `in_progress`. Watcher sees both runs stacked on the task page —
old failure, new attempt. Visible progression.

---

## Day 4 — Gate before flipping the feature flag

Phase 1 streaming is *technically* done — wired, tested, perf-fixed. But
flipping the feature flag from `staff-only` to 100% is consequential:
real users, no easy revert, on-call needs to know.

Agent requests a gate:

```bash
gql 'mutation($i:RequestGateInput!){ requestGate(input:$i){ id } }' '{
  "i":{
    "taskID":"tsk_ccp8…",
    "reason":"Phase 1 streaming infra is feature-flag ON for staff only. Ready to flip to 100% for the next 24h soak. Confirm: (1) revert plan documented, (2) on-call aware, (3) Streamdown re-render perf fix is in place (see incident memory)."
  }
}'
# → gate_…  (status: open)
```

Sidebar across the whole web UI shows **"1 open gate"**. Watcher gets paged
(or sees it on next browse). Reads the reason, checks the linked memory,
checks the run, decides:

```bash
gql 'mutation { approveGate(id:"gate_…") { id status } }'
```

Agent's polling loop notices `status === "approved"`, flips the FF, finishes
the soak.

If the human had **rejected** instead, the agent would cancel the run,
record a Decision documenting the rejection rationale ("deferred — wait for
v1 mobile sunset"), and surface the reason to the user.

---

## Day 5 — Phase 2 begins (citation UX)

Phase 1 ships. Soak-period clean. Time for Plan 2 (citation UX).

First, the human approves Plan 2. **It was sitting in `draft` for 3 days
because we wanted to see Phase 1 land before committing to the approach.**
That's the system working as intended — drafts let you stage work without
forcing decisions.

Plan 2 → `approved` → `active`. Three new tasks become executable. Cycle
repeats: pick task → run → decide → finish → memory.

Decision recorded along the way (an ADR this time, because it's a
multi-file architectural call):

```
ADR — Citations are markdown links to /sources/<id>, not custom syntax
  Context: Want chips inline without bolting custom md extensions onto Streamdown
  Decision: [caption](/sources/<id>) — renderer detects /sources/ paths
  Alternatives: <cite> tags, custom JSX components, JSX islands
  Consequences: Citations flow through plain markdown — copy-paste preserves them
```

---

## What this looks like to anyone visiting the spec page

```
SPEC · v1                                       [active]    edited 2d
Streaming chat UI with tool calls + citations
─────────────────────────────────────────────────────────
   2 plans      8 tasks      4 runs     $0.91 cost
   1 approved   25% done     2 ✓ 1 ✗    18.4k+8.2k tok in

⚠ Needs attention: 1 in_progress (Adapt frontend retry)

Summary
  Replace the request/response chat with token-by-token streaming…

Problem (markdown rendered)
  Current chat returns full responses…

  ## Goals
  - Token-level streaming with TTFB <100ms p95
  - …

  ## Constraints
  - SSE only, no WebSocket
  - …

Plans                                             + Plan
  ▼ Phase 1 — Streaming infra        [active]   3/5 ━━━━━━░░  approved
    ┌─ 2 done · 1 in_progress · 2 todo
    │ ● Wire SSE transport               done    high   m  —
    │ ● Define NDJSON frame protocol     done    high   s  —
    │ ◐ Adapt frontend chat              run     high   l  —
    │ ○ Tool-call frame UX               todo    med    m  —
    │ ○ Reconnect Last-Event-ID          todo    med    m  —

  ▶ Phase 2 — Citations UX            [draft]   0/3 ░░░░░░░░░░

Recent runs                                              4
  # 1  ✓ success  Wired SSE handler at apidash/Boot…   $0.42  2d
  # 1  ✓ success  Defined NDJSON frame types…          $0.18  2d
  # 1  ✗ fail     Streamdown perf cliff…               $0.31  1d
  # 2  ▷ running  Retry — incremental parser this time —     now

Decisions                                                5
  💡 ADR     Use SSE over POST (not WebSocket)
  💡 Choice  NDJSON over SSE event types
  💡 Choice  SSE handler position in middleware chain
  💡 ADR     Citations are markdown links to /sources/<id>
  💡 Brain   Reconnect strategy — explored alternatives

Memories                                                 5
  🧠 Pattern  SSE over POST in Go — flush every write
  🧠 Incident Cloudflare buffered SSE until connection close
  🧠 Incident Streamdown re-parsed tree on every token
  🧠 Feedback User: tool-call errors should not look alarming
  🧠 Lesson   Embed citation metadata at emit time

Activity (timeline)
  Today    spec status changed to active
  …
  3d ago   plan-1 approved by usr_…
  3d ago   spec created by agt_…
```

Every chip is clickable. Every entity is a hyperlink chip in any prose body
that references it. Future-you can land on any task, run, decision, or
memory and see how it ties to the others.

---

## What you've actually built — the artifacts trail

By the time the feature ships, the system has captured:

| Artifact | Purpose | Audience |
|---|---|---|
| 1 Spec | What we built and why | Product manager, future PMs |
| 2 Plans | How we approached it (with strategy paragraph) | Engineering reviewers |
| 8 Tasks | Atomic work units, each tied to a run | Sprint trackers, status reports |
| 4+ Runs | What each agent attempt did, cost, tokens, files | Cost auditors, retros |
| 5 Decisions | Trade-offs that were considered + chosen | Future devs touching this code |
| 5 Memories | Reusable patterns + incidents to never repeat | Anyone starting similar work |
| 1 Gate | The pre-flip approval moment | Compliance / on-call |

A grep over the codebase 6 months later, hitting one of these patterns,
will surface this entire trail. **That's the value.** No tribal knowledge.
No "ask the person who wrote this." The system *is* the memory.

---

## What an AI agent should do differently from a human

When operating this system, an AI shouldn't try to do everything sequentially
like a single human would. Two adjustments:

1. **Read prior art before every non-trivial run** — knowledge sweep
   (memories + decisions matching task keywords) takes one round-trip and
   eliminates 80% of "have we already learned this?" failures. See
   [04-knowledge-retrieval.md](./04-knowledge-retrieval.md).

2. **Cite as you write** — every claim in a run summary, decision
   consequence, or memory body should link to the source artifact via
   `[caption](/x/id)` syntax. The Web UI auto-renders these as chips, and
   future searches surface them as backlinks. Cheap to do, expensive *not*
   to do.

The system rewards capture. Capture more than feels comfortable.

---

## Try it yourself

Everything above is seeded against `prj_fi12w0suhyve0n8ce`. Open:

- [Spec](https://aicoder.localhost/s/spec_yr4p4gnjxv4hdjtos)
- [Plan 1 — approved + active](https://aicoder.localhost/p/pln_h78pvyn3pjkf4qswl)
- [Plan 2 — draft](https://aicoder.localhost/p/pln_9q3sjqkhj79wxanrz)
- [Knowledge → Decisions](https://aicoder.localhost/workspace/prj_fi12w0suhyve0n8ce/knowledge/decisions)
- [Knowledge → Memory](https://aicoder.localhost/workspace/prj_fi12w0suhyve0n8ce/knowledge/memory)
- [Knowledge → Gates](https://aicoder.localhost/workspace/prj_fi12w0suhyve0n8ce/knowledge/gates) — the open gate
- [Activity feed](https://aicoder.localhost/workspace/prj_fi12w0suhyve0n8ce/activity) — full event log

Click around. Every chip in a prose body is a clickable link to the
referenced entity. Every detail page rolls up everything connected to it.
That's the feature.
