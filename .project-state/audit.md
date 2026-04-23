# Project Audit — Skafld Cloud
<!-- Generated: 2026-04-23 | Commit: 2003e52 | Branch: master -->

## Project Classification

| Field | Value |
|-------|-------|
| **Name** | Skafld Cloud (Nextcloud Server fork/deployment) |
| **Type** | Single repo (upstream fork with deployment customizations) |
| **Platform** | Web (self-hosted cloud storage/collaboration) |
| **Primary Language** | PHP 8.2+ (~85%), TypeScript/JavaScript (~10%), Vue 3 (~5%) |
| **Framework** | Nextcloud Server v34 (dev) |
| **Architecture** | Monolithic PHP app with modular apps system |
| **License** | AGPL-3.0-or-later |
| **Deployment** | Docker on Railway (PaaS) |
| **Domain** | cloud.skafldstudio.com |

## Repository Structure

```
skafld-cloud/
├── apps/                    # 32 Nextcloud core apps (dav, files, settings, etc.)
├── build/                   # Build scripts, frontend tooling, demi.sh
├── config/                  # Nextcloud config templates
├── core/                    # Core Nextcloud PHP + frontend (Vue components, middleware)
├── cypress/                 # E2E tests (Cypress 15)
├── dist/                    # Compiled frontend assets (876 entries)
├── docker/                  # Skafld deployment configs
│   ├── performance-config.php  # Preview providers, maintenance window
│   ├── php-tuning.ini          # OPcache, APCu, upload/memory limits
│   ├── redis-config.php        # Redis caching from REDIS_URL
│   └── smtp-config.php         # Resend SMTP reply-to config
├── lib/                     # Core PHP libraries
│   ├── private/             # OC\ namespace (internal APIs)
│   ├── public/              # OCP\ namespace (public APIs)
│   └── unstable/            # NCU\ namespace (unstable APIs)
├── resources/               # Static resources
├── tests/                   # PHPUnit test suites
├── themes/                  # Nextcloud themes
├── 3rdparty/                # Third-party PHP dependencies (git submodule)
├── Dockerfile               # Based on nextcloud:33-apache + ffmpeg + ImageMagick
├── railway.toml             # Railway deployment config
├── doppler.yaml             # Doppler secrets (project: skafld-cloud)
├── composer.json            # PHP dependencies (platform: php 8.2)
├── package.json             # Node dependencies (Vue 3, Vite, Cypress)
└── version.php              # v34.0.0 dev
```

## Git State

| Field | Value |
|-------|-------|
| **Branch** | master |
| **Status** | Clean |
| **Remote (origin)** | Skafld's repo |
| **Remote (upstream)** | nextcloud/server (master) |
| **Latest Commit** | `2003e52` — Fix Dockerfile: correct ImageMagick package for Debian Trixie |
| **Release Tags** | None (no v* tags) |

### Recent Commit History (Skafld-specific)

| Hash | Date | Author | Message |
|------|------|--------|---------|
| `2003e52` | 2026-04-22 | Charles Sims | Fix Dockerfile: correct ImageMagick package for Debian Trixie |
| `72d169b` | 2026-04-22 | Charles Sims | Update .env.example with complete variable inventory |
| `305d853` | 2026-04-22 | Charles Sims | Add Doppler secrets management and Railway configuration |
| `23ba1d5` | 2026-04-22 | Charles Sims | Production optimization: Redis caching, ffmpeg previews, PHP tuning |
| `3685f1f` | 2026-04-21 | mikeskafld | Revert to stock Nextcloud 33 stable |
| `f2ecf58` | 2026-04-20 | mikeskafld | Clean v34 deployment: fix all root causes |
| `d05722d` | 2026-04-20 | mikeskafld | Fix: disable authoritative classmaps for v34 autoloading |
| `766d44a` | 2026-04-20 | mikeskafld | Fix Dockerfile: bump base image app max-version 33->34 |
| `52fa3eb` | 2026-04-20 | mikeskafld | Fix: custom entrypoint to clean stale apps BEFORE occ upgrade |

## Services & Configuration

### Internal Services

| Service | Config File | Notes |
|---------|------------|-------|
| PHP-FPM/Apache | Dockerfile, php-tuning.ini | OPcache + JIT, APCu 128M, 512MB uploads |
| Redis Cache | docker/redis-config.php | Distributed cache + locking, parsed from REDIS_URL |
| Preview Generator | docker/performance-config.php | 20+ preview providers (images, video, docs) |
| SMTP | docker/smtp-config.php | Resend, reply-to hello@skafldstudio.com |

### External Services

| Service | Provider | Env Var(s) |
|---------|----------|-----------|
| PostgreSQL | Railway | POSTGRES_HOST, POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD |
| Redis | Railway | REDIS_URL |
| S3 Object Storage | Railway Buckets | OBJECTSTORE_S3_* |
| SMTP Email | Resend | SMTP_HOST, SMTP_PORT, SMTP_PASSWORD |
| Secrets Management | Doppler | doppler.yaml (project: skafld-cloud) |

### Environment Variables (from .env.example)

Categories: Nextcloud Admin (4), Reverse Proxy (2), PostgreSQL (4), Redis (1), S3 (7), SMTP (7) — **25 total**

## Dependencies

### PHP (composer.json)
- **Runtime**: PHP 8.2+ with 18 required extensions (apcu, curl, gd, mbstring, openssl, pdo, etc.)
- **Dev**: bamarni/composer-bin-plugin (manages sub-tool deps)
- **Lock file**: composer.lock present

### Node (package.json)
- **Runtime**: Vue 3, Pinia, @nextcloud/* libraries, webdav client
- **Dev**: Vite 7, Vitest 4, Cypress 15, ESLint 10, Sass
- **Lock file**: package-lock.json present
- **Engines**: Node ^24.0.0, npm ^11.3.0

## Documentation Health

### Documentation Inventory

| Path | Category | Tier | Status | Action |
|------|----------|------|--------|--------|
| `README.md` | Governance | 1 | Stale | **Update** — still stock Nextcloud, needs Skafld branding |
| `CHANGELOG.md` | Governance | 1 | Stale | **Update** — minimal, should reference .project-state |
| `CODE_OF_CONDUCT.md` | Governance | 1 | Current | Keep |
| `SECURITY.md` | Governance | 1 | Current | Keep |
| `DESIGN.md` | Architecture | 4 | Current | Keep (Nextcloud upstream) |
| `COPYING` / `COPYING-README` | Governance | 1 | Current | Keep |
| `.github/CONTRIBUTING.md` | Guide | 1 | Current | Keep (upstream) |
| `.github/ISSUE_TEMPLATE/Feature_request.md` | Guide | 4 | Current | Keep |
| `.github/pull_request_template.md` | Guide | 4 | Current | Keep |
| `.env.example` | Governance | 1 | Current | Keep |
| `contribute/HowToApplyALicense.md` | Guide | 4 | Current | Keep |
| `apps/*/README.md` (3 apps) | Package Doc | 3 | Current | Keep |

### Missing Documentation
- **CLAUDE.md** — No root CLAUDE.md exists (will be created by this skill)
- **README.md** — Needs Skafld-specific content overlay

## Serena Memory Health

| Metric | Value |
|--------|-------|
| **Total memories** | 5 (just created) |
| **Committed** | 0 (all new/untracked) |
| **Uncommitted Added** | 5 |
| **Onboarded** | Yes (this session) |

Memories created: `project_overview`, `tech_stack`, `suggested_commands`, `code_style_conventions`, `task_completion_checklist`
