#!/bin/bash
set -e

echo "==> Running Skafld Cloud pre-start hook..."

# Disable apps that are incompatible with v34 core
# These were bundled by the v33 Docker template but don't exist in the v34 source
INCOMPATIBLE_APPS="workflowengine survey_client"

for app in $INCOMPATIBLE_APPS; do
    if [ -d "/var/www/html/apps/$app" ] || [ -d "/var/www/html/custom_apps/$app" ]; then
        echo "==> Disabling incompatible app: $app"
        php /var/www/html/occ app:disable "$app" 2>/dev/null || true
    fi
done

# Run upgrade if needed
echo "==> Checking if upgrade is needed..."
php /var/www/html/occ upgrade 2>/dev/null || true
php /var/www/html/occ maintenance:mode --off 2>/dev/null || true

echo "==> Pre-start hook complete."
