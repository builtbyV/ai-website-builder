#!/usr/bin/env bash
set -euo pipefail

# One-command publish to Vercel

bash scripts/check-placeholders.sh

echo "🏗️  Building the site..."
npm run build

if ! npx --yes vercel --version >/dev/null 2>&1; then
  echo "📦 Installing Vercel CLI locally (devDependency)..."
  npm i -D vercel
fi

echo "🚀 Deploying to Vercel..."
# --yes skips all prompts, --prod deploys to production
npx vercel dist --yes --prod
