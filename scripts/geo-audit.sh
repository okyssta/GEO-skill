#!/bin/bash
# GEO+SEO Site Audit Script
# Usage: bash geo-audit.sh https://yoursite.com

set -euo pipefail

SITE_URL="${1:-}"
if [ -z "$SITE_URL" ]; then
  echo "Usage: bash geo-audit.sh https://yoursite.com"
  exit 1
fi

# Remove trailing slash
SITE_URL="${SITE_URL%/}"
DOMAIN=$(echo "$SITE_URL" | sed -E 's|https?://||')

echo "========================================"
echo "GEO+SEO AUDIT: $DOMAIN"
echo "========================================"
echo ""

ISSUES=0
WARNINGS=0
GOOD=0

check() {
  local status="$1"
  local msg="$2"
  case "$status" in
    OK)   echo "  [OK]   $msg"; ((GOOD++)) ;;
    WARN) echo "  [WARN] $msg"; ((WARNINGS++)) ;;
    FAIL) echo "  [FAIL] $msg"; ((ISSUES++)) ;;
  esac
}

# --- 1. Check robots.txt ---
echo "1. ROBOTS.TXT"
echo "------------"
ROBOTS=$(curl -sL -o /dev/null -w "%{http_code}" "$SITE_URL/robots.txt" 2>/dev/null || echo "000")
if [ "$ROBOTS" = "200" ]; then
  ROBOTS_CONTENT=$(curl -sL "$SITE_URL/robots.txt" 2>/dev/null)
  
  for BOT in "GPTBot" "ClaudeBot" "PerplexityBot" "ChatGPT-User" "Bytespider" "CCBot" "Google-Extended"; do
    if echo "$ROBOTS_CONTENT" | grep -qi "Disallow.*\*$" | head -1 > /dev/null 2>&1; then
      check FAIL "AI bot $BOT may be blocked (Disallow: * found)"
    elif echo "$ROBOTS_CONTENT" | grep -qi "User-agent: $BOT" > /dev/null 2>&1; then
      if echo "$ROBOTS_CONTENT" | grep -A5 -i "User-agent: $BOT" | grep -qi "Disallow" > /dev/null 2>&1; then
        check WARN "AI bot $BOT has specific rules — verify they allow crawling"
      else
        check OK "AI bot $BOT has explicit rules (verify they allow)"
      fi
    else
      check OK "AI bot $BOT — default rules apply (should be allowed)"
    fi
  done
  
  if echo "$ROBOTS_CONTENT" | grep -qi "Sitemap:"; then
    check OK "Sitemap referenced in robots.txt"
  else
    check WARN "No Sitemap reference in robots.txt"
  fi
else
  check WARN "robots.txt returned HTTP $ROBOTS"
fi
echo ""

# --- 2. Check llms.txt ---
echo "2. LLMS.TXT"
echo "-----------"
LLMS=$(curl -sL -o /dev/null -w "%{http_code}" "$SITE_URL/llms.txt" 2>/dev/null || echo "000")
if [ "$LLMS" = "200" ]; then
  LLMS_SIZE=$(curl -sL "$SITE_URL/llms.txt" 2>/dev/null | wc -c)
  check OK "llms.txt exists (${LLMS_SIZE} bytes)"
  if [ "$LLMS_SIZE" -lt 100 ]; then
    check WARN "llms.txt is very small — add more site description"
  fi
else
  check FAIL "llms.txt not found (HTTP $LLMS)"
fi

LLMS_FULL=$(curl -sL -o /dev/null -w "%{http_code}" "$SITE_URL/llms-full.txt" 2>/dev/null || echo "000")
if [ "$LLMS_FULL" = "200" ]; then
  check OK "llms-full.txt exists"
else
  check WARN "llms-full.txt not found (optional but recommended)"
fi
echo ""

# --- 3. Check main page ---
echo "3. MAIN PAGE"
echo "------------"
MAIN_PAGE=$(curl -sL "$SITE_URL/" 2>/dev/null)

# Title tag
if echo "$MAIN_PAGE" | grep -q "<title>"; then
  TITLE=$(echo "$MAIN_PAGE" | grep -oP '(?<=<title>)[^<]+' | head -1)
  TITLE_LEN=${#TITLE}
  if [ "$TITLE_LEN" -gt 30 ] && [ "$TITLE_LEN" -lt 65 ]; then
    check OK "Title tag: good length ($TITLE_LEN chars)"
  elif [ "$TITLE_LEN" -le 30 ]; then
    check WARN "Title tag too short ($TITLE_LEN chars) — aim for 30-60"
  else
    check WARN "Title tag too long ($TITLE_LEN chars) — aim for 30-60"
  fi
else
  check FAIL "No <title> tag found"
fi

# Meta description
if echo "$MAIN_PAGE" | grep -q 'meta name="description"'; then
  DESC_LEN=$(echo "$MAIN_PAGE" | grep -oP '(?<=meta name="description" content=")[^"]+' | head -1 | wc -c)
  check OK "Meta description found ($DESC_LEN chars)"
else
  check FAIL "No meta description found"
fi

# Canonical
if echo "$MAIN_PAGE" | grep -q 'rel="canonical"'; then
  check OK "Canonical URL set"
else
  check WARN "No canonical URL found"
fi

# Open Graph
if echo "$MAIN_PAGE" | grep -q 'og:title'; then
  check OK "Open Graph tags found"
else
  check WARN "No Open Graph tags — needed for social + AI crawling"
fi
echo ""

# --- 4. Check structured data ---
echo "4. STRUCTURED DATA"
echo "------------------"
SCHEMA_COUNT=$(echo "$MAIN_PAGE" | grep -c 'application/ld+json' || true)
if [ "$SCHEMA_COUNT" -gt 0 ]; then
  check OK "Found $SCHEMA_COUNT JSON-LD schema block(s)"
  
  # Check for specific schemas
  if echo "$MAIN_PAGE" | grep -q '"@type": "Organization"'; then
    check OK "Organization schema found"
  else
    check WARN "No Organization schema"
  fi
  
  if echo "$MAIN_PAGE" | grep -q '"@type": "FAQPage"'; then
    check OK "FAQPage schema found"
  else
    check WARN "No FAQPage schema (high GEO impact)"
  fi
else
  check FAIL "No structured data (JSON-LD) found"
fi
echo ""

# --- 5. Check sitemap ---
echo "5. SITEMAP"
echo "----------"
SITEMAP=$(curl -sL -o /dev/null -w "%{http_code}" "$SITE_URL/sitemap.xml" 2>/dev/null || echo "000")
if [ "$SITEMAP" = "200" ]; then
  SITEMAP_SIZE=$(curl -sL "$SITE_URL/sitemap.xml" 2>/dev/null | wc -c)
  check OK "sitemap.xml exists ($SITEMAP_SIZE bytes)"
else
  check WARN "sitemap.xml not found (HTTP $SITEMAP)"
fi
echo ""

# --- 6. Page speed (basic) ---
echo "6. PAGE SPEED (basic)"
echo "---------------------"
LOAD_TIME=$(curl -sL -o /dev/null -w "%{time_total}" "$SITE_URL/" 2>/dev/null)
LOAD_MS=$(echo "$LOAD_TIME * 1000" | bc 2>/dev/null || echo "unknown")
if [ "$LOAD_MS" != "unknown" ]; then
  if (( $(echo "$LOAD_TIME < 2" | bc -l 2>/dev/null || echo 0) )); then
    check OK "Page load time: ${LOAD_MS}ms (fast)"
  elif (( $(echo "$LOAD_TIME < 4" | bc -l 2>/dev/null || echo 0) )); then
    check WARN "Page load time: ${LOAD_MS}ms (acceptable, aim for <2s)"
  else
    check FAIL "Page load time: ${LOAD_MS}ms (too slow for AI crawlers)"
  fi
else
  check WARN "Could not measure page load time"
fi
echo ""

# --- 7. Semantic HTML check ---
echo "7. SEMANTIC HTML"
echo "----------------"
SEMANTIC_ELEMENTS=0
for TAG in "article" "section" "header" "footer" "nav" "main" "aside" "time"; do
  if echo "$MAIN_PAGE" | grep -q "<$TAG"; then
    ((SEMANTIC_ELEMENTS++))
  fi
done

if [ "$SEMANTIC_ELEMENTS" -ge 4 ]; then
  check OK "Good semantic HTML usage ($SEMANTICElements elements found)"
elif [ "$SEMANTIC_ELEMENTS" -ge 2 ]; then
  check WARN "Some semantic HTML ($SEMANTIC_ELEMENTS elements) — add more <article>, <section>, <time>"
else
  check FAIL "Minimal semantic HTML — AI crawlers struggle with div-only layouts"
fi

# Check for h1
H1_COUNT=$(echo "$MAIN_PAGE" | grep -c "<h1" || true)
if [ "$H1_COUNT" -eq 1 ]; then
  check OK "Single H1 tag (good)"
elif [ "$H1_COUNT" -gt 1 ]; then
  check WARN "Multiple H1 tags ($H1_COUNT) — use only one per page"
else
  check FAIL "No H1 tag found"
fi
echo ""

# --- Summary ---
echo "========================================"
echo "AUDIT SUMMARY"
echo "========================================"
echo "  PASSED:   $GOOD"
echo "  WARNINGS: $WARNINGS"
echo "  ISSUES:   $ISSUES"
echo ""

if [ "$ISSUES" -gt 0 ]; then
  echo "  >> $ISSUES critical issues need fixing"
elif [ "$WARNINGS" -gt 0 ]; then
  echo "  >> $WARNINGS warnings to address"
else
  echo "  >> Site looks good for GEO+SEO!"
fi
echo ""
