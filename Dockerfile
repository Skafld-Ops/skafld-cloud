FROM nextcloud:33-apache

# --- Layer 1: Copy v34 source over v33 base ---
# The base image has v33 Nextcloud in /usr/src/nextcloud/.
# Our fork is v34 dev. COPY overlays our source on top.
# Files in base that aren't in our source remain (e.g. some bundled apps).
COPY . /usr/src/nextcloud/

# --- Layer 2: Fix app compatibility ---
# Base image bundles apps with max-version="33" in info.xml.
# Our v34 source doesn't overwrite all of them (same app name, base keeps its copy).
# Bump ALL apps to allow v34 so occ install/upgrade doesn't reject shipped apps.
RUN find /usr/src/nextcloud/apps -name "info.xml" -exec \
    sed -i 's/max-version="33"/max-version="34"/g' {} \;

# --- Layer 3: Fix autoloading ---
# v33 base apps use setClassMapAuthoritative(true) which disables PSR-4 fallback.
# v34 source adds new PHP classes not in v33 classmaps → autoloader can't find them.
# Disable authoritative mode so PSR-4 works as fallback for new classes.
RUN find /usr/src/nextcloud/apps -path "*/composer/autoload_real.php" -exec \
    sed -i 's/setClassMapAuthoritative(true)/setClassMapAuthoritative(false)/' {} \;

# --- Layer 4: Resend SMTP reply-to config ---
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php

# --- Layer 5: Ownership ---
RUN chown -R www-data:www-data /usr/src/nextcloud/
