---
name: project-terraform-baseline
description: Security posture snapshot of the terraform/ static-site stack (S3+CloudFront) as of 2026-07-09 audit
metadata:
  type: project
---

The `terraform/` stack (backend.tf, providers.tf, variables.tf, main.tf, outputs.tf) for the
pravinmishradmi portfolio site already gets the CloudFront/S3 basics right: S3
`aws_s3_bucket_public_access_block` fully blocks public access, CloudFront uses
`aws_cloudfront_origin_access_control` (OAC, not legacy OAI), and
`viewer_protocol_policy = "redirect-to-https"` is set. Bucket policy is scoped to the
CloudFront service principal with an `AWS:SourceArn` condition — no wildcard actions/resources.

Recurring gaps found in the 2026-07-09 audit (none of these existed in the stack):
- No `aws_s3_bucket_server_side_encryption_configuration` — encryption at rest not enabled.
- No `aws_cloudfront_response_headers_policy` attached to the default cache behavior — no CSP,
  X-Frame-Options, HSTS, etc.
- The GitHub Actions OIDC IAM role (`arn:aws:iam::533267262133:role/github-actions-deploy`,
  referenced in `.github/workflows/deploy.yml` and CLAUDE.md) is **not defined anywhere in
  terraform/** — its trust policy (repo/branch scoping) cannot be audited from this repo. Must
  check live AWS (IAM console/CLI) or bring it under Terraform to verify least-privilege +ref
  scoping.
- `backend.tf` still uses local state (S3 backend block is commented out, pending first bootstrap
  apply per its own comment) — no encryption/locking/versioning on state until migrated.
- No S3 bucket versioning, no CloudFront/S3 access logging, no explicit
  `aws_s3_bucket_ownership_controls` (BucketOwnerEnforced).

**Why**: this is the baseline to diff against on future audits — only report *new* deviations,
and don't re-flag the good OAC/public-access-block/HTTPS-redirect setup as if it were a finding.

**How to apply**: on subsequent audits of this repo, read the current terraform/ files fresh
(don't trust this snapshot blindly — verify each item still holds), then compare against this
list. If the encryption/response-headers/OIDC/backend gaps are fixed, update this memory. If new
resources are added (e.g. a domain_name gets set), check for `minimum_protocol_version =
"TLSv1.2_2021"` on the ACM-based `viewer_certificate` block instead of the current
`cloudfront_default_certificate = true` path.
