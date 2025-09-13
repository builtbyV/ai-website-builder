#!/usr/bin/env bash
#
# GitHub Pages publish script
#
# Vite base path handling:
# - Local development: vite.config.js has no `base` setting.
# - GitHub Pages: this script runs scripts/update-vite-base.mjs to set
#   `base: '/<repo>/'` before building, so assets resolve under the repo path.
# - Other providers (Cloudflare/Netlify/Vercel): no `base` needed.
#
# Custom domain caveat (GitHub Pages):
# - If you later switch the Pages project to a custom domain (e.g., mybusiness.com),
#   remove the `base` from vite.config.js (or set it to '/').
#
# This script is idempotent:
# - Adds the Pages workflow if missing, commits and pushes it
# - Re-runs the base updater safely
# - Switches Pages to GitHub Actions builds
#
set -euo pipefail

# One-command publish to GitHub Pages
# - Checks placeholders
# - Ensures repo and remote exist, pushes main
# - Ensures GH auth via device flow if needed
# - Updates vite base (if not already dynamic) and pushes
# - Switches Pages to GitHub Actions builds

ROOT_DIR=$(pwd)

if [ ! -f "$ROOT_DIR/index.html" ]; then
  echo "❌ index.html not found. Please run from your project root."
  exit 1
fi

bash scripts/check-placeholders.sh

if ! command -v gh >/dev/null 2>&1; then
  echo "❌ GitHub CLI (gh) not found."
  echo "   Install from: https://cli.github.com"
  echo "   - macOS: brew install gh"
  echo "   - Windows: winget install --id GitHub.cli"
  echo "   - Linux: See https://github.com/cli/cli#installation"
  exit 1
fi

# Init repo if needed
if [ ! -d .git ]; then
  echo "📦 Initializing git repository..."
  git init -b main
  git add -A
  git commit -m "Initial site setup"
fi

# Ensure GitHub auth
if ! gh auth status >/dev/null 2>&1; then
  echo "🔐 Logging into GitHub via device flow..."
  gh auth login --hostname github.com --git-protocol https --device
fi

# Create remote if missing, push main
if ! git remote -v | grep -q 'github.com'; then
  echo "📡 Creating GitHub repository and pushing..."
  gh repo create --source . --public --push -y
else
  echo "⬆️  Pushing to origin/main..."
  git push -u origin main
fi

# Update Vite base for Pages (safe to re-run)
if command -v node >/dev/null 2>&1; then
  node scripts/update-vite-base.mjs || true
  if ! git diff --quiet -- vite.config.js; then
    git add vite.config.js
    git commit -m "chore: set Vite base for GitHub Pages"
    git push
  fi
fi

# Ensure GitHub Actions workflow for Pages exists
if [ ! -f .github/workflows/deploy.yml ]; then
  echo "🧩 Adding GitHub Pages workflow (.github/workflows/deploy.yml)..."
  mkdir -p .github/workflows
  cat > .github/workflows/deploy.yml << 'EOF'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 20
          
      - name: Install dependencies
        run: npm ci || npm install
        
      - name: Build
        run: npm run build
        
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF
  git add .github/workflows/deploy.yml
  git commit -m "chore: add GitHub Pages workflow"
  git push
fi

# Switch Pages to GitHub Actions workflow builds (idempotent)
OWNER=$(gh repo view --json owner --jq .owner.login)
REPO=$(gh repo view --json name  --jq .name)

echo "🔧 Ensuring GitHub Pages is configured to use Actions..."
gh api -X POST "repos/$OWNER/$REPO/pages" -f build_type=workflow >/dev/null 2>&1 || \
gh api -X PUT  "repos/$OWNER/$REPO/pages" -f build_type=workflow >/dev/null 2>&1 || true

echo "✅ Publishing initiated. GitHub Actions will build and deploy to Pages."
echo "🔎 Track progress: https://github.com/$OWNER/$REPO/actions"
echo "🌐 Site URL (once live): https://$OWNER.github.io/$REPO/"
