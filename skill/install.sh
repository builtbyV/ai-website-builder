#!/usr/bin/env bash
set -euo pipefail

# Install the ai-website-builder skill (fully self-contained)
# Downloads into ./ai-website-builder-skill/

REPO="builtbyV/ai-website-builder"
BRANCH="main"
BASE="https://raw.githubusercontent.com/${REPO}/${BRANCH}/skill"
DIR="ai-website-builder-skill"

if [ -d "$DIR" ]; then
  echo "Directory '$DIR' already exists. Remove it first or install elsewhere."
  exit 1
fi

echo "Downloading ai-website-builder skill..."

mkdir -p "$DIR/references" "$DIR/scripts" "$DIR/assets/src" "$DIR/assets/public"

# Core skill
curl -sfL "$BASE/SKILL.md"                          -o "$DIR/SKILL.md"

# References
curl -sfL "$BASE/references/style-system.md"        -o "$DIR/references/style-system.md"
curl -sfL "$BASE/references/publishing.md"           -o "$DIR/references/publishing.md"

# Scripts
curl -sfL "$BASE/scripts/check-placeholders.sh"      -o "$DIR/scripts/check-placeholders.sh"
curl -sfL "$BASE/scripts/deploy.sh"                   -o "$DIR/scripts/deploy.sh"
curl -sfL "$BASE/scripts/publish-github.sh"           -o "$DIR/scripts/publish-github.sh"
curl -sfL "$BASE/scripts/publish-cloudflare.sh"       -o "$DIR/scripts/publish-cloudflare.sh"
curl -sfL "$BASE/scripts/publish-netlify.sh"          -o "$DIR/scripts/publish-netlify.sh"
curl -sfL "$BASE/scripts/publish-vercel.sh"           -o "$DIR/scripts/publish-vercel.sh"
curl -sfL "$BASE/scripts/update-vite-base.mjs"        -o "$DIR/scripts/update-vite-base.mjs"

# Template assets
curl -sfL "$BASE/assets/index.html"                   -o "$DIR/assets/index.html"
curl -sfL "$BASE/assets/vite.config.js"               -o "$DIR/assets/vite.config.js"
curl -sfL "$BASE/assets/package.json"                  -o "$DIR/assets/package.json"
curl -sfL "$BASE/assets/.gitignore"                    -o "$DIR/assets/.gitignore"
curl -sfL "$BASE/assets/src/main.css"                  -o "$DIR/assets/src/main.css"
curl -sfL "$BASE/assets/public/favicon.ico"            -o "$DIR/assets/public/favicon.ico"

chmod +x "$DIR/scripts/"*.sh

echo ""
echo "Installed to ./$DIR/"
echo ""
echo "The skill includes instructions, starter template, and publish scripts."
echo "Move it to your AI tool's skills directory to start building websites."
