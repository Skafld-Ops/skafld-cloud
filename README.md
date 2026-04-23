# Skafld Cloud

**Self-hosted cloud storage and collaboration for Skafld Studio.**

Skafld Cloud is a production Nextcloud 33 deployment providing file storage, sync, sharing, contacts, calendars, and collaboration tools for the Skafld Studio team. Hosted on Railway at [cloud.skafldstudio.com](https://cloud.skafldstudio.com).

## Architecture

```
Client  -->  cloud.skafldstudio.com  -->  Railway (Docker)
                                           |
                                    nextcloud:33-apache
                                           |
                         +--------+--------+--------+
                         |        |        |        |
                      Postgres  Redis     S3     Resend
                      (Railway) (Railway) (Railway) (SMTP)
```

| Component | Provider | Purpose |
|-----------|----------|---------|
| **Nextcloud 33** | Docker (nextcloud:33-apache) | Core application |
| **PostgreSQL** | Railway managed | Primary database |
| **Redis** | Railway managed | Distributed cache + file locking |
| **S3** | Railway Buckets | Object storage for user files |
| **Resend** | smtp.resend.com | Transactional email |
| **Doppler** | doppler.yaml | Secrets management (dev/stg/prd) |

## Skafld Customizations

All customizations live in `docker/` and the root `Dockerfile`. The rest is upstream Nextcloud.

| File | Purpose |
|------|---------|
| `docker/php-tuning.ini` | OPcache + JIT, APCu 128M, 512MB upload limits |
| `docker/redis-config.php` | Redis caching from `REDIS_URL` with APCu fallback |
| `docker/s3-config.php` | S3 object storage from `OBJECTSTORE_S3_*` env vars |
| `docker/smtp-config.php` | Resend SMTP, reply-to hello@skafldstudio.com |
| `docker/performance-config.php` | 20+ preview providers, maintenance window, trash retention |
| `Dockerfile` | Adds ffmpeg + ImageMagick for media previews |

## Quick Start

### Prerequisites

- Docker
- [Doppler CLI](https://docs.doppler.com/docs/install-cli) (for secrets)

### Run Locally

```bash
# With Doppler (recommended)
doppler setup          # Select skafld-cloud > dev
doppler run -- docker compose up

# Or set env vars manually (see .env.example)
docker build -t skafld-cloud .
docker run -p 8080:80 --env-file .env skafld-cloud
```

### Development (Nextcloud core)

```bash
npm ci                    # Install JS dependencies
npm run dev               # Build frontend (dev mode)
composer serve            # PHP dev server on localhost:8080
```

### Testing

```bash
npm run test              # Vitest (JS/TS)
composer test             # PHPUnit (PHP)
npm run cypress           # Cypress E2E
```

### Linting

```bash
npm run lint              # ESLint
composer cs:check         # php-cs-fixer
composer psalm            # PHP static analysis
```

## Environment Variables

See [`.env.example`](.env.example) for the full inventory. Key groups:

- **Nextcloud Admin** -- `NEXTCLOUD_ADMIN_USER`, `NEXTCLOUD_ADMIN_PASSWORD`, `NEXTCLOUD_TRUSTED_DOMAINS`
- **PostgreSQL** -- `POSTGRES_HOST`, `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`
- **Redis** -- `REDIS_URL`
- **S3 Object Storage** -- `OBJECTSTORE_S3_BUCKET`, `OBJECTSTORE_S3_KEY`, `OBJECTSTORE_S3_SECRET`, etc.
- **SMTP (Resend)** -- `SMTP_HOST`, `SMTP_PORT`, `SMTP_PASSWORD`, `MAIL_FROM_ADDRESS`, `MAIL_DOMAIN`

Secrets are managed via Doppler with three environments: `dev`, `stg`, `prd`.

## Deployment

Railway auto-deploys from `master`. Configuration:

- **Build**: `Dockerfile` (see `railway.toml`)
- **Health check**: `/status.php` (300s timeout)
- **Restart policy**: On failure, max 5 retries

## Upstream Sync

This repo tracks `upstream/master` from [nextcloud/server](https://github.com/nextcloud/server). To pull upstream changes:

```bash
git fetch upstream
git merge upstream/master
# Resolve any conflicts in Dockerfile or docker/ directory
```

Skafld customizations are isolated to `docker/`, `Dockerfile`, `.env.example`, `railway.toml`, and `doppler.yaml`, so upstream merges should be clean.

## License

AGPL-3.0-or-later. See [COPYING](COPYING) for details.

---

<details>
<summary>Upstream Nextcloud Documentation</summary>

For full Nextcloud Server documentation, see:
- [Nextcloud Admin Manual](https://docs.nextcloud.com/server/latest/admin_manual/)
- [Nextcloud Developer Manual](https://docs.nextcloud.com/server/latest/developer_manual/)
- [Nextcloud User Manual](https://docs.nextcloud.com/server/latest/user_manual/)
- [Nextcloud Server GitHub](https://github.com/nextcloud/server)

</details>
