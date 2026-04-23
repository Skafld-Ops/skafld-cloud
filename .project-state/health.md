# Structural Health Scorecard — Skafld Cloud
<!-- Generated: 2026-04-23 | Score: 98/100 -->

## Overall Score: 98/100 (Healthy)

## Universal Checks

| Category | Check | Result | Notes |
|----------|-------|--------|-------|
| Version Control | Git initialized | PASS | .git/ present |
| | .gitignore exists | PASS | 190 lines, comprehensive |
| | No secrets committed | PASS | .env, .env.local in .gitignore; Doppler for secrets |
| | Clean working tree | PASS | No uncommitted changes |
| Testing | Test files exist | PASS | 1,475 test files (PHPUnit + Vitest + Cypress) |
| | Tests pass | N/A | Cannot verify without local runtime |
| | Coverage configured | PASS | Vitest coverage + codecov.yml |
| CI/CD | Pipeline exists | PASS | 56 GitHub Actions workflows |
| | CI passing | N/A | Cannot verify remotely |
| Dependencies | Lock file present | PASS | composer.lock + package-lock.json |
| | Deps pinned | PASS | Version ranges specified in both |
| | Dev deps separated | PASS | devDependencies separate in package.json |
| Documentation | README exists | PASS | Present (stock Nextcloud) |
| | README current | WARNING | Stock Nextcloud README, not Skafld-specific (-2) |
| | Contributing guide | PASS | .github/CONTRIBUTING.md |
| Code Quality | Linter configured | PASS | ESLint, php-cs-fixer, Psalm, Stylelint |
| | Formatter configured | PASS | php-cs-fixer, .editorconfig |
| | Type checking | PASS | TypeScript + Psalm |

## Stack-Specific Checks

### Docker
| Check | Result | Notes |
|-------|--------|-------|
| .dockerignore exists | PASS | Present |
| No `latest` tag in FROM | PASS | `nextcloud:33-apache` (pinned) |

### Node/TypeScript
| Check | Result | Notes |
|-------|--------|-------|
| engines field specified | PASS | Node ^24.0.0, npm ^11.3.0 |
| node_modules in .gitignore | PASS | Present |
| tsconfig.json present | PASS | Present |

## Deductions

| Check | Weight | Applied |
|-------|--------|---------|
| README not project-specific | -2 | Yes — stock Nextcloud README |

## Remediation Steps

1. **README.md** — Add Skafld Cloud-specific header, deployment instructions, and link to cloud.skafldstudio.com. Keep upstream Nextcloud content below the fold or in a separate section.

## Documentation Coverage

- Root CLAUDE.md: **Missing** (being created now)
- .env.example: **Present and current**
- Apps with README: 3/32 (9%) — most apps are upstream Nextcloud core, so this is expected
