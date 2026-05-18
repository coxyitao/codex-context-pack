# Boundaries

## What Goes In Global AGENTS.md

Only stable Context Pack behavior belongs in the global rules block:

- when to use a Context Pack
- when to skip it
- source priority
- live re-verification requirements
- update discipline

Do not put personal preferences, machine paths, project-specific facts, private tooling state, or one workspace's workflow details in the global block.

## What Goes In A Context Pack

Put stable workspace-level facts in the local fact map:

- scope
- goals
- current state
- source-of-truth pointers
- accepted and rejected decisions
- useful commands
- risks and pitfalls
- acceptance rules
- open questions

## What Stays Out

Never store:

- secrets, tokens, passwords, certificates, private keys
- raw logs or full transcripts
- complete chat history
- private user profile details
- machine-specific absolute paths in public examples
- fast-changing facts without source links and re-verification rules

## Live Truth Wins

A Context Pack is useful because it helps Codex know where to look and what decisions have been made.
It is still below live facts. Repository state, tests, logs, issue state, official docs, and current web data must be re-checked when they can drift.

