#!/bin/bash

echo "==> Running Skafld Cloud pre-start hook..."

# Remove apps from the volume that aren't in our v34 source
# These were bundled by the v33 Docker template and are now incompatible
echo "==> Cleaning stale apps from volume..."
for app_dir in /var/www/html/apps/*/; do
    app_name=$(basename "$app_dir")
    if [ ! -d "/usr/src/nextcloud/apps/$app_name" ]; then
        echo "==> Removing stale app not in source: $app_name"
        rm -rf "$app_dir"
    fi
done

# Force-sync v34 source to volume
echo "==> Syncing v34 source to volume..."
rsync -rlDog --chown www-data:root /usr/src/nextcloud/apps/ /var/www/html/apps/
rsync -rlDog --chown www-data:root /usr/src/nextcloud/lib/ /var/www/html/lib/
rsync -rlDog --chown www-data:root /usr/src/nextcloud/core/ /var/www/html/core/
rsync -rlDog --chown www-data:root /usr/src/nextcloud/ocs/ /var/www/html/ocs/ 2>/dev/null || true
rsync -rlDog --chown www-data:root /usr/src/nextcloud/resources/ /var/www/html/resources/ 2>/dev/null || true
cp /usr/src/nextcloud/version.php /var/www/html/version.php
chown www-data:root /var/www/html/version.php

# Run upgrade
echo "==> Running occ upgrade..."
php /var/www/html/occ upgrade || true
php /var/www/html/occ maintenance:mode --off 2>/dev/null || true

echo "==> Pre-start hook complete."
