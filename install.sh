#!/usr/bin/env bash
# aicoder installer — one-liner:
#   curl -fsSL https://aicoder.localhost/install.sh | sh
#
# Detects OS+arch, downloads binary, clones skill repo, symlinks the
# skill into ~/.claude/skills/aicoder. Idempotent: re-running upgrades
# the binary and pulls the latest skill.
set -euo pipefail

REPO="thesatellite-ai/aicoder-public"
CACHE_DIR="${HOME}/.cache/aicoder-public"
CLAUDE_SKILLS="${HOME}/.claude/skills"

# --- locate install dir ---
if [ -w /usr/local/bin ]; then
    BIN_DIR=/usr/local/bin
else
    BIN_DIR="${HOME}/.local/bin"
    mkdir -p "${BIN_DIR}"
fi

# --- detect platform ---
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
case "${ARCH}" in
    x86_64|amd64) ARCH=amd64 ;;
    arm64|aarch64) ARCH=arm64 ;;
    *) echo "Unsupported arch: ${ARCH}" >&2; exit 1 ;;
esac
case "${OS}" in
    darwin|linux) ;;
    *) echo "Unsupported OS: ${OS}" >&2; exit 1 ;;
esac

# --- pick release ---
TAG="${AICODER_VERSION:-latest}"
if [ "${TAG}" = "latest" ]; then
    TAG=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
        | grep -m1 '"tag_name":' \
        | sed -E 's/.*"tag_name":\s*"([^"]+)".*/\1/')
fi
if [ -z "${TAG}" ]; then
    echo "Could not resolve latest release tag" >&2
    exit 1
fi

ASSET="aicoder_${OS}_${ARCH}"
URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET}"

echo "→ downloading ${ASSET} from ${TAG}"
curl -fsSL --progress-bar "${URL}" -o "${BIN_DIR}/aicoder.new"
chmod +x "${BIN_DIR}/aicoder.new"
mv "${BIN_DIR}/aicoder.new" "${BIN_DIR}/aicoder"
echo "  installed to ${BIN_DIR}/aicoder"

# --- skill repo ---
echo "→ syncing skill bundle"
if [ -d "${CACHE_DIR}/.git" ]; then
    git -C "${CACHE_DIR}" pull --quiet --ff-only
else
    git clone --depth 1 "https://github.com/${REPO}.git" "${CACHE_DIR}"
fi

mkdir -p "${CLAUDE_SKILLS}"
ln -sfn "${CACHE_DIR}/skills/aicoder" "${CLAUDE_SKILLS}/aicoder"
echo "  symlinked ${CLAUDE_SKILLS}/aicoder → ${CACHE_DIR}/skills/aicoder"

# --- PATH hint ---
case ":${PATH}:" in
    *:"${BIN_DIR}":*) ;;
    *) echo ""
       echo "Add ${BIN_DIR} to your PATH:"
       echo "  echo 'export PATH=\"${BIN_DIR}:\$PATH\"' >> ~/.profile"
       ;;
esac

echo ""
echo "Done. Run: aicoder login"
