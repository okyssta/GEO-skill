# Monitoring AI Visibility & Search Rankings

## AI Visibility Monitoring

### Manual Testing (Free, Start Here)

Test your brand/topics across AI platforms:

**ChatGPT (Free tier + Plus):**
```
Prompt templates to test:
- "What is [your brand/topic]?"
- "What are the best [your category] tools?"
- "How does [your product] compare to [competitor]?"
- "Tell me about [specific topic you've written about]"
- "According to [your brand], what is..."
```

**Perplexity:**
- Search the same queries
- Perplexity shows sources — check if you appear in citations
- Track citation position (1st, 2nd, 3rd source listed)

**Claude:**
- Ask the same questions
- Claude sometimes cites sources — check for your content

**Google Gemini / AI Overviews:**
- Search your queries on Google
- Check if AI Overview appears and cites your site

### What to Track

| Metric | How to Measure | Target |
|---|---|---|
| Citation frequency | How often cited across N queries | >30% of relevant queries |
| Citation position | Source ranking in AI answers | Top 3 sources |
| Citation accuracy | Are they quoting you correctly? | 100% accurate |
| Source diversity | Which AI platforms cite you | All major platforms |
| Brand mention | Brand name in AI answers | >50% of brand queries |

### Monitoring Cadence

- **Weekly:** Test 10 core queries across ChatGPT + Perplexity
- **Monthly:** Full audit of 50+ queries, track trends
- **Quarterly:** Competitive analysis — who else is getting cited?

### Paid Monitoring Tools

| Tool | Cost | Features |
|---|---|---|
| **Otterly.ai** | $49+/mo | Tracks brand across ChatGPT, Perplexity, Claude, Gemini |
| **Profound.so** | Custom | Enterprise AI visibility analytics |
| **Semrush AI Toolkit** | Add-on | AI overview tracking in existing SEO workflow |
| **AthenaHQ** | Custom | AI visibility scoring + optimization recs |

### DIY Monitoring Script

Track citations over time with a simple spreadsheet:

```csv
Date,Query,Platform,Cited?,CitationPosition,CitationText,URL_Cited
2025-01-15,"what is GEO",ChatGPT,Yes,2,"GEO is the practice of...",https://yoursite.com/geo
2025-01-15,"what is GEO",Perplexity,Yes,1,"According to yoursite.com...",https://yoursite.com/geo
2025-01-15,"best SEO tools",ChatGPT,No,,,,
```

Run weekly, chart trends, identify queries where you're gaining/losing.

---

## Traditional SEO Monitoring

### Google Search Console (Free)

- **Performance**: Impressions, clicks, CTR, average position
- **Coverage**: Indexed pages, errors, warnings
- **Core Web Vitals**: LCP, FID, CLS scores
- **Sitemaps**: Submit and monitor sitemap processing

### Key SEO Metrics

| Metric | Good | Action if Bad |
|---|---|---|
| Organic traffic | Growing trend | Content quality, technical SEO |
| Average position | Top 10 for target keywords | On-page optimization |
| CTR | >2% average | Better meta titles/descriptions |
| Bounce rate | <60% | Content relevance, page speed |
| Core Web Vitals | All green | Technical optimization |
| Backlinks | Growing, from authoritative sites | Link building, PR |

### Tools

| Tool | Cost | Use Case |
|---|---|---|
| Google Search Console | Free | Official Google data |
| Google Analytics 4 | Free | Traffic analysis |
| Ahrefs | $99+/mo | Backlink analysis, keyword research |
| Semrush | $119+/mo | Comprehensive SEO suite |
| Moz | $99+/mo | Domain authority, keyword tracking |

---

## Combined SEO+GEO Dashboard

### Monthly Report Template

```markdown
# [Month] SEO+GEO Report

## Search Performance (SEO)
- Organic sessions: [N] ([+/-X%] vs last month)
- Top keywords: [list with positions]
- New backlinks: [N] from [domains]
- Core Web Vitals: [status]

## AI Visibility (GEO)
- Queries tested: [N]
- Citation rate: [X%] (up from [Y%])
- Top cited pages: [list]
- New AI platforms citing: [list]

## Content Published
- [N] new articles
- [N] articles updated
- Schema coverage: [X%] of pages

## Action Items
- [ ] [Specific task based on data]
- [ ] [Specific task based on data]
```

---

## A/B Testing for GEO

### What to Test

1. **Statistics in opening paragraphs** — With vs without
2. **Citation-ready formatting** — Long paragraphs vs short, quotable ones
3. **FAQ sections** — With vs without on same topic
4. **Schema markup** — With vs without (measure crawl frequency)
5. **llms.txt** — With vs without (measure AI crawler activity)

### How to Test

1. **Control page**: Existing content, no GEO optimization
2. **Test page**: Same topic, GEO-optimized
3. **Wait 30-60 days** for AI crawlers to re-index
4. **Test both pages** across ChatGPT/Perplexity
5. **Compare citation rates**

### Expected Results (Based on GEO Paper Data)

| Optimization | Expected Visibility Increase |
|---|---|
| Adding statistics | +100-150% |
| Adding FAQ section | +50-100% |
| Adding schema markup | +30-50% |
| Rewriting for quotability | +20-40% |
| Adding llms.txt | +10-20% |

---

## Crawler Activity Monitoring

### Check Which Bots Visit Your Site

**Nginx access logs:**
```bash
# Count AI bot visits in last 7 days
grep -iE "GPTBot|ClaudeBot|PerplexityBot|ChatGPT-User|Bytespider|CCBot|Google-Extended" /var/log/nginx/access.log | awk '{print $1}' | sort | uniq -c | sort -rn

# AI bot visits by page
grep -iE "GPTBot|ClaudeBot|PerplexityBot" /var/log/nginx/access.log | awk '{print $7}' | sort | uniq -c | sort -rn | head -20
```

**Apache logs:**
```bash
grep -iE "GPTBot|ClaudeBot|PerplexityBot" /var/log/apache2/access.log | awk '{print $7}' | sort | uniq -c | sort -rn | head -20
```

### What to Look For

- **Increasing crawl frequency**: Good — AI bots find your content valuable
- **Specific pages crawled most**: Double down on that content type
- **Crawl drops**: Check if you accidentally blocked a bot
- **New bots appearing**: Good — expanding AI platform coverage

### Blocked Bot Detection

```bash
# Check for 403/403 responses to AI bots
grep -iE "GPTBot|ClaudeBot|PerplexityBot" /var/log/nginx/access.log | grep " 403 " | head -10

# If you see 403s for AI bots, check:
# 1. robots.txt (are they disallowed?)
# 2. WAF rules (Cloudflare, AWS WAF)
# 3. Server blocks (nginx deny rules)
# 4. Rate limiting (too aggressive?)
```
