# Style System (Tailwind)

Use inline Tailwind utilities in HTML. Don't touch `src/main.css` — it only contains imports and theme tokens.

## Quick Reference: User Phrases → Tailwind

When users describe what they want in plain language, translate directly:

| User says | Classes to use |
|-----------|---------------|
| "Bigger text" | `text-lg` → `text-xl` → `text-2xl` |
| "Exactly 18px" | `text-[18px]` |
| "More space" | `p-6` → `p-8` → `p-12` |
| "20 pixels of padding" | `p-[20px]` |
| "Our brand orange #FF6B35" | `bg-[#FF6B35]`, `text-[#FF6B35]` |
| "Rounded corners" | `rounded-lg` → `rounded-2xl` → `rounded-full` |
| "Add a shadow" | `shadow` → `shadow-lg` → `shadow-2xl` |
| "Make it centered" | `mx-auto text-center` |
| "Make it stand out" | `shadow-lg`, `ring-2`, `font-bold` |
| "Too cramped" | Increase `p-` / `space-y-` / `gap-` values |
| "Easier to read" | `text-lg leading-relaxed`, higher contrast colors |
| "Add animation to buttons" | `transition-all hover:scale-105` |

## Typography

### Scale

| Element | Classes |
|---------|---------|
| Body text | `text-slate-900` |
| Secondary text | `text-slate-700` |
| Hero headline | `text-4xl sm:text-5xl` or `sm:text-6xl` for more impact |
| Section headings | `text-3xl sm:text-4xl` |
| Body leading | `leading-relaxed` |
| Font weight | `font-bold` for headings, `font-semibold` for subheadings |

### Google Fonts

System fonts are safe but generic — every site ends up looking the same. Adding one Google Font pairing gives a site its own personality with minimal effort. Add the `<link>` tag in `<head>` and apply via Tailwind arbitrary values or CSS variables.

**How to add:**
```html
<!-- In <head> -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Display+Font&family=Body+Font:wght@400;500;600;700&display=swap" rel="stylesheet">
```
```html
<!-- Apply via style or Tailwind arbitrary values -->
<h1 class="font-['Display_Font']">Heading</h1>
<body class="font-['Body_Font']">
```

**Recommended pairings by tone:**

| Tone | Display (headings) | Body (text) | Good for |
|------|-------------------|-------------|----------|
| **Warm & Inviting** | Playfair Display | Source Sans 3 | Restaurants, bakeries, hospitality |
| **Clean & Professional** | DM Sans | DM Sans | Law firms, consulting, finance |
| **Modern & Bold** | Sora | Inter Tight | Tech, startups, SaaS |
| **Friendly & Approachable** | Nunito | Nunito Sans | Health, education, family services |
| **Elegant & Refined** | Cormorant Garamond | Proza Libre | Luxury, wellness, boutique |
| **Playful & Creative** | Space Grotesk | Outfit | Portfolios, agencies, creative |

These are starting points, not mandates. The key is to pick something that matches the business's personality and use it consistently. Avoid mixing more than two font families on one site.

**When to skip custom fonts:** If the user wants maximum performance or simplicity, `system-ui` is fine. Don't force fonts on users who haven't asked.

## Spacing

| Element | Classes |
|---------|---------|
| Section padding | `py-20 sm:py-32` |
| Container | `mx-auto max-w-7xl px-4 sm:px-6 lg:px-8` |
| Card gaps | `gap-6` to `gap-10` |
| Inner spacing | `gap-8` |
| Content margin-top | `mt-16` after section headings |

## Layout

- Grids: `grid-cols-1 md:grid-cols-2` or `lg:grid-cols-3`
- Keep vertical rhythm consistent across sections
- Center section headers with `mx-auto max-w-2xl text-center`

## Components

**Buttons:**
```html
<!-- Primary -->
<a class="rounded-full bg-blue-600 px-6 py-3 text-sm font-semibold text-white hover:bg-blue-700">
  Get Started
</a>

<!-- Secondary -->
<a class="rounded-full bg-slate-100 px-6 py-3 text-sm font-semibold text-slate-900 hover:bg-slate-200">
  Learn More
</a>

<!-- Inverted (on colored backgrounds) -->
<a class="rounded-full bg-white px-6 py-3 text-sm font-semibold text-blue-600 hover:bg-blue-50">
  Contact Us
</a>
```

**Cards:**
```html
<div class="rounded-2xl bg-white p-8 shadow-sm">
  <!-- Card content -->
</div>
```

**Section backgrounds:** Alternate `bg-white` / `bg-slate-50`. Use brand color blocks sparingly — typically only for CTA sections.

## Responsiveness

Mobile-first approach. Add breakpoints progressively:

```
text-base md:text-lg        (text sizing)
p-4 md:p-6 lg:p-8           (padding)
grid-cols-1 md:grid-cols-2 lg:grid-cols-3  (layout)
py-20 sm:py-32               (section spacing)
```

Breakpoints: `sm:` (640px), `md:` (768px), `lg:` (1024px).

## Color System

### Principles

- **Rule of 3:** Choose a Primary, Neutral, and Accent. Primary goes on CTAs and key elements; sections stay neutral.
- **Accessibility:** Text on colored backgrounds needs sufficient contrast. Slate neutrals handle this well.
- **Tokens first:** Prefer Tailwind color tokens (`blue-600`). Use arbitrary values only for exact brand matches (`bg-[#E85D04]`).

### If the user has brand colors

Use their exact color as Primary. Pair with Slate neutrals and pick one subtle Accent that complements.

### Recommended palettes

When the user wants a recommendation, pick the closest match and proceed:

| Industry | Primary | Neutral | Accent |
|----------|---------|---------|--------|
| **Professional / Corporate** | `blue-600` | `slate` | `indigo-500` |
| **Food & Restaurants** | `red-600` | `stone` | `amber-500` |
| **Health & Wellness** | `emerald-600` | `slate` | `teal-500` |
| **Tech / Startup** | `indigo-600` | `slate` | `purple-600` |
| **Creative / Portfolio** | `violet-600` | `zinc` | `pink-500` |

### Application pattern

```
Sections:       bg-white / bg-slate-50  (alternating)
Primary button: bg-<primary> text-white hover:bg-<primary-dark>
Body text:      text-slate-900
Secondary text: text-slate-700
CTA section:    bg-<primary> with white text and inverted button
```

### Examples

```html
<!-- Hero headline -->
<h1 class="text-4xl sm:text-5xl font-bold text-slate-900">Your Headline</h1>

<!-- Feature section with alt background -->
<section class="py-20 sm:py-32 bg-slate-50">...</section>

<!-- Primary CTA button -->
<a class="rounded-full bg-blue-600 px-6 py-3 text-sm font-semibold text-white hover:bg-blue-700">
  Get Started
</a>

<!-- Brand color CTA section -->
<section class="bg-emerald-600 py-16">
  <h2 class="text-3xl font-bold text-white">Ready to Start?</h2>
  <a class="rounded-full bg-white px-6 py-3 text-sm font-semibold text-emerald-600 hover:bg-emerald-50">
    Book Now
  </a>
</section>
```

## Transitions & Micro-Interactions

Small, intentional animations make a site feel polished without overwhelming non-technical users. Keep them subtle — the goal is "smooth and professional," not "flashy."

### Always include

**Button hover transitions** — already in the template, but make sure every interactive element has one:
```html
<a class="... transition-colors duration-200 hover:bg-blue-700">Get Started</a>
```

**Smooth scroll** — already enabled via `scroll-smooth` on `<html>`. Anchor links scroll smoothly by default.

### Recommended additions

**Fade-in on scroll** — sections feel less static when they gently appear. Use a lightweight CSS-only approach with `@keyframes` or Alpine.js `x-intersect`:
```html
<!-- With Alpine.js (already in the template) -->
<section x-data x-intersect.once="$el.classList.add('opacity-100', 'translate-y-0')"
         class="opacity-0 translate-y-4 transition-all duration-700 ease-out">
  ...
</section>
```

**Card hover lift** — gives depth to feature/testimonial cards:
```html
<div class="rounded-2xl bg-white p-8 shadow-sm transition-shadow duration-200 hover:shadow-md">
```

**Image hover zoom** — subtle scale on portfolio or gallery images:
```html
<div class="overflow-hidden rounded-lg">
  <img class="transition-transform duration-300 hover:scale-105" src="..." alt="...">
</div>
```

### What to avoid

- Animations on every element (distracting, hurts performance)
- Long durations (>700ms feels sluggish)
- Layout-shifting animations (things that push other content around)
- Autoplay anything — let the user trigger interactions

One well-done page load with staggered section reveals creates more polish than scattered animations everywhere.
