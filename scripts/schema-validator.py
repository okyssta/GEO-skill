#!/usr/bin/env python3
"""
Schema.org Structured Data Validator
Validates JSON-LD schema on a given URL.
Usage: python3 schema-validator.py https://yoursite.com
"""

import json
import sys
import re
from urllib.request import urlopen, Request
from urllib.error import URLError

def extract_jsonld(html):
    """Extract all JSON-LD blocks from HTML."""
    pattern = r'<script[^>]*type=["\']application/ld\+json["\'][^>]*>(.*?)</script>'
    matches = re.findall(pattern, html, re.DOTALL | re.IGNORECASE)
    schemas = []
    for match in matches:
        try:
            schemas.append(json.loads(match.strip()))
        except json.JSONDecodeError as e:
            schemas.append({"_error": str(e), "_raw": match[:200]})
    return schemas

def validate_schema(schema, index=0):
    """Validate a single JSON-LD schema."""
    issues = []
    warnings = []
    
    if "_error" in schema:
        issues.append(f"  INVALID JSON: {schema['_error']}")
        return issues, warnings
    
    # Check @context
    if "@context" not in schema:
        issues.append("Missing @context")
    elif schema["@context"] != "https://schema.org":
        warnings.append(f"Unusual @context: {schema['@context']}")
    
    # Check @type
    if "@type" not in schema:
        issues.append("Missing @type")
    else:
        schema_type = schema["@type"]
        valid_types = [
            "Organization", "Person", "BlogPosting", "Article",
            "WebPage", "WebSite", "FAQPage", "HowTo", "Product",
            "LocalBusiness", "BreadcrumbList", "ItemList",
            "VideoObject", "Event", "Course", "JobPosting"
        ]
        if schema_type not in valid_types:
            warnings.append(f"Uncommon @type: {schema_type}")
    
    # Type-specific validation
    schema_type = schema.get("@type", "")
    
    if schema_type == "Organization":
        if "name" not in schema:
            issues.append("Organization: missing 'name'")
        if "url" not in schema:
            warnings.append("Organization: missing 'url'")
        if "logo" not in schema:
            warnings.append("Organization: missing 'logo'")
    
    elif schema_type in ("BlogPosting", "Article"):
        required = ["headline", "author", "datePublished"]
        for field in required:
            if field not in schema:
                issues.append(f"{schema_type}: missing '{field}'")
        
        if "author" in schema:
            author = schema["author"]
            if isinstance(author, dict) and "@type" not in author:
                warnings.append("Author: missing @type (should be Person)")
            elif isinstance(author, list):
                for a in author:
                    if isinstance(a, dict) and "name" not in a:
                        warnings.append("Author entry: missing 'name'")
        
        if "publisher" not in schema:
            warnings.append(f"{schema_type}: missing 'publisher'")
        if "description" not in schema:
            warnings.append(f"{schema_type}: missing 'description'")
    
    elif schema_type == "FAQPage":
        if "mainEntity" not in schema:
            issues.append("FAQPage: missing 'mainEntity'")
        else:
            entities = schema["mainEntity"]
            if not isinstance(entities, list):
                issues.append("FAQPage: 'mainEntity' should be an array")
            elif len(entities) == 0:
                warnings.append("FAQPage: 'mainEntity' is empty")
            else:
                for i, entity in enumerate(entities):
                    if entity.get("@type") != "Question":
                        warnings.append(f"FAQPage entity {i}: @type should be 'Question'")
                    if "name" not in entity:
                        issues.append(f"FAQPage entity {i}: missing 'name'")
                    if "acceptedAnswer" not in entity:
                        issues.append(f"FAQPage entity {i}: missing 'acceptedAnswer'")
    
    elif schema_type == "Product":
        if "name" not in schema:
            issues.append("Product: missing 'name'")
        if "offers" not in schema:
            warnings.append("Product: missing 'offers'")
        elif isinstance(schema.get("offers"), dict):
            if "price" not in schema["offers"]:
                warnings.append("Product offers: missing 'price'")
    
    return issues, warnings

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 schema-validator.py https://yoursite.com")
        sys.exit(1)
    
    url = sys.argv[1].rstrip("/")
    
    print(f"Validating: {url}")
    print("=" * 50)
    
    try:
        req = Request(url, headers={"User-Agent": "SchemaValidator/1.0"})
        with urlopen(req, timeout=10) as resp:
            html = resp.read().decode("utf-8", errors="replace")
    except URLError as e:
        print(f"ERROR: Could not fetch URL: {e}")
        sys.exit(1)
    
    schemas = extract_jsonld(html)
    
    if not schemas:
        print("\n  NO JSON-LD SCHEMA FOUND")
        print("  Add structured data to improve GEO+SEO.")
        print("  See references/technical-setup.md for templates.")
        sys.exit(1)
    
    print(f"\nFound {len(schemas)} JSON-LD schema(s)\n")
    
    total_issues = 0
    total_warnings = 0
    
    for i, schema in enumerate(schemas):
        schema_type = schema.get("@type", "Unknown") if "_error" not in schema else "INVALID"
        print(f"Schema {i+1}: {schema_type}")
        print("-" * 40)
        
        issues, warnings = validate_schema(schema, i)
        total_issues += len(issues)
        total_warnings += len(warnings)
        
        if issues:
            print("  ISSUES (must fix):")
            for issue in issues:
                print(f"    ✗ {issue}")
        
        if warnings:
            print("  WARNINGS (should fix):")
            for warning in warnings:
                print(f"    ⚠ {warning}")
        
        if not issues and not warnings:
            print("  ✓ Schema looks valid")
        
        print()
    
    print("=" * 50)
    print(f"SUMMARY: {total_issues} issues, {total_warnings} warnings")
    
    if total_issues > 0:
        print("\nFix issues to improve AI citation and search ranking.")
    elif total_warnings > 0:
        print("\nAddress warnings for better visibility.")
    else:
        print("\nAll schemas pass validation!")

if __name__ == "__main__":
    main()
