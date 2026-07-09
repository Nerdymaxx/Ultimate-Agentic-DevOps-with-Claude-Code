---
name: portfolio-cost-baseline
description: Cost baseline for pravinmishradmi-site portfolio: S3 + CloudFront with PriceClass_200 pricing
metadata:
  type: project
---

**Project**: Static portfolio site (HTML/CSS only, ~1145 lines CSS, multiple small images)

**Current Infrastructure** (eu-north-1):
- S3 bucket: Standard storage class, no lifecycle rules, no versioning
- CloudFront: PriceClass_200 (includes North America, Europe, Asia, Middle East, Africa, South America)
- Default CloudFront cache policy (CachingOptimized managed policy)
- No custom domain (using default CloudFront domain)

**Traffic Profile**:
- Low-to-moderate traffic (personal portfolio)
- Infrequent content changes (deployed via GitHub Actions on push to main)
- Content is 100% public (no authentication required)

**Access Pattern**:
- Visitor geographic spread unknown, but portfolio for a personal brand likely heavily concentrated in N.America/Europe
- Cacheable content (HTML, CSS, images) — 100% of requests should cache well
