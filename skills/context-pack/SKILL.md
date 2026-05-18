---
name: context-pack
description: Use when the user asks for Context Pack work; an existing workspace fact map should be read; work will span sessions or recur; context bloat is hurting execution; or a handoff needs shared local facts.
---

# Context Pack

## Role

A Context Pack is a local, workspace-level fact map. It keeps Codex effective across sessions by storing stable facts, source-of-truth pointers, decisions, commands, risks, and acceptance rules.

It is not memory, not a PRD, not a transcript summary, and not a replacement for live verification.

## Quick Workflow

1. Decide whether the task needs durable workspace context. Skip the pack for one-off questions and tiny local edits.
2. If the user names a pack path, inspect that first. Otherwise check `context/context-pack.md`, `docs/codex/context-pack.md`, and `.ai-workflow/context/context-pack.md`; if needed, use `rg --files -g '*context-pack*.md'`.
3. If one pack exists, read only the sections needed for the task, then summarize scope, stale or partial areas, and what must be re-verified live before acting.
4. If multiple packs exist, prefer the human-readable project pack (`docs/codex/context-pack.md` or `context/context-pack.md`) and treat handoff packs as subsets. If the canonical pack is unclear, ask one question.
5. If no pack exists, create one only when the user asks or the work is clearly long-running, recurring, or about to be handed off. Fill only stable facts known now; use `TBD` for unknowns.
6. When updating, change only reusable facts, decisions, source pointers, risks, commands, or acceptance rules. Update `Last reviewed` and `Status`.

## Use It For

- medium or long-running work
- repeated work in the same folder or topic
- any domain only when the work is recurring, multi-session, or needs handoff
- handoff to another agent or coding tool
- avoiding repeated loading of long chats, logs, docs, or source trees

## Skip It For

- one-off questions
- simple local edits
- raw logs or full chat summaries
- secrets, tokens, credentials, private keys, or account data
- fast-changing facts unless the pack stores only source links and re-verification rules
- information better stored as global user preference

## Native Memory Boundary

Use native memory for broad preferences or lessons that should follow the user across many conversations.
Use a Context Pack for one workspace's facts, decisions, source pointers, risks, and acceptance rules.

Do not copy project clutter into native memory. Do not turn a Context Pack into a personal profile.

## Source Priority

Separate instruction conflicts from fact conflicts.

For goals, scope, permissions, and preferences:

1. Latest explicit user instruction
2. Project-level `AGENTS.md` or equivalent local rules
3. Context Pack
4. Native memory
5. Prior chat history

For current factual state:

1. Live source of truth: repo files, logs, tests, issue state, official docs, current web data
2. Context Pack source pointers and last-reviewed notes
3. Native memory
4. Prior chat history

The Context Pack should point to live sources. It should not pretend to replace them.

## Location

Prefer existing project conventions. If none exist:

- General workspace: `context/context-pack.md`
- Code or product project: `docs/codex/context-pack.md`
- Agent handoff workflow: `.ai-workflow/context/context-pack.md`
- Docs vault or long-running topic: put the pack near the topic, or under a local `context/` folder

If multiple packs exist, treat the human-readable project pack as canonical and let handoff-specific packs be subsets or pointers.

## When To Read

Read the Context Pack before:

- resuming old work
- starting medium or high-risk work in a known workspace
- delegating to another agent or coding tool
- reviewing generated artifacts
- making product, architecture, or operational decisions where prior decisions matter

Do not load unrelated historical files just because a Context Pack exists.

## When To Update

Update only when stable reusable facts changed:

- project goal, scope, users, architecture, commands, routes, known risks, acceptance rules
- a repeated pitfall was discovered
- a decision will affect future tasks
- source-of-truth pointers changed

Do not update for transient task details, raw logs, long chat summaries, speculative ideas, or fast-moving market/news data.

Also:

- Do not update mechanically after every task.
- Do not update when the user explicitly asked for read-only analysis.
- Do not write temporary TODOs, active debugging scratch notes, or raw command output into the pack.
- For market, news, issue, dependency, or tool-state changes, store source pointers and recheck rules rather than stale conclusions.
- Preserve manual content; prefer small focused edits over rewriting the whole pack.

## Minimal Template

```md
# Context Pack

Last reviewed: YYYY-MM-DD
Status: fresh | stale | partial
Context type: code | product | research | ops | finance | travel | personal | workflow | other

Status meanings:
- fresh: the pack itself was recently reviewed; drift-prone facts still need live checks.
- stale: source state, project state, or external facts are likely to have changed.
- partial: the pack exists but key sources, decisions, risks, or acceptance rules are incomplete.

## How To Use
- Keep this file short, factual, and workspace-specific.
- Prefer links, file paths, commands, and decisions over pasted logs or chat history.
- Write important facts as: fact -> source/pointer -> last checked -> reverify rule.
- At session start, read `Scope`, `Source Of Truth`, `Decisions`, `Risks And Known Pitfalls`, and `Acceptance Rules`.
- Before acting, re-verify anything listed under `What must be re-verified live`.
- Update only stable reusable facts; leave transient task notes in the current conversation or task file.

## Scope
- Workspace/topic:
- What this pack covers:
- What this pack does not cover:

## Stable Facts
- Goal:
- Users/stakeholders:
- Current state:
- Key constraints:

## Source Of Truth
- Primary files/URLs/issues:
- Commands to inspect current state:
- What must be re-verified live:

## Decisions
- Accepted decisions:
- Rejected options:
- Reasons:

## Operating Notes
- Important files/folders:
- Useful commands or checks:
- Tool/plugin/agent routing notes: workspace-specific exceptions only; do not paste general plugin manuals or personal preferences.
- Cadence or refresh rule:

## Risks And Known Pitfalls
- Risk:
- Symptom:
- How to verify:

## Acceptance Rules
- Done means:
- Required verification:
- Do not do:

## Open Questions
- Question:
- Why it matters:
- How to resolve:
- Keep only questions that change scope, source of truth, verification, or key decisions. Do not use this as a task backlog.
```

## Quality Bar

A good Context Pack is:

- short enough to read at task start
- evidence-linked
- explicit about staleness
- useful across sessions
- free of secrets
- biased toward pointers over pasted bulk content

If it grows too long, split stable references into linked files and keep the pack as the index.

## Common Mistakes

- Treating the pack as current truth instead of a map to current truth.
- Filling it with raw logs, full chat history, or speculative notes.
- Storing global user preferences that belong in native memory or global rules.
- Trusting stale pack content over current repo files, issue state, tests, docs, or web data.
- Creating multiple competing packs without a clear canonical one.
- Updating it after every task instead of only when reusable facts changed.
