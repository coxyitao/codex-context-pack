# Codex Context Pack

Codex Context Pack is a workspace fact map for Codex.

It is designed for the moment when a Codex task stops being a quick one-off and becomes a real piece of work: a multi-day coding project, a product investigation, an infrastructure fix, a long research thread, or a workflow that keeps coming back across sessions.

Without a durable local context layer, long tasks usually drift into the same failure mode:

- each new session needs the same background explained again
- important decisions get buried in old chat history
- Codex has to reload too many files, logs, notes, and summaries
- the main context window grows until the agent becomes slower and less sharp
- token usage goes up because stable facts are repeatedly reintroduced
- handoffs between Codex, other agents, and local tools become hard to audit

Codex Context Pack solves this by keeping a small fact map inside the workspace. The fact map stores what should survive across sessions: the goal, current state, source-of-truth files, accepted decisions, rejected options, useful commands, known risks, and acceptance rules.

The point is not to save everything. The point is to save the right things, in the right place, so Codex can restart from a clean, compact understanding instead of rereading an entire conversation.

## Why It Helps

For long-running work, a Context Pack gives Codex a stable starting point:

- **Cross-session continuity:** a new Codex session can quickly recover the project shape without reading old chats.
- **Less context bloat:** stable facts live in a small file instead of being pasted into every prompt.
- **Lower token waste:** repeated explanations, old logs, and long summaries can be replaced by concise source pointers.
- **Better decisions:** Codex can see prior decisions and rejected options before proposing the same thing again.
- **Safer execution:** the pack records what must be re-verified live instead of treating stale notes as truth.
- **Cleaner handoffs:** other agents or coding tools can read the same fact map before taking over implementation.

Think of it as a project notebook that is written for an AI agent: short, structured, evidence-oriented, and local to the work.

## What It Provides

Codex Context Pack gives you:

- a focused global `AGENTS.md` rules block that teaches Codex when Context Packs should and should not be used
- a `context-pack` skill that guides Codex when reading, creating, auditing, or updating a fact map
- a reusable fact map template for projects, research workspaces, operations tasks, and agent handoffs

The goal is simple: keep long-running work understandable across sessions without turning global rules into a bloated second brain.

## How It Works With Codex Memory

Codex Context Pack is not trying to replace Codex or ChatGPT's native memory features.

Native memory is best for broad, reusable information that should follow you across conversations: preferences, recurring working style, stable personal or team conventions, and high-level patterns that are useful in many contexts.

A Context Pack is different. It is local to a specific project, workspace, or long-running topic. It should hold the facts Codex needs for that piece of work:

- what this project is trying to achieve
- where the real source of truth lives
- what decisions have already been accepted or rejected
- which commands, tests, docs, or issues should be checked
- what is stale, risky, or must be re-verified before action

In practice, they work together:

- **Native memory** helps Codex remember how you generally like to work.
- **Context Pack** helps Codex remember what this specific workspace is doing.
- **Live verification** still wins when facts may have changed.

This keeps each layer clean. Long-term memory does not get filled with project clutter, and the project fact map does not become a personal profile or chat archive.

It also keeps project context explicit and portable. Native memory is a product-level feature controlled by the user's account and settings. A Context Pack is a plain local file that can be reviewed, edited, committed, copied, or handed to another agent when the project needs that kind of audit trail.

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
