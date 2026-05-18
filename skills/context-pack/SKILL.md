---
name: context-pack
description: Use when a task or workspace needs durable local context across sessions, tools, or agents; when context is long, stale, fragmented, or about to be delegated; or when creating, reading, auditing, or updating a Context Pack fact map.
---

# Context Pack

## Role

A Context Pack is a local, workspace-level fact map. It keeps Codex effective across sessions by storing stable facts, source-of-truth pointers, decisions, commands, risks, and acceptance rules.

It is not memory, not a PRD, not a transcript summary, and not a replacement for live verification.

## Use It For

- medium or long-running work
- repeated work in the same folder or topic
- product, research, ops, coding, finance, travel, personal knowledge, environment repair, or workflow efforts that will continue later
- handoff to another agent or coding tool
- avoiding repeated loading of long chats, logs, docs, or source trees

## Skip It For

- one-off questions
- simple local edits
- raw logs or full chat summaries
- secrets, tokens, credentials, private keys, or account data
- fast-changing facts unless the pack stores only source links and re-verification rules
- information better stored as global user preference

## Source Priority

When facts conflict, use this order:

1. Latest explicit user instruction
2. Live source of truth: repo files, logs, tests, issue state, official docs, current web data
3. Project-level `AGENTS.md` or equivalent local rules
4. Context Pack
5. Long-term memory
6. Prior chat history

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

## Minimal Template

```md
# Context Pack

Last reviewed: YYYY-MM-DD
Status: fresh | stale | partial
Context type: code | product | research | ops | finance | travel | personal | workflow | other

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
- Tool/plugin/agent routing notes:
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

