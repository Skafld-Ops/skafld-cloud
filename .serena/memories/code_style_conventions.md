# Code Style & Conventions

## PHP
- **PHP 8.2+** with strict types (`declare(strict_types=1)`)
- **PSR-4 autoloading**: `OC\` → `lib/private`, `OCP\` → `lib/public`, `NCU\` → `lib/unstable`
- **php-cs-fixer** for code formatting (.php-cs-fixer.dist.php)
- **Psalm** for static analysis (psalm.xml with multiple profiles)
- **AGPL-3.0** license headers required (SPDX format)

## JavaScript/TypeScript
- **ESLint** with @nextcloud/eslint-config
- **TypeScript** (tsconfig.json present)
- **Vue 3** single-file components (.vue)
- **ES Modules** (type: "module" in package.json)
- **Vite** bundler

## CSS/SCSS
- **Stylelint** with @nextcloud/stylelint-config
- **SCSS** compiled via Sass

## Git
- Commit messages: conventional-ish (feat:, fix:, chore:, etc.)
- Sign-off required: `git commit -sm "message"`
- .git-blame-ignore-revs for ignoring code style commits
- .editorconfig for consistent editor settings

## Naming
- PHP: PascalCase for classes, camelCase for methods/variables
- JS/TS: camelCase for functions/variables, PascalCase for components
- Files: kebab-case for configs, PascalCase for PHP classes
