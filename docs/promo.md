# Codex Context Pack

Codex Context Pack helps long-running work stay understandable across sessions.

It is for the moment when a quick Codex task turns into a real project: a feature that spans days, a product investigation, an infrastructure fix, a research thread, or any workflow that keeps coming back after the original conversation is gone.

Without a workspace fact map, the same project usually gets explained over and over:

- decisions disappear into old chat history
- Codex reloads too many notes, logs, and summaries
- context grows until the agent gets slower and less sharp
- token usage rises because stable facts are reintroduced repeatedly
- handoffs between Codex, other agents, and local tools are hard to audit

This repo keeps the durable pieces in one local place:

- the goal
- the current state
- the source-of-truth files
- accepted and rejected decisions
- risks and stale assumptions
- commands and verification rules

The point is not to store everything. The point is to save the right things so Codex can restart from a compact, accurate understanding instead of rereading the whole conversation.

Try it:

```bash
curl -fsSL https://raw.githubusercontent.com/coxyitao/codex-context-pack/main/install.sh | bash
```

