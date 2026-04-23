# Skafld Cloud — Project Overview

**Skafld Cloud** is Skafld Studio's internal Nextcloud deployment, a self-hosted cloud file storage and collaboration platform.

## What It Is
- A **fork/deployment** of Nextcloud Server v34 (development), based on upstream `nextcloud/server`
- Deployed on **Railway** (PaaS) using Docker
- Hosted at **cloud.skafldstudio.com**
- Licensed under AGPL-3.0

## Purpose
Provides file storage, sync, sharing, contacts, calendars, and collaboration tools for Skafld Studio's internal team and potentially clients.

## Architecture
- **Base**: Nextcloud 33-apache Docker image (upgrading to v34)
- **Database**: PostgreSQL (Railway managed)
- **Cache/Locking**: Redis (Railway managed), APCu (local)
- **Email**: Resend SMTP (smtp.resend.com)
- **Object Storage**: S3-compatible (Railway Buckets)
- **Secrets**: Doppler (project: skafld-cloud, config: dev/stg/prd)
- **Domain**: cloud.skafldstudio.com (production)

## Customizations Over Stock Nextcloud
1. `docker/php-tuning.ini` — OPcache, APCu, upload limits (512MB), JIT
2. `docker/redis-config.php` — Redis caching from REDIS_URL env var
3. `docker/smtp-config.php` — Resend SMTP with reply-to
4. `docker/performance-config.php` — Preview providers, maintenance window, trash retention
5. `Dockerfile` — ffmpeg + ImageMagick extras for media previews

## Key People
- **Charles Sims** — primary developer/deployer
- **mikeskafld** — contributor (deployment fixes, reverts)
