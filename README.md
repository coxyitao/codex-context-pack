# Codex Context Pack

Codex Context Pack is a lightweight local context protocol for Codex workflows.
It gives Codex three durable assets:

- a focused global `AGENTS.md` rules block for Context Pack behavior
- a `context-pack` skill that tells Codex when to read, create, audit, or update a fact map
- a project-local fact map template that stores stable workspace facts without copying chat history

The goal is simple: keep long-running work understandable across sessions without turning global rules into a bloated second brain.

## Install

Run this from the project or workspace where you want a fact map:

```bash
curl -fsSL https://raw.githubusercontent.com/coxyitao/codex-context-pack/main/install.sh | bash
```

This one command will:

1. install the `context-pack` skill for Codex
2. merge a Context Pack rules block into `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`
3. create `context/context-pack.md` in the current directory if it does not already exist

Restart Codex after installation so the new skill can be discovered.

## Safer Preview

To see what would happen before writing files:

```bash
curl -fsSL https://raw.githubusercontent.com/coxyitao/codex-context-pack/main/install.sh | bash -s -- --dry-run
```

To place the fact map somewhere else:

```bash
curl -fsSL https://raw.githubusercontent.com/coxyitao/codex-context-pack/main/install.sh | bash -s -- --fact-map docs/codex/context-pack.md
```

Common paths:

- `context/context-pack.md` for general workspaces
- `docs/codex/context-pack.md` for code or product projects
- `.ai-workflow/context/context-pack.md` for worker handoff workflows

## What A Context Pack Is

A Context Pack is a local fact map for one workspace, project, or long-running topic.
It stores stable facts, source-of-truth pointers, decisions, verification commands, risks, and acceptance rules.

It is not:

- a memory replacement
- a PRD
- a full chat summary
- a transcript archive
- a place for secrets
- a substitute for live verification

## Repository Layout

```text
skills/context-pack/              Codex skill
templates/context-pack.md         generic fact map template
templates/AGENTS.context-pack.block.md
examples/                         safe, generic examples
docs/                             installation and boundary notes
scripts/check-public.sh           public-safety and structure checks
install.sh                        one-command installer
```

## Use

After installing, you can ask Codex:

```text
Use the context-pack skill to read or create a Context Pack for this workspace.
```

Or:

```text
Before continuing this long-running task, inspect the Context Pack and tell me what must be re-verified live.
```

## Public-Safety Rule

Do not publish personal paths, credentials, raw sessions, memory files, private issue content, or machine-local tool state as examples.
Examples in this repository are intentionally generic.

