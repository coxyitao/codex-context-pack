<!-- BEGIN CODEX_CONTEXT_PACK -->

## Context Pack

- Use a Context Pack when a workspace or topic needs durable context across sessions, tools, or agents.
- Treat the Context Pack as a local fact map: stable facts, source-of-truth pointers, decisions, verification commands, risks, and acceptance rules.
- Before resuming long-running work, look for `context/context-pack.md`, `docs/codex/context-pack.md`, or `.ai-workflow/context/context-pack.md`.
- If a long-running workspace has no Context Pack, create one from the installed template instead of putting workspace facts into global rules.
- Do not use a Context Pack for one-off questions, small edits, raw logs, full chat transcripts, secrets, credentials, or fast-changing facts unless it stores only source links and re-verification rules.
- User instructions decide goals, scope, permissions, and preferences; live sources decide current factual state.
- For factual conflicts, prefer live source of truth over Context Pack, native memory, and prior chat.
- For workflow or permission conflicts, prefer latest user instruction and project rules over Context Pack.
- Before acting on a Context Pack, re-check anything likely to drift: repository state, tests, issues, docs, current web data, tool availability, and local configuration.
- Keep global rules thin. Put workspace-specific stable facts in the local Context Pack, not in this global file.
- Update a Context Pack only when reusable facts, decisions, source pointers, commands, risks, or acceptance rules change.
- A Context Pack is not a memory replacement, PRD, transcript summary, or substitute for live verification.

<!-- END CODEX_CONTEXT_PACK -->
