# FAQ Section Template

Add this to every key page. FAQPage schema has the highest GEO impact.

---

## HTML + Schema Markup

```html
<section id="faq" itemscope itemtype="https://schema.org/FAQPage">
  <h2>Frequently Asked Questions</h2>
  
  <div itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
    <h3 itemprop="name">What is [Topic]?</h3>
    <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
      <p itemprop="text">[Topic] is [concise definition in 1-2 sentences]. 
      According to [source], [key statistic]. It differs from [related concept] 
      by [specific differentiator].</p>
    </div>
  </div>
  
  <div itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
    <h3 itemprop="name">How does [Topic] compare to [Related Topic]?</h3>
    <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
      <p itemprop="text">[Topic] focuses on [specific goal], while [Related Topic] 
      focuses on [different goal]. The key difference is [metric or outcome]. 
      [N]% of practitioners prefer [Topic] for [use case] because [reason with data].</p>
    </div>
  </div>
  
  <div itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
    <h3 itemprop="name">How long does it take to implement [Topic]?</h3>
    <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
      <p itemprop="text">Basic implementation takes [timeframe]. Full optimization 
      with all techniques takes [longer timeframe]. According to [source], 
      the average time to see results is [timeframe], with [N]% improvement 
      in the first [period].</p>
    </div>
  </div>
  
  <div itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
    <h3 itemprop="name">What are the main benefits of [Topic]?</h3>
    <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
      <p itemprop="text">The three primary benefits are: (1) [Benefit with metric], 
      (2) [Benefit with metric], and (3) [Benefit with metric]. 
      Studies show [N]% improvement in [outcome] when properly implemented.</p>
    </div>
  </div>
  
  <div itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
    <h3 itemprop="name">Do I need technical skills for [Topic]?</h3>
    <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
      <p itemprop="text">Basic [Topic] requires [skill level]. Advanced techniques 
      that achieve [N]% better results require [higher skill level]. 
      No-code tools like [Tool 1] and [Tool 2] can handle [specific tasks] 
      without coding.</p>
    </div>
  </div>
</section>
```

## Markdown + JSON-LD (for static generators)

```markdown
## Frequently Asked Questions

### What is [Topic]?
[Topic] is [concise definition]. According to [source], [key statistic]. 
It differs from [related concept] by [specific differentiator].

### How does [Topic] compare to [Related Topic]?
[Topic] focuses on [specific goal], while [Related Topic] focuses on 
[different goal]. [N]% of practitioners prefer [Topic] for [use case].

### How long does it take to implement [Topic]?
Basic implementation takes [timeframe]. Full optimization takes 
[longer timeframe]. Average time to see results is [timeframe].

### What are the main benefits?
1. [Benefit with metric]
2. [Benefit with metric]  
3. [Benefit with metric]

### Do I need technical skills?
Basic implementation requires [skill level]. No-code tools like 
[Tool 1] handle [tasks] without coding.
```

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What is [Topic]?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Topic] is [concise definition]. According to [source], [key statistic]."
      }
    },
    {
      "@type": "Question",
      "name": "How does [Topic] compare to [Related Topic]?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Topic] focuses on [goal], while [Related] focuses on [different goal]. [N]% prefer [Topic] for [use case]."
      }
    },
    {
      "@type": "Question",
      "name": "How long does implementation take?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Basic: [timeframe]. Full optimization: [longer]. Results visible in [timeframe]."
      }
    },
    {
      "@type": "Question",
      "name": "What are the main benefits?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "1) [Benefit with metric]. 2) [Benefit with metric]. 3) [Benefit with metric]."
      }
    }
  ]
}
```

## FAQ Writing Rules

1. **40-60 words per answer** — AI engines extract short, complete answers
2. **Include at least 1 statistic** per answer
3. **Use definitive language** — "X causes Y" not "X might cause Y"
4. **Reference sources** — "According to [source]..." builds authority
5. **Cover the question landscape:**
   - Definition (What is X?)
   - Comparison (X vs Y)
   - Implementation (How do I do X?)
   - Benefits (Why X?)
   - Barriers (Do I need X skill/cost?)
   - Timing (How long does X take?)
