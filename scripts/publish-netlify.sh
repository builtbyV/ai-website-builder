#!/usr/bin/env bash
set -euo pipefail

# One-command publish to Netlify

bash scripts/check-placeholders.sh

echo "🏗️  Building the site..."
npm run build

if ! npx --yes netlify --version >/dev/null 2>&1; then
  echo "📦 Installing Netlify CLI locally (devDependency)..."
  npm i -D netlify-cli
fi

# Login if needed (uses browser OAuth)
if ! npx netlify status >/dev/null 2>&1; then
  echo "🔐 Logging into Netlify..."
  npx netlify login
fi

echo "🚀 Deploying to Netlify (production)..."
# Attempt a direct deploy; Netlify CLI will handle site selection/creation if linked
if ! npx netlify deploy --prod --dir=dist; then
  echo ""
  echo "❌ Netlify deploy did not complete."
  echo "It may be waiting for interactive input to create/link a site."
  echo "As a workaround, run this command manually and follow the prompts:"
  echo "  npx netlify deploy --prod --dir=dist"
  exit 1
fi
