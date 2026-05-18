#!/usr/bin/env bash
set -euo pipefail

REPO="${CODEX_CONTEXT_PACK_REPO:-coxyitao/codex-context-pack}"
CODEX_HOME_DIR="${CODEX_HOME:-$HOME/.codex}"
AGENTS_FILE="$CODEX_HOME_DIR/AGENTS.md"
PROJECT_DIR="$PWD"
FACT_MAP_PATH="context/context-pack.md"
INSTALL_SKILL=1
MERGE_AGENTS=1
CREATE_FACT_MAP=1
DRY_RUN=0
FORCE=0

usage() {
  cat <<'USAGE'
Usage: install.sh [options]

Installs Codex Context Pack:
  - installs the context-pack skill for Codex
  - merges a Context Pack block into $CODEX_HOME/AGENTS.md
  - creates a project-local Context Pack fact map

Options:
  --project DIR       Project/workspace directory for the fact map (default: current directory)
  --fact-map PATH     Fact map path relative to project dir (default: context/context-pack.md)
  --no-skill          Skip Codex skill installation
  --no-agents         Skip AGENTS.md merge
  --no-fact-map       Skip fact map creation
  --force             Overwrite an existing fact map
  --dry-run           Print planned actions without writing files
  -h, --help          Show this help

Environment:
  CODEX_HOME                 Codex config home, defaults to ~/.codex
  CODEX_CONTEXT_PACK_REPO    GitHub repo for npx skills add, defaults to coxyitao/codex-context-pack
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --project)
      PROJECT_DIR="${2:?Missing value for --project}"
      shift 2
      ;;
    --fact-map)
      FACT_MAP_PATH="${2:?Missing value for --fact-map}"
      shift 2
      ;;
    --no-skill)
      INSTALL_SKILL=0
      shift
      ;;
    --no-agents)
      MERGE_AGENTS=0
      shift
      ;;
    --no-fact-map)
      CREATE_FACT_MAP=0
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

say() {
  printf '%s\n' "$*"
}

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    say "[dry-run] $*"
  else
    "$@"
  fi
}

write_agents_block_file() {
  block_file="$1"
  cat > "$block_file" <<'EOF'
<!-- BEGIN CODEX_CONTEXT_PACK -->

## Context Pack

- Use a Context Pack when a workspace or topic needs durable context across sessions, tools, or agents.
- Treat the Context Pack as a local fact map: stable facts, source-of-truth pointers, decisions, verification commands, risks, and acceptance rules.
- Do not use a Context Pack for one-off questions, small edits, raw logs, full chat transcripts, secrets, credentials, or fast-changing facts unless it stores only source links and re-verification rules.
- When facts conflict, prefer this order: latest user instruction, live source of truth, project rules, Context Pack, long-term memory, prior chat.
- Before acting on a Context Pack, re-check anything likely to drift: repository state, tests, issues, docs, current web data, tool availability, and local configuration.
- Keep global rules thin. Put workspace-specific stable facts in the local Context Pack, not in this global file.
- Update a Context Pack only when reusable facts, decisions, source pointers, commands, risks, or acceptance rules change.
- A Context Pack is not a memory replacement, PRD, transcript summary, or substitute for live verification.

<!-- END CODEX_CONTEXT_PACK -->
EOF
}

write_fact_map_file() {
  fact_file="$1"
  cat > "$fact_file" <<'EOF'
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
EOF
}

merge_agents_block() {
  mkdir -p "$CODEX_HOME_DIR"
  tmp_dir="$(mktemp -d)"
  block_file="$tmp_dir/agents-block.md"
  merged_file="$tmp_dir/AGENTS.md"
  write_agents_block_file "$block_file"

  if [ "$DRY_RUN" -eq 1 ]; then
    say "[dry-run] merge Context Pack block into $AGENTS_FILE"
    return
  fi

  if [ -f "$AGENTS_FILE" ]; then
    cp "$AGENTS_FILE" "$AGENTS_FILE.bak.$(date +%Y%m%d%H%M%S)"
  else
    : > "$AGENTS_FILE"
  fi

  if grep -q '<!-- BEGIN CODEX_CONTEXT_PACK -->' "$AGENTS_FILE"; then
    awk -v begin='<!-- BEGIN CODEX_CONTEXT_PACK -->' \
      -v end='<!-- END CODEX_CONTEXT_PACK -->' \
      -v block="$block_file" '
      BEGIN {
        while ((getline line < block) > 0) replacement = replacement line ORS
      }
      $0 == begin {
        printf "%s", replacement
        inside = 1
        next
      }
      $0 == end {
        inside = 0
        next
      }
      inside != 1 { print }
    ' "$AGENTS_FILE" > "$merged_file"
    mv "$merged_file" "$AGENTS_FILE"
  else
    {
      if [ -s "$AGENTS_FILE" ]; then
        printf '\n'
      fi
      cat "$block_file"
    } >> "$AGENTS_FILE"
  fi
}

create_fact_map() {
  fact_file="$PROJECT_DIR/$FACT_MAP_PATH"
  fact_dir="$(dirname "$fact_file")"

  if [ -f "$fact_file" ] && [ "$FORCE" -ne 1 ]; then
    say "Fact map already exists: $fact_file"
    say "Use --force to overwrite it."
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    say "[dry-run] create fact map at $fact_file"
    return
  fi

  mkdir -p "$fact_dir"
  write_fact_map_file "$fact_file"
}

install_skill() {
  if ! command -v npx >/dev/null 2>&1; then
    say "npx is required to install the skill. Install Node.js/npm, then rerun this script." >&2
    exit 1
  fi

  skill_dest="$HOME/.agents/skills/context-pack/SKILL.md"
  if [ -f "$skill_dest" ]; then
    say "Skill already installed: $skill_dest"
    say "Skipping skill installation. Use 'npx skills update -g context-pack' later if you need an update."
    return
  fi

  if [ "$DRY_RUN" -eq 1 ]; then
    say "[dry-run] npx --yes skills add $REPO --global --agent codex --skill context-pack --copy --yes"
    return
  fi

  npx --yes skills add "$REPO" --global --agent codex --skill context-pack --copy --yes
}

say "Codex Context Pack installer"
say "Repository: $REPO"
say "Codex home: $CODEX_HOME_DIR"
say "Project: $PROJECT_DIR"
say "Fact map: $FACT_MAP_PATH"

if [ "$INSTALL_SKILL" -eq 1 ]; then
  install_skill
fi

if [ "$MERGE_AGENTS" -eq 1 ]; then
  merge_agents_block
fi

if [ "$CREATE_FACT_MAP" -eq 1 ]; then
  create_fact_map
fi

say "Done. Restart Codex to pick up newly installed skills."
