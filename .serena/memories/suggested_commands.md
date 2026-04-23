# Suggested Commands

## Setup
```bash
npm ci                        # Install JS dependencies
composer install              # Install PHP dependencies (if developing locally)
doppler run -- docker compose up  # Run with Doppler secrets
```

## Development
```bash
npm run dev                   # Build JS for development
npm run watch                 # Watch mode for JS
composer serve                # Start PHP dev server (localhost:8080)
make dev-setup                # Clean + npm ci
```

## Build
```bash
npm run build                 # Production JS build
make build-js-production      # Same via Make
```

## Testing
```bash
npm run test                  # Run Vitest JS tests
npm run test:coverage         # Vitest with coverage
npm run test:watch            # Vitest watch mode
composer test                 # PHPUnit tests
composer test:db              # PHPUnit DB tests
npm run cypress               # Run Cypress E2E tests
npm run cypress:gui           # Open Cypress GUI
```

## Linting & Code Quality
```bash
npm run lint                  # ESLint
npm run lint:fix              # ESLint with auto-fix
composer cs:check             # PHP code style check
composer cs:fix               # PHP code style fix
composer psalm                # PHP static analysis
composer psalm:strict         # Strict Psalm analysis
npm run stylelint             # CSS/SCSS lint
npm run stylelint:fix         # CSS/SCSS lint fix
```

## Nextcloud CLI
```bash
./occ <command>               # Nextcloud CLI tool (run inside container or local PHP)
```

## Docker
```bash
docker build -t skafld-cloud .
docker run -p 8080:80 skafld-cloud
```

## System Utilities (macOS/Darwin)
- `git`, `ls`, `cd`, `grep`, `find` — standard Unix tools
- `brew` — macOS package manager (if needed)
- `doppler` — Doppler CLI for secrets
