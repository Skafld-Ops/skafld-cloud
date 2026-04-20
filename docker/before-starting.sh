#!/bin/bash
set -e

echo "==> Running Skafld Cloud pre-start hook..."

# Force-sync v34 apps from source to replace stale v33 apps on the volume
echo "==> Syncing v34 apps to persistent volume..."
if [ -d "/usr/src/nextcloud/apps" ]; then
    rsync -rlDog --chown www-data:root /usr/src/nextcloud/apps/ /var/www/html/apps/
fi
if [ -d "/usr/src/nextcloud/lib" ]; then
    rsync -rlDog --chown www-data:root /usr/src/nextcloud/lib/ /var/www/html/lib/
fi
if [ -d "/usr/src/nextcloud/core" ]; then
    rsync -rlDog --chown www-data:root /usr/src/nextcloud/core/ /var/www/html/core/
fi

# Copy version.php to ensure version match
cp /usr/src/nextcloud/version.php /var/www/html/version.php
chown www-data:root /var/www/html/version.php

# Disable apps that were bundled by v33 template but don't exist in v34 source
INCOMPATIBLE_APPS="workflowengine survey_client"
for app in $INCOMPATIBLE_APPS; do
    if [ -d "/var/www/html/apps/$app" ] || [ -d "/var/www/html/custom_apps/$app" ]; then
        echo "==> Disabling incompatible app: $app"
        php /var/www/html/occ app:disable "$app" 2>/dev/null || true
    fi
done

# Run upgrade if needed
echo "==> Running occ upgrade..."
php /var/www/html/occ upgrade || true
php /var/www/html/occ maintenance:mode --off 2>/dev/null || true

echo "==> Pre-start hook complete."
