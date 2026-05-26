# aicoder-public

Public release repo for **aicoder** — a coding-agent task management system.

This repo ships:

- The **`aicoder` skill** for Claude Code (`skills/aicoder/`) — SKILL.md, entity docs, playbooks, prompts
- Cross-compiled **CLI binaries** as GitHub Releases (darwin/linux × amd64/arm64)
- The **install script** (`install.sh`) the one-liner pulls

The CLI source itself lives in a sibling repo: `aicoder-client/` (see [aicoder-client README](../aicoder-client/README.md)). The server lives in `aicoder-cli-go/`.

## Install

```sh
curl -fsSL https://aicoder.localhost/install.sh | sh
```

The script:

1. Detects OS + arch
2. Downloads the latest `aicoder` binary from this repo's GitHub Releases
3. Drops it at `/usr/local/bin/aicoder` (or `~/.local/bin/aicoder` if non-root)
4. Clones this repo (shallow) into `~/.cache/aicoder-public`
5. Symlinks `skills/aicoder` into `~/.claude/skills/aicoder`
6. Prints the next-step hint: `aicoder login`

Or, equivalent manual steps:

```sh
# 1. binary
LATEST=$(curl -fsSL https://api.github.com/repos/thesatellite-ai/aicoder-public/releases/latest | jq -r .tag_name)
OS=$(uname -s | tr A-Z a-z); ARCH=$(uname -m)
curl -fsSL "https://github.com/thesatellite-ai/aicoder-public/releases/download/${LATEST}/aicoder_${OS}_${ARCH}" -o /usr/local/bin/aicoder
chmod +x /usr/local/bin/aicoder

# 2. skill
git clone --depth 1 https://github.com/thesatellite-ai/aicoder-public ~/.cache/aicoder-public
ln -sfn ~/.cache/aicoder-public/skills/aicoder ~/.claude/skills/aicoder

# 3. connect
aicoder login
```

`aicoder skill install` / `aicoder skill update` automate steps 2 + a `git pull` of the cache.

## What's in `skills/aicoder/`

| File / dir | Purpose |
|---|---|
| `SKILL.md` | Claude Code skill spec — frontmatter + decision tree |
| `API.md` | Full GraphQL surface (every Query / Mutation / Input / Enum) |
| `entities/` | One MD per entity (Task, Project, Spec, Plan, Decision, Memory, Run, ...) |
| `playbooks/` | 10 end-to-end recipes (spec-to-ship, run-lifecycle, multi-agent, recovery, ...) |
| `prompts/` | 6 reusable prompts (api-cheatsheet, capture-decision, postmortem, ...) |

Editing the skill: edit it **here** and push. `aicoder skill update` pulls latest on user machines.

## License

MIT.
