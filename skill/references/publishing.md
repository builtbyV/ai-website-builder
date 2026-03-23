# Publishing Flow

## Pre-Publish Audit

Block publishing until these checks pass. This protects the user from putting a half-finished site online.

### What must be clean

- No bracket placeholders (`[Business Name]`, `[Your phone]`, etc.)
- No `yourwebsite.com` template URLs
- No `placehold.co` placeholder images
- No `lorem ipsum` filler text
- Head and social meta tags present and specific: `<title>`, `<meta name="description">`, `og:url`, `og:title`, `og:description`, `og:image`
- Image and nav links all resolve

### Full project scan

Run this across all HTML files (excluding setup-guide.html):

```bash
grep -RInE '\[[^]]+\]|yourwebsite\.com|placehold\.co|lorem ipsum' \
  --include='*.html' --exclude='setup-guide.html' .

# Quick counts
echo "Placeholders:   $(grep -RohE '\[[^]]+\]' --include='*.html' --exclude='setup-guide.html' . | wc -l)"
echo "Template URLs:  $(grep -Roh 'yourwebsite\.com' --include='*.html' --exclude='setup-guide.html' . | wc -l)"
echo "Placeholder img:$(grep -Roh 'placehold\.co' --include='*.html' --exclude='setup-guide.html' . | wc -l)"
```

**Portable fallback** (if local `grep` lacks include/exclude):

```bash
find . -type f -name '*.html' ! -name 'setup-guide.html' -print0 | \
xargs -0 grep -nE '\[[^]]+\]|yourwebsite\.com|placehold\.co|lorem ipsum'
```

**Single page check:**

```bash
grep "\[" index.html | grep -v "^\s*//" | grep -v "<!--"
```

The publish scripts also run `scripts/check-placeholders.sh` as a fast check, but always run the full scan above before publishing.

### og:url source of truth

Derive from the Git remote for GitHub Pages:

```
https://<username>.github.io/<repo>/
# Get username/repo with: git remote get-url origin
```

## One-Command Publishing

### Set auth expectations first

When the user says "publish" or "deploy", explain the auth flow BEFORE giving the command. Example:

> Let's publish to Netlify! Here's what to expect:
>
> Run this command: `npm run publish:netlify`
>
> A browser window will open for you to sign in (first time only). After login, return to the terminal — it will continue automatically and show your live URL.

### Platform auth flows

| Platform | What happens |
|----------|-------------|
| **GitHub Pages** | Opens browser for GitHub login via device flow. You'll see a code to enter, then return to terminal. |
| **Cloudflare** | Opens browser for Cloudflare OAuth. Sign in and authorize. |
| **Netlify** | Opens browser to log in. Deployment continues automatically after auth. |
| **Vercel** | Opens browser for Vercel login. Complete auth to see deployment URL. |

### Command mapping

| User wants | Command |
|------------|---------|
| GitHub Pages | `npm run publish:github` |
| Cloudflare | `npm run publish:cloudflare` |
| Netlify | `npm run publish:netlify` |
| Vercel | `npm run publish:vercel` |
| Not sure / show options | `npm run deploy` |

### Rules

- **Scripts first:** Always use the commands above. They handle building, deploying, and configuration.
- **No spontaneous configs:** Do NOT create `netlify.toml`, `vercel.json`, `wrangler.toml`, or GitHub Actions YAML unless the user explicitly asks for advanced customization (forms, redirects, headers, functions, monorepo tweaks).
- **Fallback only if scripts fail:** Re-run after fixing the reported error. Only offer a minimal config file if needed to address the specific failure — explain why and keep it tiny.

### What NOT to do

- Jump straight to creating config files
- Suggest manual deployment as the first option
- Assume the scripts won't work
- Create deployment configs "just in case"

## Manual Fallback (GitHub Desktop)

If the user prefers a manual flow:

1. Stage and commit changes locally
2. Guide them to push with GitHub Desktop
3. Ensure Vite `base: '/<repo>/'` for GitHub Pages subfolder hosting
4. Confirm Actions success and the live site URL

## Division of Labor

- **AI:** Edit files, stage, commit, verify audits, guide the user to run publish commands
- **User/CLI:** Authentication, pushing, provider selection
- Never push silently — explicit user action (running a publish command or using Desktop) is always required

## Diagnostics

| Problem | Fix |
|---------|-----|
| Broken visuals online | Recheck Vite `base`; confirm Actions success (GitHub) or CLI output URL (other providers); hard-refresh browser |
| Missing images | Verify assets exist under `/public/images/` and HTML uses path `/images/...` |
| First GitHub build failure | Ensure Pages source is set to **GitHub Actions**; re-run the workflow (the publish script attempts this automatically) |
| Preview not running | Ask user to run `npm run dev` and open `http://localhost:5173` |

### Deployment script stuck

If a script seems stuck waiting for input:

1. Press **Ctrl+C** to cancel — the scripts are designed to be non-interactive
2. Report the issue so the script can be fixed
3. As a workaround, run the provider command directly:

| Provider | Direct command |
|----------|---------------|
| Netlify | `npx netlify deploy --prod --dir=dist` |
| Vercel | `npx vercel dist --yes --prod` |
| Cloudflare | `npx wrangler pages deploy dist` |

## Custom Domain (optional)

Only relevant if the user has purchased their own domain (e.g., `mybusiness.com`). Most users won't need this — GitHub Pages subdomains work fine.

### GitHub Pages with custom domain

1. Create `/public/CNAME` with just the domain:
   ```
   mybusiness.com
   ```

2. Remove the `base` property from `vite.config.js` (custom domains serve from root):
   ```javascript
   export default defineConfig({
     plugins: [tailwindcss()],
     // No base property for custom domains
   })
   ```

3. Configure DNS with the domain provider:
   - **Apex domain** (`example.com`): Add A records pointing to GitHub's IPs
   - **Subdomain** (`www.example.com`): Add CNAME record pointing to `<username>.github.io`

4. Enable in GitHub: Settings → Pages → Custom domain → enter the domain

5. Update `og:url` meta tag to the custom domain

### Other providers

Cloudflare, Netlify, and Vercel all have custom domain support built into their dashboards. The publish scripts handle the initial deploy — adding a custom domain is done through each provider's web UI after the first deploy.
