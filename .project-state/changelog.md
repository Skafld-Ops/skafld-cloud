# Changelog — Skafld Cloud
<!-- Generated: 2026-04-23 | Window: Full history (no release tags) -->

> **Note:** No release tags exist in this repository. This changelog covers all Skafld-specific commits (post-fork customizations). Consider tagging the current state as `v0.1.0` to anchor future changelogs.

## Unreleased (since fork)

### Features
- `305d853` (2026-04-22) — Add Doppler secrets management and Railway configuration (4 files)
- `23ba1d5` (2026-04-22) — Production optimization: Redis caching, ffmpeg previews, PHP tuning (5 files)
- `aea69612` (pre-fork) — Add Railway deployment config with Resend SMTP email

### Fixes
- `2003e52` (2026-04-22) — Fix Dockerfile: correct ImageMagick package for Debian Trixie (1 file)
- `f2ecf58` (2026-04-20) — Clean v34 deployment: fix all root causes (4 files)
- `d05722d` (2026-04-20) — Fix: disable authoritative classmaps for v34 autoloading (1 file)
- `766d44a` (2026-04-20) — Fix Dockerfile: bump base image app max-version 33->34 (1 file)
- `52fa3eb` (2026-04-20) — Fix: custom entrypoint to clean stale apps BEFORE occ upgrade (2 files)
- `87722b3` (2026-04-20) — Fix: remove stale v33 apps not in v34 source before upgrade (1 file)
- `21a8de7` (2026-04-20) — Fix: force-sync v34 apps/lib/core to volume before upgrade
- `15c0023` (2026-04-20) — Fix Dockerfile: use stock v33 base, only add custom config
- `eecbaed` (2026-04-20) — Fix: use v34 source (data already upgraded, can't downgrade)

### Documentation
- `72d169b` (2026-04-22) — Update .env.example with complete variable inventory (1 file)

### Reverts
- `3685f1f` (2026-04-21) — Revert to stock Nextcloud 33 stable (1 file)

## Upstream Nextcloud

The remaining commit history is from the upstream `nextcloud/server` repository. Notable recent upstream changes include ESLint 10 upgrade, dependency bumps, and various chore commits. These are not tracked individually in this changelog.
