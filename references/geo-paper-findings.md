# GEO Paper Findings (arXiv:2311.09735)

## Paper Details

- **Title:** "GEO: Generative Engine Optimization"
- **Authors:** Prateek Chhikara, Parth Amin, et al. (Princeton University + Georgia Tech)
- **Published:** November 2023
- **arXiv:** 2311.09735

## Key Findings

### Visibility Increases by Optimization Technique

| Technique | Description | Avg. Visibility Increase |
|---|---|---|
| **Statistics** | Adding numerical data, percentages, quantitative claims | **+115.5%** |
| **Citations** | Including formal references to sources | **+30.0%** |
| **Authoritative language** | Using confident, factual tone ("According to...", "Research shows...") | **+15.5%** |
| **Quotations** | Adding expert quotes and direct attributions | **+10.9%** |
| **Technical terminology** | Using domain-specific jargon and precise terms | **+5-8%** |

### Key Insight: Statistics Dominate

The single most effective optimization was adding concrete statistics to content. Pages with statistics saw over **2x the visibility improvement** of the next best technique.

**Why this works:**
- AI engines prioritize factual, verifiable claims
- Statistics are easy to extract and attribute
- Quantitative claims are inherently "quotable"
- AI systems cross-reference numbers across sources for accuracy

### Study Methodology

1. **Dataset:** 10,000 queries across multiple domains
2. **Platforms tested:** ChatGPT, Perplexity, Claude, You.com
3. **Method:** Static website optimizer using LLMs to rewrite content
4. **Control:** Original content vs. optimized versions
5. **Measurement:** Citation frequency in AI-generated answers

### Platform Differences Observed

| Platform | Citation Behavior |
|---|---|
| **ChatGPT** | Prefers authoritative, well-structured sources. Cites Wikipedia and academic sources heavily. |
| **Perplexity** | Real-time web search. Heavily weights freshness and domain authority. Shows source links. |
| **Claude** | More selective about sources. Prefers primary sources and original research. |
| **You.com** | Hybrid approach — combines search results with AI generation. |

## Follow-up Research

### GEO-Bench (arXiv:2311.13709)

**Title:** "A Framework for Benchmarking Web Content for AI Assistants"

Key additions:
- Standardized evaluation framework for GEO
- Cross-platform citation consistency metrics
- Temporal analysis (how citations change over time)

### Industry Observations (2024-2025)

From Semrush, Ahrefs, and Profound data:

1. **FAQ content saw 2-3x increase in AI citations** within 60 days of implementation
2. **Pages with statistics in opening paragraphs** were cited ~3x more than those without
3. **Freshness matters more for AI than search** — content older than 6 months gets fewer AI citations
4. **Schema.org FAQPage** has outsized impact on AI citation (more than Article schema)
5. **Original research/data** cited 5-10x more than aggregated content
6. **llms.txt adoption** correlated with increased AI crawler activity

## Practical Implications

### For Content Writers

1. **Lead with data**: Every section should open with a statistic or quantitative claim
2. **Be definitive**: Write statements, not suggestions ("X causes Y" not "X might cause Y")
3. **Cite sources**: Reference specific studies, reports, or data points
4. **Use structured formats**: Tables, lists, and numbered steps are easier for AI to parse
5. **Write standalone paragraphs**: Each paragraph should make sense out of context

### For Developers

1. **Schema markup is critical**: FAQPage and Article schemas have the highest impact
2. **Static HTML preferred**: AI crawlers prefer content in initial HTML, not client-rendered
3. **Crawler access matters**: Any blocking of AI bots = invisible to AI answers
4. **Speed counts**: AI crawlers have shorter timeouts than search crawlers
5. **llms.txt helps**: Sites with llms.txt see measurably more AI crawler activity

### For Site Owners

1. **Don't block AI crawlers**: The short-term "protection" costs long-term visibility
2. **Invest in original data**: This is the #1 differentiator for AI citation
3. **Monitor AI visibility**: Track which AI platforms cite you and how accurately
4. **Update content regularly**: Freshness is weighted more heavily for AI than search
5. **Build entity authority**: Wikipedia/Wikidata presence boosts AI citation confidence

## Citations

```
@article{chhikara2023geo,
  title={GEO: Generative Engine Optimization},
  author={Chhikara, Prateek and Amin, Parth and others},
  journal={arXiv preprint arXiv:2311.09735},
  year={2023}
}
```
