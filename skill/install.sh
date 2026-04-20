#!/usr/bin/env bash
set -euo pipefail

# Install the ai-website-builder skill directly into your AI tool's skills dir.
# Always installs to:  ~/.claude/skills/ai-website-builder
# Also installs to:    ~/.agents/skills/ai-website-builder  (if ~/.agents/skills exists)

REPO="builtbyV/ai-website-builder"
BRANCH="main"
NAME="ai-website-builder"

TARGETS=("$HOME/.claude/skills")
[ -d "$HOME/.agents/skills" ] && TARGETS+=("$HOME/.agents/skills")

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "Downloading $NAME skill..."
curl -fsSL "https://codeload.github.com/${REPO}/tar.gz/${BRANCH}" \
  | tar -xz -C "$TMP" --strip-components=2 "${NAME}-${BRANCH}/skill"

for BASE in "${TARGETS[@]}"; do
  mkdir -p "$BASE"
  DEST="$BASE/$NAME"
  [ -e "$DEST" ] && { echo "Replacing existing $DEST"; rm -rf "$DEST"; }
  mkdir -p "$DEST"
  cp -R "$TMP/." "$DEST/"
  chmod +x "$DEST/scripts/"*.sh 2>/dev/null || true
  echo "Installed → $DEST"
done

echo ""
echo "Done. Start your AI tool and ask it to build a website."
