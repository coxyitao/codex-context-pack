# Install

## One Command

Run this inside the workspace where you want a Context Pack fact map:

```bash
curl -fsSL https://raw.githubusercontent.com/coxyitao/codex-context-pack/main/install.sh | bash
```

The installer:

- installs `skills/context-pack` globally for Codex through `npx skills add`
- merges a marker-delimited Context Pack block into `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`
- creates `context/context-pack.md` in the current directory if it does not exist

Restart Codex after installation.

## Options

```bash
./install.sh --dry-run
./install.sh --project /path/to/workspace
./install.sh --fact-map docs/codex/context-pack.md
./install.sh --fact-map .ai-workflow/context/context-pack.md
./install.sh --no-skill
./install.sh --no-agents
./install.sh --no-fact-map
```

The installer backs up an existing global `AGENTS.md` before modifying it.
It replaces only the marker-delimited block:

```md
<!-- BEGIN CODEX_CONTEXT_PACK -->
...
<!-- END CODEX_CONTEXT_PACK -->
```

It will not overwrite an existing fact map unless `--force` is provided.

