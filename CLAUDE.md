# CLAUDE.md — Project Context
<!-- PROJECT_STATE: commit=2003e52 timestamp=2026-04-23T09:30:00-07:00 health=98 -->

## Project Identity
- **Name**: Skafld Cloud (Nextcloud Server deployment)
- **Type**: Single repo (upstream fork with deployment customizations)
- **Platform**: Web — self-hosted cloud storage/collaboration at cloud.skafldstudio.com
- **Stack**: PHP 8.2+, Vue 3, TypeScript, PostgreSQL, Redis, Docker
- **Architecture**: Monolithic PHP app with modular apps system (Nextcloud)
- **Deployment**: Docker on Railway, secrets via Doppler
- **Health**: 98/100 (Healthy — README is stock Nextcloud)

## Development Commands
```bash
# Setup
npm ci                              # Install JS dependencies
composer install                    # Install PHP dependencies

# Dev server
composer serve                      # PHP dev server on localhost:8080
npm run dev                         # Build JS (dev mode)
npm run watch                       # Watch JS changes

# Test
npm run test                        # Vitest (JS/TS)
composer test                       # PHPUnit (PHP)
npm run cypress                     # Cypress E2E

# Lint / Format
npm run lint                        # ESLint
composer cs:check                   # php-cs-fixer check
composer psalm                      # PHP static analysis
npm run stylelint                   # SCSS lint

# Build
npm run build                       # Production JS build

# Docker
docker build -t skafld-cloud .      # Build container
doppler run -- docker compose up    # Run with secrets
```

## Skafld Customizations (docker/)
All Skafld-specific configs live in `docker/` and the root `Dockerfile`:
- `docker/php-tuning.ini` — OPcache, JIT, APCu, 512MB uploads
- `docker/redis-config.php` — Redis from REDIS_URL env var
- `docker/smtp-config.php` — Resend SMTP, reply-to hello@skafldstudio.com
- `docker/performance-config.php` — Preview providers, maintenance window

## Key Namespaces
- `OC\` → `lib/private/` (internal APIs)
- `OCP\` → `lib/public/` (public/stable APIs)
- `NCU\` → `lib/unstable/` (experimental APIs)

## Active Issues
1. **S3 bucket provisioning** — config wired up (docker/s3-config.php) but Railway bucket needs to be provisioned and tested
2. **Upstream sync strategy** — document when/how to merge from nextcloud/server upstream

## Next Action
Provision and test the S3 bucket on Railway to ensure file persistence across container redeployments.

## Full Context
For detailed audit, health scorecard, roadmap, and changelog, see `.project-state/`:
- `.project-state/audit.md` — Full discovery findings and docs analysis
- `.project-state/health.md` — Structural health scorecard with remediation steps
- `.project-state/roadmap.md` — Reconciled roadmap with prioritized next steps
- `.project-state/changelog.md` — Generated changelog since last release
