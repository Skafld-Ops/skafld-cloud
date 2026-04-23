# Upstream Sync Strategy

How to keep Skafld Cloud in sync with the upstream [nextcloud/server](https://github.com/nextcloud/server) repository while preserving our customizations.

## Remotes

```
origin    https://github.com/Skafld-Ops/skafld-cloud.git   (our fork)
upstream  https://github.com/nextcloud/server.git           (Nextcloud)
```

## Skafld-Specific Files

All Skafld customizations are isolated to these files. Upstream will never touch them, so merges should be conflict-free:

| File | Purpose |
|------|---------|
| `Dockerfile` | Base image + ffmpeg + ImageMagick + config overlays |
| `docker/php-tuning.ini` | OPcache, JIT, APCu, upload limits |
| `docker/redis-config.php` | Redis caching from REDIS_URL |
| `docker/smtp-config.php` | Resend SMTP reply-to |
| `docker/performance-config.php` | Preview providers, maintenance window |
| `.env.example` | Environment variable documentation |
| `doppler.yaml` | Doppler secrets config |
| `railway.toml` | Railway deployment config |
| `CLAUDE.md` | AI coding context |
| `.project-state/` | Project status artifacts |
| `PROJECT_STATUS.html` | HTML status report |
| `docs/` | Skafld-specific documentation |
| `.serena/` | Serena agent memories |

The only shared file that could conflict is `version.php` (we pinned it to v33).

## Sync Procedure

### 1. Fetch upstream

```bash
git fetch upstream
```

### 2. Check what's changed

```bash
# See how far behind we are
git log --oneline master..upstream/master | head -20

# Check for conflicts in our files
git diff master...upstream/master -- Dockerfile docker/ version.php
```

### 3. Merge upstream

```bash
git merge upstream/master
```

If conflicts occur (likely only in `version.php`):
- Accept upstream's version number if upgrading
- Keep our pinned version if staying on current release

### 4. Verify after merge

```bash
# Build Docker image to verify
docker build -t skafld-cloud .

# Run lint checks
npm run lint
composer cs:check
```

### 5. Deploy

Push to `master` -- Railway auto-deploys.

## When to Sync

| Trigger | Action |
|---------|--------|
| **Security advisory** | Sync immediately. Nextcloud publishes advisories at [nextcloud.com/security](https://nextcloud.com/security/advisories/). |
| **Minor release** (33.0.x) | Sync within a week. These are bug fixes and security patches. |
| **Major release** (34.0.0) | Plan and test. Update `version.php`, verify Docker base image is available (`nextcloud:34-apache`), test full deployment. |
| **Monthly cadence** | At minimum, sync monthly to stay current with security patches. |

## Upgrading to a New Major Version (e.g., 33 -> 34)

1. Wait for the official Docker image (`nextcloud:34-apache`) to be published
2. Update `Dockerfile` base image:
   ```dockerfile
   FROM nextcloud:34-apache
   ```
3. Update `version.php` to match the new version
4. Merge upstream's `stable34` branch (not `master`, which is dev):
   ```bash
   git fetch upstream
   git merge upstream/stable34
   ```
5. Build and test locally:
   ```bash
   docker build -t skafld-cloud:34-test .
   docker run -p 8080:80 skafld-cloud:34-test
   ```
6. Deploy to staging first if available, then production
7. Tag the release:
   ```bash
   git tag -a v0.2.0 -m "Upgrade to Nextcloud 34"
   ```

## Handling version.php Conflicts

When merging upstream, `version.php` will almost always conflict because we pinned it to v33. Resolution:

- **If staying on current version**: Keep our pinned values
- **If upgrading**: Accept upstream's version values, then verify the `$OC_VersionCanBeUpgradedFrom` array includes our current version

## Submodule: 3rdparty

The `3rdparty/` directory is a git submodule. After merging upstream:

```bash
git submodule update --init
```

This ensures third-party PHP dependencies match the upstream version.

## Rollback

If a sync breaks production:

```bash
# Find the last known good commit
git log --oneline -10

# Revert to it
git revert HEAD

# Or for multiple commits
git revert <bad-merge-sha>

# Push to trigger Railway redeploy
git push origin master
```

Never force-push `master` -- Railway tracks the branch and force-pushes can cause deployment issues.
