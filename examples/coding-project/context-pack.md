# Context Pack

Last reviewed: 2026-01-01
Status: partial
Context type: code | product

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
- Primary files/URLs/issues: `README.md`, `package.json`, `src/`, `tests/`, issue tracker.
- Commands to inspect current state: `git status -sb`, `npm test`, `npm run lint`, `npm run build`.
- What must be re-verified live: dependencies, test status, active branch, open issues, deployment config.

## Decisions
- Accepted decisions: Keep this pack short and pointer-based.
- Rejected options: Do not paste complete logs or chat summaries here.
- Reasons: The pack should lower context cost, not become another context dump.

## Operating Notes
- Important files/folders: `src/`, `tests/`, `docs/`.
- Useful commands or checks: Use the smallest relevant verification for each change.
- Tool/plugin/agent routing notes: Use local code and project scripts before external docs unless third-party API behavior is involved.
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

