---
name: geo-skill
description: "Unified GEO+SEO skill for optimizing websites for both traditional search engines and AI-powered answer engines (ChatGPT, Perplexity, Claude, Gemini). Covers technical setup, content strategy, platform-specific guides, and monitoring."
license: MIT
compatibility: "Works with any web stack: WordPress, React, Vite, Next.js, Hugo, Jekyll, static sites. Requires curl and bash for audit scripts."
metadata:
  version: 1.1.0
  author: Hermes Agent
  hermes:
    tags: [geo, seo, ai-optimization, search-engine, content-strategy, structured-data]
    related_skills: [seo-blog-automation, site-audit-report, elegant-sites]
---

# GEO+SEO: Generative Engine & Search Engine Optimization

A unified skill for optimizing web content to rank in **both** traditional search engines (Google, Bing) **and** AI-powered answer engines (ChatGPT, Perplexity, Claude, Gemini, Bing Copilot).

**Works with:** WordPress, React, Vite, Next.js, static sites, any web stack.

## When to Use This Skill

- Auditing an existing site for GEO+SEO optimization
- Building new content optimized for AI citation and search ranking
- Setting up technical infrastructure (schema, crawlers, llms.txt)
- Monitoring AI visibility across chatbots
- Writing content that gets cited in AI answers AND ranks in Google

## Quick Start

1. **Audit** — Run `scripts/geo-audit.sh` against your site
2. **Fix** — Follow the priority checklist in the audit report
3. **Create** — Use `assets/` for new content
4. **Monitor** — Track AI visibility with the monitoring guide in `references/monitoring.md`

## Installation Pitfalls

### `hermes skills install` Name Collision
If you run `hermes skills install <github-url>` and the hub already has a skill with the same name, **it installs the hub version, not your GitHub repo**. The fix:
```bash
# DON'T: hermes skills install https://github.com/kyssta-exe/GEO-skill
# It may install a different skill from the hub registry

# DO: Clone directly
cd ~/.hermes/skills && git clone https://github.com/kyssta-exe/GEO-skill.git
```
Verify with skill_view — check the content matches what you expect.

### Publishing to GitHub
Use `gh repo create` with `--source . --push` to create a private repo and push in one step:
```bash
cd /path/to/skill-dir
gh repo create GEO-skill --private --source . --push \
  --description "Description here"
```

## Core Principles

### The GEO+SEO Overlap

Traditional SEO and GEO are NOT separate strategies — they share 70%+ of the same fundamentals. The key additions for GEO are:

| SEO Foundation | GEO Addition |
|---|---|
| Keyword research | Question-intent research (How/What/Why queries) |
| Meta descriptions | Citation-ready paragraph formatting |
| Backlinks | Cross-source entity consistency |
| Page speed | AI crawler accessibility |
| Mobile-first | Structured data for LLM parsing |
| Content length | Quotable, self-contained passages |

### The #1 Rule

**Be the primary source.** AI engines cite original data, unique research, and authoritative claims — not aggregated rehashed content. Every optimization technique below is useless without this foundation.

---

## Contents

### References (detailed guides)
- `references/technical-setup.md` — robots.txt, llms.txt, schema, crawler config
- `references/content-strategy.md` — writing for AI citation + search ranking
- `references/platform-guides.md` — WordPress, React/Vite, Next.js, static site specifics
- `references/monitoring.md` — tracking AI visibility and search rankings
- `references/geo-paper-findings.md` — original research paper results and data

### Scripts
- `scripts/geo-audit.sh` — site-wide GEO+SEO audit
- `scripts/robots-check.sh` — verify AI crawler access
- `scripts/schema-validator.py` — validate structured data

### Templates
- `assets/geo-article.md` — article template optimized for both GEO and SEO
- `assets/faq-section.md` — FAQ template with schema markup
- `assets/llms-txt.md` — llms.txt file template
- `assets/meta-tags.html` — meta tag template with Open Graph + schema

---

## Priority Checklist (do these first)

### Immediate (do today)
1. [ ] Audit `robots.txt` — allow GPTBot, ClaudeBot, PerplexityBot
2. [ ] Add `llms.txt` to site root
3. [ ] Verify schema.org markup on key pages
4. [ ] Check that AI crawlers aren't blocked by firewalls/CDN

### This Week
5. [ ] Add FAQ schema to top 10 pages
6. [ ] Rewrite opening paragraphs with statistics/data
7. [ ] Add author bylines with credentials to all content
8. [ ] Create citation-ready summary paragraphs for key topics

### This Month
9. [ ] Audit all content for "quotability" — standalone paragraphs
10. [ ] Build entity presence (Wikipedia, Wikidata, authoritative directories)
11. [ ] Set up AI visibility monitoring
12. [ ] Create content calendar with GEO-optimized article templates

---

## Platform-Specific Notes

See `references/platform-guides.md` for stack-specific implementation:

- **WordPress**: Yoast/RankMath + custom schema, llms.txt plugin or manual
- **React/Vite**: Static rendering critical, SSG preferred, meta tag injection
- **Next.js**: App Router metadata API, ISR for freshness, structured data
- **Static (Hugo/Jekyll)**: Build-time schema, llms.txt in public/
- **Custom**: Manual implementation of all technical foundations

---

## Anti-Patterns (what NOT to do)

1. **Don't block AI crawlers to "protect content"** — you're invisible to AI answers
2. **Don't keyword stuff** — AI engines parse semantics, not keyword density
3. **Don't write clickbait titles** — AI cites factual, definitive claims
4. **Don't hide content behind JS rendering** — AI crawlers prefer static HTML
5. **Don't copy/rewrite competitor content** — AI cites primary sources
6. **Don't ignore freshness** — AI engines heavily weight recent content
7. **Don't use AI to generate thin content at scale** — AI engines detect and deprioritize

---

## Measuring Success

### SEO Metrics (traditional)
- Google Search Console: impressions, clicks, position
- Backlink count and quality
- Core Web Vitals scores

### GEO Metrics (new)
- **Citation frequency**: How often AI chatbots cite your site
- **Citation accuracy**: Are they quoting you correctly?
- **Brand mention rate**: How often your brand appears in AI answers
- **Source diversity**: Which AI platforms cite you (ChatGPT vs Perplexity vs Claude)
- **Query coverage**: How many relevant queries trigger your content

### Tools for Measurement
- **Otterly.ai** — AI search monitoring across chatbots
- **Profound.so** — Brand presence tracking in AI answers
- **Google Search Console** — Traditional search metrics
- **Manual testing** — Query ChatGPT/Perplexity/Claude about your topics

---

## Research Foundation

This skill is built on:
- **GEO Paper** (arXiv:2311.09735) — Princeton/Georgetown, Nov 2023
- **GEO-Bench** (arXiv:2311.13709) — Framework for benchmarking AI visibility
- **Industry data** from Semrush, Ahrefs, Profound, Otterly.ai (2024-2025)
- **Practical testing** across ChatGPT, Perplexity, Claude, Gemini, Bing Copilot
