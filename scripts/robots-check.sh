#!/bin/bash
# Check AI crawler access to your site
# Usage: bash robots-check.sh https://yoursite.com

set -euo pipefail

SITE_URL="${1:-}"
if [ -z "$SITE_URL" ]; then
  echo "Usage: bash robots-check.sh https://yoursite.com"
  exit 1
fi

SITE_URL="${SITE_URL%/}"
DOMAIN=$(echo "$SITE_URL" | sed -E 's|https?://||')

echo "========================================"
echo "AI CRAWLER ACCESS CHECK: $DOMAIN"
echo "========================================"
echo ""

# AI Bot user agents
BOTS=(
  "GPTBot"
  "ChatGPT-User"
  "ClaudeBot"
  "PerplexityBot"
  "Bytespider"
  "CCBot"
  "Google-Extended"
  "Amazonbot"
)

# Fetch robots.txt
ROBOTS=$(curl -sL "$SITE_URL/robots.txt" 2>/dev/null || echo "")

if [ -z "$ROBOTS" ]; then
  echo "WARNING: Could not fetch robots.txt"
  echo "AI crawlers will use default rules (allow all)."
  echo ""
  exit 0
fi

echo "ROBOTS.TXT Content:"
echo "---"
echo "$ROBOTS" | head -30
echo "---"
echo ""

echo "AI CRAWLER STATUS:"
echo "========================================"

for BOT in "${BOTS[@]}"; do
  # Check if bot has specific rules
  if echo "$ROBOTS" | grep -qi "User-agent:.*$BOT"; then
    # Extract rules for this bot
    RULES=$(echo "$ROBOTS" | grep -A10 -i "User-agent:.*$BOT" | grep -iE "Allow:|Disallow:" | head -3)
    BLOCKED=$(echo "$RULES" | grep -ci "Disallow:.*\*" || true)
    
    if [ "$BLOCKED" -gt 0 ]; then
      echo "  BLOCKED  $BOT"
    else
      echo "  ALLOWED  $BOT (has specific rules)"
      echo "           Rules: $(echo $RULES | tr '\n' '; ')"
    fi
  else
    echo "  ALLOWED  $BOT (default rules)"
  fi
done

echo ""
echo "========================================"

# Also check if main page returns different status for bot user agents
echo ""
echo "SIMULATING BOT REQUESTS:"
echo "========================================"

for BOT in "GPTBot" "ClaudeBot" "PerplexityBot"; do
  STATUS=$(curl -sL -o /dev/null -w "%{http_code}" \
    -H "User-Agent: $BOT/1.0" \
    "$SITE_URL/" 2>/dev/null || echo "000")
  
  if [ "$STATUS" = "200" ]; then
    echo "  $BOT → HTTP $STATUS (OK)"
  elif [ "$STATUS" = "403" ]; then
    echo "  $BOT → HTTP $STATUS (BLOCKED!)"
  elif [ "$STATUS" = "503" ]; then
    echo "  $BOT → HTTP $STATUS (SERVICE UNAVAILABLE)"
  else
    echo "  $BOT → HTTP $STATUS"
  fi
done

echo ""
echo "========================================"
echo "RECOMMENDATIONS:"
echo ""

# Check for common issues
if echo "$ROBOTS" | grep -qi "Disallow:.*\*"; then
  echo "  !! Global 'Disallow: *' found — ALL crawlers blocked"
  echo "     Remove or restrict this rule"
fi

if echo "$ROBOTS" | grep -qi "User-agent: \*"; then
  GLOBAL_RULE=$(echo "$ROBOTS" | grep -A5 "User-agent: \*" | grep -i "Disallow" | head -1)
  if echo "$GLOBAL_RULE" | grep -qi "Disallow: /"; then
    echo "  !! Default rule blocks all — AI crawlers affected"
  fi
fi

if ! echo "$ROBOTS" | grep -qi "Sitemap:"; then
  echo "  >> Add 'Sitemap: https://$DOMAIN/sitemap.xml' to robots.txt"
fi

echo "  >> Ensure no WAF/CDN rules block AI bot user agents"
echo "  >> Check Cloudflare Bot Fight Mode if applicable"
