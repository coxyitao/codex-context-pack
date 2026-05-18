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

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

extract_heredoc() {
  start_line="$1"
  source_file="$2"
  output_file="$3"
  awk -v start="$start_line" '
    $0 == start { inside = 1; next }
    inside && $0 == "EOF" { exit }
    inside { print }
  ' "$source_file" > "$output_file"
}

extract_heredoc '  cat > "$block_file" <<'\''EOF'\''' "$ROOT/install.sh" "$tmp_dir/install-agents-block.md"
extract_heredoc '  cat > "$fact_file" <<'\''EOF'\''' "$ROOT/install.sh" "$tmp_dir/install-context-pack.md"
awk '
  /^```md$/ { inside = 1; next }
  inside && /^```$/ { exit }
  inside { print }
' "$ROOT/skills/context-pack/SKILL.md" > "$tmp_dir/skill-context-pack.md"

cmp -s "$ROOT/templates/AGENTS.context-pack.block.md" "$tmp_dir/install-agents-block.md" || fail "install.sh AGENTS block differs from templates/AGENTS.context-pack.block.md"
cmp -s "$ROOT/templates/context-pack.md" "$tmp_dir/install-context-pack.md" || fail "install.sh fact map template differs from templates/context-pack.md"
cmp -s "$ROOT/templates/context-pack.md" "$tmp_dir/skill-context-pack.md" || fail "SKILL.md embedded template differs from templates/context-pack.md"

printf 'check-public passed\n'
