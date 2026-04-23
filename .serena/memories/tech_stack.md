# Tech Stack

## Backend
- **PHP 8.2+** (Nextcloud server core)
- **Nextcloud Server v34** (dev, based on upstream)
- **PostgreSQL** — primary database (Railway managed)
- **Redis** — distributed cache + file locking
- **APCu** — local PHP memory cache
- **Composer** — PHP dependency management (vendor-dir: lib/composer)

## Frontend
- **Vue.js 3** with Pinia (state) and Vuex 4 (legacy)
- **TypeScript** with Vite bundler
- **@nextcloud/vue** component library
- **SCSS** styling with Sass compiler

## Infrastructure
- **Docker** — Dockerfile based on `nextcloud:33-apache`
- **Railway** — deployment platform (railway.toml)
- **Doppler** — secrets management (doppler.yaml)
- **Resend** — transactional email (SMTP)
- **S3** — object storage (Railway Buckets)

## Testing
- **PHPUnit** — PHP unit/integration tests (tests/phpunit-autotest.xml)
- **Vitest** — JS/TS unit tests
- **Cypress 15** — E2E browser tests
- **Psalm** — PHP static analysis (psalm.xml + variants)

## CI/CD
- **GitHub Actions** — 50+ workflow files (.github/workflows/)
- **ESLint** — JS/TS linting
- **php-cs-fixer** — PHP code style
- **Stylelint** — CSS/SCSS linting

## Node Requirements
- Node.js ^24.0.0
- npm ^11.3.0
