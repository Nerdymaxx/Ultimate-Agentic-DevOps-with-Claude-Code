---
name: reference-deploy-pipeline
description: Where live deployment identifiers (bucket, distribution, OIDC role, region) are documented for this repo
metadata:
  type: reference
---

CLAUDE.md (repo root) documents the concrete AWS identifiers this project deploys to:
- S3 bucket: `pravinmishradmi-site-production`
- CloudFront distribution ID: `E3V6O6MRE2E21P`
- GitHub OIDC deploy role: `arn:aws:iam::533267262133:role/github-actions-deploy`
- Region: `eu-north-1`

These are legitimately in CLAUDE.md (project docs), not secrets — do not flag them as
"hardcoded credentials" findings when seen there. Only flag hardcoded ARNs/account IDs/access
keys if they appear inside `.tf` files themselves (they currently do not — see
[[project-terraform-baseline]]).

The OIDC role itself is not defined in `terraform/` — to audit its trust policy scoping
(repo/branch conditions), you'd need to inspect it directly via AWS CLI/console
(`aws iam get-role --role-name github-actions-deploy`), since it's out of band from this IaC.

Infra changes in this repo are meant to flow through the `.claude/skills/scaffold-terraform`,
`/tf-plan`, and `/tf-apply` skills rather than hand-written Terraform (per CLAUDE.md
conventions) — worth noting if recommending fixes, since the user may prefer regenerating via
skill vs. manual edits.
