# Roadmap Reconciliation — Skafld Cloud
<!-- Generated: 2026-04-23 | Commit: 2003e52 -->

## Reconciled Items

### From Commit History (Deployment Journey)

| Item | Source | Classification | Evidence | Priority |
|------|--------|---------------|----------|----------|
| Deploy Nextcloud on Railway | commits | **Done** | railway.toml, Dockerfile, .env.example all present | — |
| Configure Redis caching | commits | **Done** | docker/redis-config.php parses REDIS_URL | — |
| Configure SMTP email (Resend) | commits | **Done** | docker/smtp-config.php, SMTP env vars | — |
| Enable media preview generation | commits | **Done** | docker/performance-config.php, ffmpeg in Dockerfile | — |
| PHP performance tuning | commits | **Done** | docker/php-tuning.ini (OPcache, JIT, APCu) | — |
| Doppler secrets management | commits | **Done** | doppler.yaml, .gitignore entries | — |
| S3 object storage | .env.example | **Active** | Env vars defined but bucket may not be provisioned | High Value |
| v33→v34 upgrade | version.php | **Active** | version.php says v34, but Dockerfile uses v33 base image | Critical Path |
| Custom README/branding | assessment | **Relevant** | README.md is still stock Nextcloud | Nice to Have |

### From Inline TODOs (Upstream Nextcloud)

30 inline TODOs found, primarily in Cypress E2E tests and core PHP/JS. All are upstream Nextcloud items, not Skafld-specific. No action needed unless contributing upstream.

## Prioritized Next Steps

### 1. Critical Path: Resolve v33/v34 Version Mismatch
The `version.php` declares v34.0.0 dev, but the Dockerfile uses `nextcloud:33-apache` as the base image. This was the subject of multiple recent fix commits. **Decide**: stay on v33 stable or upgrade the base to v34 when available.

### 2. High Value: Verify S3 Object Storage
The `.env.example` includes `OBJECTSTORE_S3_*` variables but it's unclear if the bucket is provisioned on Railway. Verify and test file uploads to S3 to ensure data persistence beyond the container lifecycle.

### 3. High Value: Create Skafld-Specific README
Replace or augment the stock Nextcloud README with deployment instructions, architecture overview, and links specific to Skafld Cloud.

### 4. Nice to Have: Set Up Release Tagging
No git tags exist. Establish a baseline tag (e.g., `v0.1.0`) to enable future changelog generation and version tracking.

### 5. Defer: Upstream Sync Strategy
Determine how/when to sync with upstream `nextcloud/server` to get security patches and features without losing Skafld customizations (the `docker/` directory and Dockerfile).

## Archived Items

None — this is a first run, no stale items detected.
