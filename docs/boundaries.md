# Boundaries

## What Goes In Global AGENTS.md

Only stable Context Pack behavior belongs in the global rules block:

- when to use a Context Pack
- when to skip it
- source priority
- live re-verification requirements
- update discipline

Do not put personal preferences, machine paths, project-specific facts, private tooling state, or one workspace's workflow details in the global block.

## Native Memory vs Context Pack

Use native Codex or ChatGPT memory for durable information that is useful across many conversations:

- general working preferences
- recurring communication style
- stable personal or team conventions
- broad lessons that apply across projects

Use a Context Pack for facts that belong to one workspace or long-running topic:

- project goal and scope
- current state
- source-of-truth files, docs, issues, or commands
- accepted and rejected decisions
- known risks and stale assumptions
- acceptance rules and verification requirements

The two layers should cooperate:

- Native memory can tell Codex how the user generally works.
- The Context Pack tells Codex what this workspace currently needs.
- Live source checks still override both when state may have changed.

Native memory is a product-level feature controlled by account and client settings.
A Context Pack is a plain local file, so it is easier to inspect, edit, version, share with another agent, or keep inside a repository.

Do not store project-specific clutter in native memory just because it may be useful later.
Do not store broad personal preferences in a Context Pack just because a task happened inside that workspace.

## Where Things Belong

| Content type | Put it here |
|---|---|
| Cross-project preferences, recurring communication style, broad lessons | Native memory |
| Workspace goals, stable facts, source pointers, decisions, risks, acceptance rules | Context Pack |
| Current code, issue state, tests, logs, official docs, current web data | Live source checks |
| General behavior rules, safety boundaries, when to use Context Packs | Global `AGENTS.md` |
| Chat transcript, raw logs, temporary task notes, scratch TODOs | Nowhere; store only source pointers if needed |

## Status Values

- `fresh`: the pack itself was recently reviewed; drift-prone facts still need live checks.
- `stale`: source state, project state, or external facts are likely to have changed.
- `partial`: the pack exists but key sources, decisions, risks, or acceptance rules are incomplete.

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
