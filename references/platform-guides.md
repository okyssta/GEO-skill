# Platform-Specific Guides

Stack-specific implementation for GEO+SEO optimization.

---

## WordPress

### Plugin Stack (Recommended)

| Plugin | Purpose | GEO Impact |
|---|---|---|
| **RankMath SEO** | Meta tags, sitemap, schema | High — auto-generates Article, Organization, FAQ schemas |
| **WP Super Cache / W3 Total Cache** | Speed optimization | Medium — faster load = better crawler access |
| **Schema Pro** | Advanced structured data | High — custom schema beyond what RankMath offers |
| **ShortPixel / Imagify** | Image optimization | Low — faster pages, better OG images |

### RankMath Schema Configuration

1. Install RankMath → Run Setup Wizard → Enable "Article" schema as default
2. For each post/page: Schema tab → Add FAQ schema if applicable
3. For product pages: Use "Product" schema type
4. For local business: Add "LocalBusiness" schema

### Custom Schema (beyond RankMath)

Add to `functions.php` or a custom plugin:

```php
// Add Organization schema to all pages
add_action('wp_head', function() {
    if (is_front_page()) {
        $schema = [
            '@context' => 'https://schema.org',
            '@type' => 'Organization',
            'name' => get_bloginfo('name'),
            'url' => home_url('/'),
            'logo' => wp_get_attachment_url(get_theme_mod('custom_logo')),
            'sameAs' => [
                'https://twitter.com/yourcompany',
                'https://linkedin.com/company/yourcompany',
            ],
        ];
        echo '<script type="application/ld+json">' . json_encode($schema) . '</script>';
    }
});
```

### llms.txt for WordPress

**Option 1: Plugin**
- Install "LLMs.txt" plugin from WordPress repository
- Configure in Settings → llms.txt

**Option 2: Manual (Recommended)**
- Create `/llms.txt` in web root
- Add a redirect in `.htaccess`:
```apache
RewriteRule ^llms\.txt$ /wp-content/uploads/llms.txt [L]
```

**Option 3: Theme integration**
Add to `functions.php`:
```php
add_action('init', function() {
    // Serve llms.txt from uploads directory
    if ($_SERVER['REQUEST_URI'] === '/llms.txt') {
        header('Content-Type: text/plain');
        read_file(ABSPATH . 'wp-content/uploads/llms.txt');
        exit;
    }
});
```

### WordPress-Specific GEO Tips

1. **Categories as entity signals** — Use specific category names, not generic ones
2. **Internal linking** — Link related posts with descriptive anchor text (not "click here")
3. **Image alt text** — Descriptive, keyword-rich alt text (AI reads images via alt text)
4. **Excerpt optimization** — Write unique, data-rich excerpts for each post
5. **Comment quality** — Moderate for substantive comments (E-E-A-T signal)

---

## React / Vite (SPA)

### Critical Challenge

SPAs render content client-side. AI crawlers may not execute JavaScript. **Server-side rendering (SSR) or static generation is essential.**

### Option 1: Vite SSR (Recommended for new projects)

```bash
npm create vite@latest my-app -- --template react
npm install vite-plugin-ssr  # or vite-plugin-mpa
```

### Option 2: Static Site Generation

Use VitePress or Astro for content-heavy sites:

```bash
# VitePress (Vue-based, excellent for docs)
npm install -D vitepress

# Astro (React-compatible SSG)
npm create astro@latest my-site
```

### Meta Tag Injection (SPA)

Use `react-helmet-async`:

```jsx
import { Helmet } from 'react-helmet-async';

function ArticlePage({ article }) {
  return (
    <>
      <Helmet>
        <title>{article.title} | Your Site</title>
        <meta name="description" content={article.excerpt} />
        <link rel="canonical" href={`https://yoursite.com/${article.slug}`} />
        
        {/* Open Graph */}
        <meta property="og:title" content={article.title} />
        <meta property="og:description" content={article.excerpt} />
        <meta property="og:type" content="article" />
        <meta property="og:image" content={article.image} />
        
        {/* Article */}
        <meta property="article:published_time" content={article.date} />
        <meta property="article:author" content={article.author} />
        
        {/* JSON-LD Schema */}
        <script type="application/ld+json">
          {JSON.stringify({
            "@context": "https://schema.org",
            "@type": "BlogPosting",
            headline: article.title,
            author: { "@type": "Person", name: article.author },
            datePublished: article.date,
            description: article.excerpt,
          })}
        </script>
      </Helmet>
      
      <article>
        <h1>{article.title}</h1>
        <p>{article.content}</p>
      </article>
    </>
  );
}
```

### Vite-Specific: Static Public Files

Place these in `public/`:
```
public/
├── llms.txt
├── llms-full.txt
├── robots.txt
├── sitemap.xml
└── favicon.ico
```

### SPA → SSG Migration Checklist

If you have an existing React/Vite SPA:

1. [ ] Identify all routes (use react-router config)
2. [ ] Set up Vite SSG or migrate to Astro
3. [ ] Pre-render all routes at build time
4. [ ] Add meta tags to every route
5. [ ] Add schema.org JSON-LD to key pages
6. [ ] Create llms.txt with site map
7. [ ] Update robots.txt
8. [ ] Test with `curl` or `web_fetch` to verify static HTML output

---

## Next.js

### App Router (Recommended)

Next.js App Router has built-in metadata API — the best GEO setup out of the box.

### Metadata API

```tsx
// app/blog/[slug]/page.tsx
import type { Metadata } from 'next';

export async function generateMetadata({ params }): Promise<Metadata> {
  const post = await getPost(params.slug);
  
  return {
    title: `${post.title} | Your Site`,
    description: post.excerpt,
    openGraph: {
      title: post.title,
      description: post.excerpt,
      type: 'article',
      publishedTime: post.date,
      authors: [post.author],
      images: [{ url: post.image, width: 1200, height: 630 }],
    },
    twitter: {
      card: 'summary_large_image',
      title: post.title,
      description: post.excerpt,
    },
    alternates: {
      canonical: `https://yoursite.com/blog/${post.slug}`,
    },
  };
}
```

### JSON-LD in App Router

```tsx
// components/ArticleSchema.tsx
export function ArticleSchema({ post }) {
  const schema = {
    "@context": "https://schema.org",
    "@type": "BlogPosting",
    headline: post.title,
    author: {
      "@type": "Person",
      name: post.author,
      url: `https://yoursite.com/author/${post.authorSlug}`,
    },
    datePublished: post.date,
    dateModified: post.modifiedDate || post.date,
    publisher: {
      "@type": "Organization",
      name: "Your Company",
      logo: "https://yoursite.com/logo.png",
    },
    description: post.excerpt,
    mainEntityOfPage: `https://yoursite.com/blog/${post.slug}`,
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }}
    />
  );
}

// Usage in page:
export default async function BlogPost({ params }) {
  const post = await getPost(params.slug);
  return (
    <>
      <ArticleSchema post={post} />
      <article>
        <h1>{post.title}</h1>
        {/* ... */}
      </article>
    </>
  );
}
```

### ISR (Incremental Static Regeneration) for Freshness

```tsx
// app/blog/[slug]/page.tsx
export const revalidate = 86400; // Revalidate every 24 hours
```

### llms.txt for Next.js

Place in `public/llms.txt` — automatically served at `/llms.txt`.

### Sitemap Generation

```tsx
// app/sitemap.ts
import { MetadataRoute } from 'next';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const posts = await getAllPosts();
  
  return posts.map(post => ({
    url: `https://yoursite.com/blog/${post.slug}`,
    lastModified: post.modifiedDate || post.date,
    changeFrequency: 'monthly',
    priority: 0.8,
  }));
}
```

---

## Static Sites (Hugo / Jekyll / 11ty)

### Hugo

**Schema partial** (`layouts/partials/schema.html`):
```html
{{ if .IsPage }}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "{{ .Title }}",
  "datePublished": "{{ .Date.Format "2006-01-02" }}",
  "dateModified": "{{ .Lastmod.Format "2006-01-02" }}",
  "author": {
    "@type": "Person",
    "name": "{{ .Params.author | default .Site.Author.name }}"
  },
  "description": "{{ .Summary | plainify | truncate 160 }}"
}
</script>
{{ end }}
```

**llms.txt**: Place in `static/llms.txt`

**Sitemap**: Hugo auto-generates `sitemap.xml`

### Jekyll

**Schema include** (`_includes/schema-article.html`):
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "{{ page.title }}",
  "datePublished": "{{ page.date | date_to_xmlschema }}",
  "dateModified": "{{ page.last_modified_at | default: page.date | date_to_xmlschema }}",
  "author": {
    "@type": "Person",
    "name": "{{ page.author | default: site.author }}"
  }
}
</script>
```

**llms.txt**: Place in root or `_site/llms.txt`

---

## Generic / Custom Stack

### Minimum Viable GEO Setup

For any web stack, implement these in order:

1. **robots.txt** — Allow all AI crawlers
2. **llms.txt** — Site summary for LLMs
3. **Meta tags** — Title, description, OG tags on every page
4. **Schema.org** — At minimum: Organization + Article schemas
5. **Semantic HTML** — Use `<article>`, `<section>`, `<h1>`-`<h6>`, `<time>`, `<address>`
6. **Sitemap** — XML sitemap referenced in robots.txt
7. **Canonical URLs** — Every page has a self-referencing canonical
8. **Fast load times** — Under 3 seconds (AI crawlers timeout)
9. **Mobile responsive** — AI crawlers test mobile rendering
10. **Clean URL structure** — `/blog/article-slug` not `/blog/12345`

### Server Configuration (Nginx)

```nginx
server {
    listen 443 ssl http2;
    server_name yoursite.com;

    # Core pages
    root /var/www/yoursite/public;
    index index.html;

    # Serve llms.txt
    location = /llms.txt {
        alias /var/www/yoursite/llms.txt;
        add_header Content-Type text/plain;
    }

    # Serve llms-full.txt
    location = /llms-full.txt {
        alias /var/www/yoursite/llms-full.txt;
        add_header Content-Type text/plain;
    }

    # SEO-friendly URLs
    location /blog/ {
        try_files $uri $uri/ /blog/index.html;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Security headers (don't block AI bots)
    add_header X-Content-Type-Options "nosniff";
    add_header X-Frame-Options "SAMEORIGIN";
    # Don't add X-Robots-Tag: noindex unless intentionally hiding
}
```

### Server Configuration (Apache)

```apache
# .htaccess
RewriteEngine On

# SEO-friendly URLs
RewriteRule ^blog/([a-zA-Z0-9-]+)/?$ /blog/$1 [L,QSA]

# Serve llms.txt
Redirect /llms.txt /llms-full.txt

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css application/javascript
</IfModule>

# Cache static assets
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpeg "access plus 1 month"
    ExpiresByType image/png "access plus 1 month"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>
```
