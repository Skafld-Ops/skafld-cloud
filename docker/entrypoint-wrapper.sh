#!/bin/sh
set -eu

echo "==> Skafld Cloud: pre-entrypoint cleanup..."

# Remove apps from the persistent volume that don't exist in our v34 source
# These were installed by the v33 Docker template and cause upgrade failures
if [ -d "/var/www/html/apps" ] && [ -d "/usr/src/nextcloud/apps" ]; then
    for app_dir in /var/www/html/apps/*/; do
        [ -d "$app_dir" ] || continue
        app_name=$(basename "$app_dir")
        if [ ! -d "/usr/src/nextcloud/apps/$app_name" ]; then
            echo "==> Removing stale app not in v34 source: $app_name"
            rm -rf "$app_dir"
        fi
    done
fi

# Also clean custom_apps
if [ -d "/var/www/html/custom_apps" ]; then
    for app_dir in /var/www/html/custom_apps/*/; do
        [ -d "$app_dir" ] || continue
        app_name=$(basename "$app_dir")
        echo "==> Removing custom app for clean upgrade: $app_name"
        rm -rf "$app_dir"
    done
fi

echo "==> Skafld Cloud: handing off to Nextcloud entrypoint..."
exec /entrypoint.sh "$@"
