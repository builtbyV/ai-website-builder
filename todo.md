# Color Hierarchy and Section Design Instructions

## Add to AGENTS.md and GEMINI.md

### Location
Add this as a new subsection within the "Working with Tailwind CSS" section (after "Common User Requests → Tailwind Classes")

### Content to Add:

```markdown
### Professional Color Patterns
Landing pages typically alternate background colors to separate sections:

**Common Section Patterns:**
- Hero: `bg-white` (default, no class needed)
- Features: `bg-slate-50`
- Testimonials: `bg-white` 
- CTA: `bg-blue-600` with `text-white`
- Contact: `bg-white`
- Pricing: `bg-slate-50`
- Footer: `bg-slate-50` (light) or `bg-slate-900` (dark alternative)

**Color Hierarchy:**
- Primary text: `text-slate-900` (dark, high contrast)
- Secondary text: `text-slate-700` (descriptions) or `text-slate-600` (meta info)
- Primary buttons: `bg-blue-600 text-white hover:bg-blue-700`
- Secondary buttons: `bg-slate-100 text-slate-900 hover:bg-slate-200`
- Borders/Dividers: `border-slate-200` or `border-slate-400/10`

**Section Spacing:**
- Consistent padding: `py-20 sm:py-32` for main sections
- Smaller sections: `py-16` (like CTA sections)

**Tips:**
- Alternate between white (no class) and `bg-slate-50` for visual separation
- Use your primary color (e.g., blue-600) sparingly - mainly for CTA sections and primary buttons
- For dark footers, use `bg-slate-900` with `text-slate-500` and ensure links are `text-slate-400`
- Keep the existing template patterns unless the user specifically asks for changes
```

## Rationale

This addition is important because:

1. **Visual Hierarchy**: Non-technical users don't know how to create proper visual hierarchy, but they'll notice if it's missing
2. **Section Separation**: Alternating backgrounds is a standard pattern that makes content easier to scan
3. **Color Usage**: Many users either use too many colors or don't know how to use them effectively
4. **Professional Look**: Following these patterns automatically makes websites look more polished

## Implementation Notes

- This should be added to BOTH AGENTS.md and GEMINI.md in the same location
- The AI should apply these patterns automatically, even if users don't specifically ask
- When users say "make it look professional" or "make sections clearer", the AI should use these patterns
- If users provide brand colors, adapt the patterns (e.g., use their primary color instead of blue-600)

## Example Applications

When a user says:
- "Make my website look more professional" → Apply alternating section backgrounds
- "The sections all blend together" → Add bg-slate-50 to every other section
- "Make important buttons stand out" → Use primary color for main CTAs only
- "The text is hard to read" → Check color hierarchy and contrast