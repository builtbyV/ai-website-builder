#!/usr/bin/env bash
set -euo pipefail

# One-command publish to Cloudflare Pages

bash scripts/check-placeholders.sh

echo "🏗️  Building the site..."
npm run build

# Ensure wrangler is available locally; install as devDependency if missing
if ! npx --yes wrangler --version >/dev/null 2>&1; then
  echo "📦 Installing Cloudflare Wrangler locally (devDependency)..."
  npm i -D wrangler@latest
fi

# Prefer OAuth login; token works too if set in env
if ! npx --yes wrangler whoami >/dev/null 2>&1; then
  echo "🔐 Logging into Cloudflare (a browser window may open)..."
  npx --yes wrangler login
fi

PROJECT=${CF_PAGES_PROJECT:-$(basename "$PWD")}
echo "🔎 Using project: $PROJECT"

if ! npx --yes wrangler pages project list | grep -q "^$PROJECT\b"; then
  echo "📦 Creating Cloudflare Pages project '$PROJECT'..."
  npx --yes wrangler pages project create "$PROJECT" --production-branch=main
fi

echo "🚀 Deploying to Cloudflare Pages..."
npx --yes wrangler pages deploy dist --project-name="$PROJECT"
