#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"

fail() {
  printf 'check-public failed: %s\n' "$*" >&2
  exit 1
}

need_file() {
  [ -f "$ROOT/$1" ] || fail "missing $1"
}

need_file "README.md"
need_file "install.sh"
need_file "skills/context-pack/SKILL.md"
need_file "skills/context-pack/agents/openai.yaml"
need_file "templates/AGENTS.context-pack.block.md"
need_file "templates/context-pack.md"

grep -q '^name: context-pack$' "$ROOT/skills/context-pack/SKILL.md" || fail "missing skill name frontmatter"
grep -q '^description: ' "$ROOT/skills/context-pack/SKILL.md" || fail "missing skill description frontmatter"
grep -q '<!-- BEGIN CODEX_CONTEXT_PACK -->' "$ROOT/templates/AGENTS.context-pack.block.md" || fail "missing AGENTS begin marker"
grep -q '<!-- END CODEX_CONTEXT_PACK -->' "$ROOT/templates/AGENTS.context-pack.block.md" || fail "missing AGENTS end marker"

pattern='(/Users/[^[:space:]/]+|C:\\Users\\[^[:space:]\\]+|gho_[A-Za-z0-9_]+|ghp_[A-Za-z0-9_]+|sk-[A-Za-z0-9_-]{20,}|BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY|api[_-]?key[=:]|password[=:]|token[=:])'

if command -v rg >/dev/null 2>&1; then
  if rg -n --hidden --glob '!.git/**' --glob '!scripts/check-public.sh' "$pattern" "$ROOT"; then
    fail "possible private path or secret found"
  fi
else
  if grep -RInE "$pattern" "$ROOT" --exclude-dir .git --exclude check-public.sh; then
    fail "possible private path or secret found"
  fi
fi

bash -n "$ROOT/install.sh"
bash -n "$ROOT/scripts/check-public.sh"

printf 'check-public passed\n'
