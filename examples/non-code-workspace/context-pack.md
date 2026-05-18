# Context Pack

Last reviewed: 2026-01-01
Status: partial
Context type: research | workflow

## Scope
- Workspace/topic: A long-running research or planning workspace.
- What this pack covers: stable goals, source pointers, decisions, and refresh rules.
- What this pack does not cover: full articles, raw transcripts, private notes, or fast-changing facts without source links.

## Stable Facts
- Goal: Preserve the durable shape of the work so future sessions can restart quickly.
- Users/stakeholders: Workspace owner and collaborators.
- Current state: Sources and conclusions must be checked against the latest available evidence.
- Key constraints: Separate facts, inferences, and opinions when making recommendations.

## Source Of Truth
- Primary files/URLs/issues: Local notes, source documents, official documentation, current web sources.
- Commands to inspect current state: List local notes, open key documents, refresh current external facts when needed.
- What must be re-verified live: prices, laws, schedules, releases, market data, software behavior, and any time-sensitive claim.

## Decisions
- Accepted decisions: Store source pointers and decision rationale.
- Rejected options: Do not store long copied passages or private credentials.
- Reasons: A good fact map points to evidence instead of replacing it.

## Operating Notes
- Important files/folders: `context/`, `sources/`, `notes/`.
- Useful commands or checks: Search local notes first, then refresh live facts if the topic can drift.
- Tool/plugin/agent routing notes: Use web or official documentation for current external facts.
- Cadence or refresh rule: Mark the pack stale when the topic depends on recent information.

## Risks And Known Pitfalls
- Risk: The pack becomes a generic memory file.
- Symptom: It contains preferences or facts that apply to every future task.
- How to verify: Keep only workspace-specific stable context here.

## Acceptance Rules
- Done means: The next session can understand scope, sources, decisions, risks, and refresh needs in minutes.
- Required verification: Check source pointers and refresh drift-prone facts.
- Do not do: Treat this pack as the only evidence source.

## Open Questions
- Question: Which sources are authoritative for this topic?
- Why it matters: Weak sources create weak downstream decisions.
- How to resolve: Add a short source hierarchy after the first real research pass.

