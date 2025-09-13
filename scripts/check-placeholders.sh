#!/usr/bin/env bash
set -euo pipefail

# Placeholder checker for top‑level HTML pages (excluding setup-guide.html)
# - Ignores CSS/Tailwind bracket values inside class/style attributes
# - Flags bracketed placeholders like [Business Name]
# - Flags placehold.co images and yourwebsite.com template URLs

PLACEHOLDERS=0
PLACEHOLDER_IMAGES=0
TEMPLATE_URLS=0

# Only scan top‑level HTML files (what ships), not docs or nested examples
HTML_FILES=$(find . -maxdepth 1 -type f -name '*.html' ! -name 'setup-guide.html' ! -name 'guide.html')

if [ -z "${HTML_FILES}" ]; then
  echo "❌ No top-level HTML files found (excluding setup-guide.html). Run this from your project root."
  exit 1
fi

for file in ${HTML_FILES}; do
  # Remove HTML comments first
  sanitized=$(sed -E ':a;N;$!ba;s/<!--(.|\n)*?-->//g' "$file" 2>/dev/null || true)

  # Drop class/style attributes to avoid CSS/Tailwind bracket tokens (e.g., grid-cols-[auto,1fr], bg-[#000])
  stripped=$(printf "%s" "$sanitized" | sed -E "s/class=\"[^\"]*\"//g; s/class='[^']*'//g; s/style=\"[^\"]*\"//g; s/style='[^']*'//g")

  # Count bracket placeholders on stripped content (visible text, alt/meta, etc.)
  p=$(printf "%s" "$stripped" | grep -o '\[[^]]*\]' 2>/dev/null | wc -l | tr -d ' ' || true)

  # Count image/template placeholders on original sanitized content
  pi=$(printf "%s" "$sanitized" | grep -o 'placehold\.co' 2>/dev/null | wc -l | tr -d ' ' || true)
  tu=$(printf "%s" "$sanitized" | grep -o 'yourwebsite\.com' 2>/dev/null | wc -l | tr -d ' ' || true)

  PLACEHOLDERS=$((PLACEHOLDERS + p))
  PLACEHOLDER_IMAGES=$((PLACEHOLDER_IMAGES + pi))
  TEMPLATE_URLS=$((TEMPLATE_URLS + tu))
done

if [ "$PLACEHOLDERS" -gt 0 ] || [ "$PLACEHOLDER_IMAGES" -gt 0 ] || [ "$TEMPLATE_URLS" -gt 0 ]; then
  echo "⚠️  Found placeholders across top‑level HTML files (excluding setup-guide.html):"
  [ "$PLACEHOLDERS" -gt 0 ] && echo "   - $PLACEHOLDERS bracketed placeholders"
  [ "$PLACEHOLDER_IMAGES" -gt 0 ] && echo "   - $PLACEHOLDER_IMAGES placeholder images"
  [ "$TEMPLATE_URLS" -gt 0 ] && echo "   - $TEMPLATE_URLS template URLs"
  echo ""
  echo "Please update these before publishing."
  exit 1
fi

echo "✅ No placeholders found (excluding setup-guide.html)"
