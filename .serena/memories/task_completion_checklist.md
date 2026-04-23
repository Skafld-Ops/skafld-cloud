# Task Completion Checklist

When a task is completed, run these checks as applicable:

## PHP Changes
1. `composer cs:check` — Verify code style
2. `composer psalm` — Run static analysis
3. `composer lint` — PHP syntax check
4. `composer test` — Run PHPUnit tests (if tests exist for changed code)

## JavaScript/TypeScript Changes
1. `npm run lint` — ESLint check
2. `npm run test` — Run Vitest tests
3. `npm run build` — Verify production build succeeds

## CSS/SCSS Changes
1. `npm run stylelint` — Stylelint check

## Docker/Infrastructure Changes
1. `docker build -t skafld-cloud .` — Verify Docker build
2. Check railway.toml health check path is valid
3. Verify .env.example is updated if new env vars added

## All Changes
1. Verify no secrets/credentials in committed files
2. Ensure .gitignore covers any new generated files
3. Sign commits: `git commit -sm "message"`
