#!/usr/bin/env node
/**
 * Vite base path updater for GitHub Pages
 *
 * What it does
 * - Reads vite.config.js and ensures `base: '/<repo>/'` is set
 *   using the repository name from `git remote get-url origin`.
 * - Keeps local config simple (no env-based dynamic base).
 *
 * When to use
 * - Called by scripts/publish-github.sh before building for GitHub Pages.
 * - No changes are needed (and none are made) for Cloudflare/Netlify/Vercel.
 *
 * Custom domain caveat (GitHub Pages)
 * - If you later switch your Pages site to a custom domain (e.g., mybusiness.com),
 *   remove the `base` from vite.config.js (or set it to '/').
 */
import { readFileSync, writeFileSync } from 'fs'
import { execSync } from 'child_process'

// Updates vite.config.js base to '/<repo>/' when using GitHub Pages
// Keeps local config simple (no env-based dynamic base)

try {
  const configPath = 'vite.config.js'
  const original = readFileSync(configPath, 'utf8')

  // Extract repo name from git remote if available
  let repo = ''
  try {
    const remote = execSync('git remote get-url origin', { encoding: 'utf8' }).trim()
    const match = remote.match(/[:\\/](?<name>[^\\/.]+)\.git$|[:\\/](?<name2>[^\\/.]+)$/)
    repo = (match && (match.groups.name || match.groups.name2)) || ''
  } catch {
    // ignore
  }

  if (!repo) {
    console.error('⚠️  Could not determine repository name from git remote. Leaving vite.config.js unchanged.')
    process.exit(1)
  }

  let updated = original
  if (!original.includes('base:')) {
    // Add base after plugins array
    updated = original.replace(/plugins:\s*\[[^\]]*\]/, (m) => `${m},\n  base: '/${repo}/'`)
  } else {
    // Update existing base
    updated = original.replace(/base:\s*['"`][^'"`]*['"`]/, `base: '/${repo}/'`)
  }

  writeFileSync(configPath, updated)
  console.log(`✅ Updated vite.config.js base to '/${repo}/'`)
} catch (e) {
  console.error('❌ Failed to update vite.config.js:', e.message)
  process.exit(1)
}
