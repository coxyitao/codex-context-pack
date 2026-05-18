# Context Pack

Last reviewed: 2026-01-01
Status: partial
Context type: code | product

## How To Use
- Read this pack before resuming feature work or delegating implementation.
- Re-check the live repository, scripts, and issue state before editing.
- Update only stable project facts, decisions, risks, or verification rules.

## Scope
- Workspace/topic: A local web application project.
- What this pack covers: stable product goals, technical entry points, local commands, and verification expectations.
- What this pack does not cover: raw build logs, secrets, deployment credentials, or temporary implementation notes.

## Stable Facts
- Goal: Help the agent resume project work without rereading the full repository every time.
- Users/stakeholders: Product owner, engineer, reviewer.
- Current state: Project structure and scripts should be checked live before any implementation.
- Key constraints: Do not change authentication, billing, database schema, or deployment settings without explicit approval.

## Source Of Truth
- Primary files/URLs/issues: `README.md`, `package.json`, `src/`, `tests/`, `docs/auth.md`, issue tracker.
- Commands to inspect current state: `git status -sb`, `npm test`, `npm run lint`, `npm run build`.
- What must be re-verified live: dependencies, test status, active branch, open issues, deployment config.

## Decisions
- Accepted decisions: Use the existing auth flow for feature work. Source: `docs/auth.md`. Last checked: 2026-01-01. Reverify: inspect current auth routes before editing.
- Rejected options: Do not redesign auth as part of unrelated UI or data-flow tasks.
- Reasons: Auth changes have higher risk and need a separate scope, tests, and review.

## Operating Notes
- Important files/folders: `src/`, `tests/`, `docs/`.
- Useful commands or checks: Use the smallest relevant verification for each change.
- Tool/plugin/agent routing notes: For this workspace, run local scripts before asking another agent to implement. Do not paste general plugin instructions here.
- Cadence or refresh rule: Update after stable architecture, command, risk, or acceptance-rule changes.

## Risks And Known Pitfalls
- Risk: Treating stale pack content as current truth.
- Symptom: Agent skips live tests or ignores changed files.
- How to verify: Run current project commands and inspect the active branch before acting.

## Acceptance Rules
- Done means: The changed behavior is implemented, verified, and summarized with evidence.
- Required verification: Relevant test, lint, build, or browser check.
- Do not do: Commit, push, deploy, or run destructive commands without explicit approval.

## Open Questions
- Question: Which commands are authoritative for this project?
- Why it matters: Verification quality depends on the real local toolchain.
- How to resolve: Inspect project docs and scripts, then update this section.
- Keep only questions that change scope, source of truth, verification, or key decisions.
