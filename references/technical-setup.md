# Technical Setup Guide

Complete technical infrastructure for GEO+SEO optimization across any web stack.

## robots.txt Configuration

### Essential AI Crawler Allowlisting

```txt
# AI Crawlers — explicitly allow
User-agent: GPTBot
Allow: /

User-agent: ChatGPT-User
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Bytespider
Allow: /

User-agent: CCBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: Amazonbot
Allow: /

# Traditional Search — allow all
User-agent: Googlebot
Allow: /

User-agent: Bingbot
Allow: /

User-agent: Yandex
Allow: /

# Block scrapers and bad actors
User-agent: SemrushBot
Disallow: /

User-agent: AhrefsBot
Disallow: /

User-agent: DotBot
Disallow: /

# Default
User-agent: *
Allow: /
Sitemap: https://yoursite.com/sitemap.xml
```

### Crawler Behavior Differences

| Crawler | Owner | Behavior | Traffic Back? |
|---|---|---|---|
| GPTBot | OpenAI | Training data + browsing | No |
| ChatGPT-User | OpenAI | Real-time browsing | Yes (referral) |
| ClaudeBot | Anthropic | Training + retrieval | No |
| PerplexityBot | Perplexity | Real-time search | Yes (referral) |
| Google-Extended | Google | Gemini training | No |
| Bytespider | ByteDance | Douyin/TikTok LLM training | No |
| CCBot | Common Crawl | Open crawl data | No |
| Amazonbot | Amazon | Alexa/AI services | No |

**Key insight:** RAG-based crawlers (ChatGPT-User, PerplexityBot) send referral traffic. Training crawlers (GPTBot, ClaudeBot) don't. But training crawlers determine whether your content appears in future AI model responses.

## llms.txt

### What It Is

A file at your site root that tells AI crawlers how to understand your site. Proposed by Jeremy Howard (fast.ai). Like robots.txt but for LLMs.

### Basic llms.txt

```txt
# Site Name

> One-line description of your site

## Main Topics
- Topic 1: Brief description
- Topic 2: Brief description
- Topic 3: Brief description

## Key Pages
- [About](/about): Company overview and mission
- [Products](/products): Our product lineup
- [Blog](/blog): Latest articles and research
- [Documentation](/docs): Technical documentation
- [Contact](/contact): How to reach us

## API
- [API Reference](/api/docs): REST API documentation
- [Rate Limits](/api/limits): Usage limits and pricing
```

### llms-full.txt

A more detailed version with content summaries:

```txt
# Site Name — Full Content Summary

## About
[Company Name] is a [industry] company founded in [year]. We [mission].
Key facts: [3-5 bullet points with statistics].

## Products
### Product A
Description, key features, pricing. Used by [N] customers in [industries].

### Product B
Description, key features, pricing. [Key metric: saves X hours/week].

## Blog Highlights
### [Article Title] (2025-01-15)
Summary of key findings. Main statistic: [number]. Conclusion: [one line].

### [Article Title] (2025-01-10)
Summary of key findings. Main takeaway: [one line].
```

### Platform-Specific Placement

| Platform | Location |
|---|---|
| Static site (Hugo/Jekyll) | `static/llms.txt` or `public/llms.txt` |
| React/Vite | `public/llms.txt` |
| Next.js | `public/llms.txt` (auto-served from public/) |
| WordPress | Root of domain or `/wp-content/uploads/llms.txt` + redirect |
| Nginx | Add alias: `location = /llms.txt { alias /path/to/llms.txt; }` |
| Apache | `.htaccess`: `Redirect /llms.txt /path/to/llms.txt` |

## Schema.org Structured Data

### Priority Schemas (implement in order)

#### 1. Organization Schema (every site)
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Your Company",
  "url": "https://yoursite.com",
  "logo": "https://yoursite.com/logo.png",
  "description": "One-line description",
  "foundingDate": "2020",
  "sameAs": [
    "https://twitter.com/yourcompany",
    "https://linkedin.com/company/yourcompany",
    "https://github.com/yourcompany"
  ],
  "contactPoint": {
    "@type": "ContactPoint",
    "contactType": "sales",
    "email": "hello@yoursite.com"
  }
}
```

#### 2. Article/BlogPosting Schema (every article)
```json
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "Article Title",
  "author": {
    "@type": "Person",
    "name": "Author Name",
    "url": "https://yoursite.com/author/name"
  },
  "datePublished": "2025-01-15",
  "dateModified": "2025-01-20",
  "publisher": {
    "@type": "Organization",
    "name": "Your Company",
    "logo": "https://yoursite.com/logo.png"
  },
  "description": "Article meta description",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://yoursite.com/article-slug"
  }
}
```

#### 3. FAQPage Schema (highest GEO impact)
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What is GEO?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "GEO (Generative Engine Optimization) is the practice of optimizing web content to be cited and referenced by AI-powered answer engines like ChatGPT, Perplexity, and Claude. It focuses on making content discoverable and quotable by large language models that use retrieval-augmented generation (RAG)."
      }
    },
    {
      "@type": "Question",
      "name": "How is GEO different from SEO?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "SEO optimizes for search engine rankings (Google page 1). GEO optimizes for AI citation (being referenced in ChatGPT/Perplexity answers). They share 70%+ of fundamentals, but GEO adds emphasis on statistics, structured data, citation-ready formatting, and llms.txt."
      }
    }
  ]
}
```

#### 4. HowTo Schema (tutorial content)
```json
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "How to Set Up GEO",
  "description": "Step-by-step guide to optimizing your site for AI citation",
  "step": [
    {
      "@type": "HowToStep",
      "name": "Audit robots.txt",
      "text": "Ensure AI crawlers like GPTBot and ClaudeBot are not blocked.",
      "url": "https://yoursite.com/geo-guide#step-1"
    }
  ]
}
```

#### 5. Product Schema (e-commerce)
```json
{
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "Product Name",
  "description": "Product description",
  "brand": {
    "@type": "Brand",
    "name": "Brand Name"
  },
  "offers": {
    "@type": "Offer",
    "price": "29.99",
    "priceCurrency": "USD",
    "availability": "https://schema.org/InStock"
  },
  "review": {
    "@type": "Review",
    "reviewRating": {
      "@type": "Rating",
      "ratingValue": "4.8"
    }
  }
}
```

### Schema Implementation by Platform

**WordPress:**
- Use RankMath or Yoast SEO plugin (auto-generates Article, Organization, FAQ schemas)
- Custom schemas via RankMath's Schema Generator or manual `<script type="application/ld+json">` in theme

**React/Vite:**
- Use `react-helmet-async` for meta tags
- Inject `<script type="application/ld+json">` in component render
- For SSG (VitePress, Astro): build-time schema injection

**Next.js:**
- App Router: export `metadata` and `generateMetadata` from page components
- Use `next/script` for JSON-LD injection
- Example:
```tsx
// app/blog/[slug]/page.tsx
export async function generateMetadata({ params }) {
  return {
    title: post.title,
    description: post.excerpt,
    openGraph: { title: post.title, description: post.excerpt },
  }
}

export default function BlogPost({ params }) {
  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify({
          "@context": "https://schema.org",
          "@type": "BlogPosting",
          headline: post.title,
          // ... rest of schema
        })}}
      />
      <article>{post.content}</article>
    </>
  )
}
```

**Static (Hugo/Jekyll):**
- Hugo: Use ` hugo-gen-schema` or manual partial templates
- Jekyll: `{% include schema-article.html %}` in `_includes/`

## HTML Best Practices for AI Crawlers

### Semantic HTML
```html
<!-- DO: Use semantic elements -->
<article>
  <header>
    <h1>Article Title</h1>
    <time datetime="2025-01-15">January 15, 2025</time>
    <address>By <a rel="author" href="/author">Author Name</a></address>
  </header>
  <section>
    <h2>Key Finding</h2>
    <p>According to our research, 73% of...</p>
  </section>
</article>

<!-- DON'T: Use divs for everything -->
<div class="article">
  <div class="title">Article Title</div>
  <div class="content">...</div>
</div>
```

### Meta Tags (essential)
```html
<head>
  <!-- Primary -->
  <title>Primary Keyword — Secondary | Brand</title>
  <meta name="description" content="Concise description with primary keyword. Include a statistic or unique value proposition.">
  <meta name="robots" content="index, follow">
  <link rel="canonical" href="https://yoursite.com/page">

  <!-- Open Graph (social + AI crawling) -->
  <meta property="og:title" content="Article Title">
  <meta property="og:description" content="Article summary">
  <meta property="og:type" content="article">
  <meta property="og:url" content="https://yoursite.com/article">
  <meta property="og:image" content="https://yoursite.com/image.jpg">

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Article Title">
  <meta name="twitter:description" content="Article summary">

  <!-- Article-specific -->
  <meta property="article:published_time" content="2025-01-15T10:00:00Z">
  <meta property="article:modified_time" content="2025-01-20T15:30:00Z">
  <meta property="article:author" content="Author Name">
  <meta property="article:section" content="Technology">
</head>
```

## CDN and Firewall Considerations

### Cloudflare
- **Bot Fight Mode**: Can block AI crawlers. Add allowlist rules:
  - WAF → Custom Rules → Create rule:
    - If Known Bot = true AND Bot Score < 30 → Allow
  - Or create IP allowlists for known AI crawler IPs

### Vercel
- Default: AI crawlers allowed. If using Edge Middleware, ensure you're not blocking bot user agents.

### AWS CloudFront
- Check WAF rules if using AWS WAF — common rules block "suspicious" bots

### Nginx Rate Limiting
```nginx
# Don't rate-limit AI crawlers (they have short windows)
map $http_user_agent $is_ai_bot {
    default 0;
    "~*GPTBot" 0;
    "~*ClaudeBot" 0;
    "~*PerplexityBot" 0;
    "~*ChatGPT-User" 0;
}

# Only rate-limit non-AI traffic
limit_req_zone $binary_remote_addr zone=general:10m rate=10r/s;

server {
    location / {
        if ($is_ai_bot = 0) {
            limit_req zone=general burst=20 nodelay;
        }
    }
}
```

## Sitemap Optimization

### Essential for Both SEO and GEO
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://yoursite.com/</loc>
    <lastmod>2025-01-15</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://yoursite.com/blog/article-slug</loc>
    <lastmod>2025-01-10</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
</urlset>
```

### Reference in robots.txt
```
Sitemap: https://yoursite.com/sitemap.xml
```

### Reference in llms.txt
Add to llms.txt:
```
## Sitemap
- [Sitemap](/sitemap.xml): Full site structure and page listing
```
