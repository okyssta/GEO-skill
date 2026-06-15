# llms.txt Template

Copy this template and customize for your site. Place at site root (/llms.txt).

---

## Basic Version (minimum viable)

```txt
# [Site Name]

> [One-sentence description of what your site does and who it's for]

## Main Sections
- [Section 1](/section-1): [Brief description]
- [Section 2](/section-2): [Brief description]
- [Blog](/blog): [Brief description of content focus]

## Key Pages
- [About](/about): [Company/author overview]
- [Contact](/contact): [How to reach you]
- [Products/Services](/products): [What you offer]

## Sitemap
- [Sitemap](/sitemap.xml): Full site structure
```

## Full Version (recommended)

```txt
# [Site Name]

> [One-sentence description. Include what makes you unique.]

## About
[Company/Author Name] is a [type of organization] that [mission statement].
Founded in [year], we [key achievement or statistic].

## Main Topics
- [Topic 1](/topic-1): [2-sentence description with key insight]
- [Topic 2](/topic-2): [2-sentence description with key insight]
- [Topic 3](/topic-3): [2-sentence description with key insight]

## Products/Services
### [Product 1]
[Description]. [Key benefit with metric]. Pricing: [range].

### [Product 2]
[Description]. [Key benefit with metric]. Pricing: [range].

## Blog Highlights
### [Top Article Title](/blog/article-slug-1)
[Summary with key finding]. Main statistic: [number].

### [Top Article Title](/blog/article-slug-2)
[Summary with key finding]. Main takeaway: [one sentence].

### [Top Article Title](/blog/article-slug-3)
[Summary with key finding]. Main takeaway: [one sentence].

## Documentation
- [Getting Started](/docs/start): [What this covers]
- [API Reference](/docs/api): [What this covers]
- [FAQ](/faq): Common questions and answers

## Team
### [Author/CEO Name]
[Role]. [Key credential]. [Link to author page].

### [Author Name]
[Role]. [Key credential]. [Link to author page].

## Contact
- Email: [email]
- Twitter: [@handle]
- LinkedIn: [company page]

## Sitemap
- [Sitemap](/sitemap.xml): Full site structure and page listing
```

## E-Commerce Version

```txt
# [Store Name]

> [One-sentence description of your store and what you sell]

## Categories
- [Category 1](/category-1): [Description with price range]
- [Category 2](/category-2): [Description with price range]
- [Category 3](/category-3): [Description with price range]

## Featured Products
### [Product 1 Name]
[Description]. Price: $[X]. [Key benefit]. [Rating if available].

### [Product 2 Name]
[Description]. Price: $[X]. [Key benefit]. [Rating if available].

## Policies
- [Shipping](/shipping): [Brief summary]
- [Returns](/returns): [Brief summary]
- [FAQ](/faq): Common questions

## About
[Store description]. [Unique value proposition]. [Trust signals: years in business, number of customers, etc.]

## Sitemap
- [Sitemap](/sitemap.xml): Full product catalog
```

## Placement by Platform

| Platform | File Location | How to Serve |
|---|---|---|
| Nginx | `/var/www/site/llms.txt` | Auto-served from root |
| Apache | `/var/www/site/llms.txt` | Auto-served from root |
| Cloudflare Pages | `public/llms.txt` | Auto-served |
| Vercel | `public/llms.txt` | Auto-served |
| Netlify | `static/llms.txt` or `public/llms.txt` | Auto-served |
| WordPress | Root of domain | May need .htaccess redirect |
| S3 + CloudFront | S3 object at `/llms.txt` | CloudFront serves it |
| GitHub Pages | `docs/llms.txt` or root | Auto-served |

## Tips

1. **Keep it under 5000 characters** — AI crawlers prefer concise summaries
2. **Update quarterly** — stale llms.txt is worse than no llms.txt
3. **Include statistics** — "Used by 10,000+ customers" not "popular tool"
4. **Link to best content** — AI crawlers follow links in llms.txt
5. **Use plain text** — no HTML, no markdown, just clean text
