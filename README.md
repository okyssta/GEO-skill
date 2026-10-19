# GEO+SEO Skill

**The ultimate Generative Engine Optimization + Search Engine Optimization skill.**

Works with any web stack — WordPress, React, Vite, Next.js, Hugo, Jekyll, static sites, custom builds.

## What This Is

A comprehensive skill for AI agents (Hermes, Claude Code, Codex, etc.) that provides everything needed to optimize a website for **both** traditional search engines (Google, Bing) **and** AI-powered answer engines (ChatGPT, Perplexity, Claude, Gemini).

## Quick Start

### For AI Agents
```bash
# Install as a Hermes skill
hermes skills install https://github.com/okyssta/GEO-skill

# Or clone and use directly
git clone https://github.com/okyssta/GEO-skill.git
```

### For Humans
1. Run the audit script: `bash scripts/geo-audit.sh https://yoursite.com`
2. Follow the priority checklist in `SKILL.md`
3. Use templates for new content
4. Monitor with the guides in `references/monitoring.md`

## What's Inside

```
GEO-skill/
├── SKILL.md                          # Main skill file (load this first)
├── references/
│   ├── technical-setup.md            # robots.txt, llms.txt, schema, crawlers
│   ├── content-strategy.md           # Writing for AI citation + search ranking
│   ├── platform-guides.md            # WordPress, React, Next.js, static sites
│   ├── monitoring.md                 # AI visibility + SEO tracking
│   └── geo-paper-findings.md         # Original research paper data
├── scripts/
│   ├── geo-audit.sh                  # Full site GEO+SEO audit
│   ├── robots-check.sh               # AI crawler access verification
│   └── schema-validator.py           # JSON-LD schema validation
└── templates/
    ├── geo-article.md                # Article template optimized for both
    ├── faq-section.md                # FAQ with schema markup
    ├── llms-txt.md                   # llms.txt file templates
    └── meta-tags.html                # Complete meta tag templates
```

## Key Features

- **Unified GEO+SEO approach** — not two separate strategies, one integrated system
- **Platform-specific guides** — WordPress, React/Vite, Next.js, Hugo, Jekyll
- **Audit scripts** — automated site-wide GEO+SEO assessment
- **Content templates** — copy-paste templates for articles, FAQs, meta tags
- **Monitoring guides** — track AI visibility across ChatGPT, Perplexity, Claude
- **Research-backed** — built on the original GEO paper (arXiv:2311.09735)

## Research Foundation

Built on:
- **GEO Paper** (arXiv:2311.09735) — Princeton/Georgetown, Nov 2023
- **GEO-Bench** (arXiv:2311.13709) — Benchmarking framework
- **Industry data** from Semrush, Ahrefs, Profound, Otterly.ai (2024-2025)

Key finding: Adding statistics to content increased AI visibility by **115%** across ChatGPT, Perplexity, and Claude.

## License

MIT
