#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Where would you like to deploy your website?"
echo ""
echo "1) GitHub Pages    (Free, github.io domain)"
echo "2) Cloudflare      (Fast global CDN)"
echo "3) Netlify         (Easy custom domains)"
echo "4) Vercel          (Great for modern apps)"
echo ""
read -r -p "Enter your choice (1-4): " choice

case "${choice}" in
  1)
    npm run publish:github
    ;;
  2)
    npm run publish:cloudflare
    ;;
  3)
    npm run publish:netlify
    ;;
  4)
    npm run publish:vercel
    ;;
  *)
    echo "Invalid choice. Please run again and select 1-4."
    exit 1
    ;;
esac
