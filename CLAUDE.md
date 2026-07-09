# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

<!-- Static HTML/CSS portfolio site ("DMI Portfolio Website"), deployed to AWS (S3 + CloudFront) via GitHub Actions using OIDC. No build step, no JavaScript framework — pure HTML5 + CSS3. There is currently no `terraform/` directory in the repo; infrastructure is generated on demand via the `scaffold-terraform` skill (see below) and is not checked in.

This repo doubles as course material for the "DevOps Micro Internship" (DMI) — see README.md for the student-facing instructions (Ubuntu/Nginx deployment exercise, mandatory footer ownership-proof edit before deploying). -->

- Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.
## Site structure

- **index.html** — single-page site with sections: `#home` (hero), `#about`, `#services`, `#courses`, `#book`, `#community`, `#contact`, plus a mobile menu (`#mobileMenu`)
- **style.css** — all styling (~1145 lines), mobile-first, breakpoints at 900px / 768px / 600px
- **privacy.html, terms.html** — standalone pages with inline styles (not linked to style.css)
- **images/** — static assets referenced by the HTML

There is no build/lint/test tooling in this repo — changes are previewed by opening the HTML files directly in a browser.

## Deployment (`.github/workflows/deploy.yml`)

- Triggers on push to `main`
- Authenticates to AWS via GitHub OIDC (`role-to-assume: arn:aws:iam::533267262133:role/github-actions-deploy`, region `eu-north-1`)
- `aws s3 sync` the repo to bucket `pravinmishradmi-site-production` with `--delete`, excluding `.git`, `.github`, `.claude`, `terraform/`, `.mcp.json`, and `*.md`
- Invalidates CloudFront distribution `E3V6O6MRE2E21P`

Any exclude pattern added to `deploy.yml` should also be mirrored in the `deploy` skill below, and vice versa.

## Skills (`.claude/skills/`)

Infrastructure and deployment tasks are handled via skills rather than writing Terraform/AWS CLI commands by hand. All are manual-invocation only (`disable-model-invocation: true`):

- `/scaffold-terraform [aws-region] [project-name]` — generates a full `terraform/` directory (S3 + CloudFront static hosting, OAC-based access, S3 backend). Full spec in `.claude/skills/scaffold-terraform/template-spec.md`. Defaults: region `ap-south-1`, project name `portfolio-site` — note these differ from the region/bucket actually in use by `deploy.yml` (`eu-north-1` / `pravinmishradmi-site-production`), so pass explicit arguments when scaffolding for this site.
- `/tf-plan` — runs `terraform plan` in `terraform/` and summarizes resource changes/risk/blast radius
- `/tf-apply` — runs `terraform apply -auto-approve` in `terraform/`, verifies CloudFront reaches "Deployed", reports outputs. Does not auto-retry on failure.
- `/deploy` — reads terraform outputs, `aws s3 sync`s site files (excluding non-site paths), invalidates CloudFront. Stops on first failing step.

## Conventions

- All infrastructure changes go through Terraform, generated via `/scaffold-terraform` — do not hand-write Terraform or modify AWS resources manually.
- GitHub Actions uses OIDC exclusively — never introduce long-lived AWS access keys.
- Site content pushed to `main` deploys automatically; there's no staging environment in this workflow.


## Project Overview

- Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.


## Architecture

- Pure HTML5 and CSS3
- No JavaScript
- No build step
- No framework

## Commands

- terraform init
- terraform plan
- terraform apply

## Conventions

- All infrastructure changes go through Terraform — never modify AWS resources manually
- No JavaScript in this project
- CSS uses mobile-first approach with breakpoints at 900px, 768px, and 600px

## Safety

Never put secrets in this file. No API keys, passwords, or AWS credentials.