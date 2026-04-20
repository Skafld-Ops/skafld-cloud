FROM nextcloud:33-apache

# Data was upgraded to v34 — must use v34 source code
# Base image provides PHP extensions, Apache config, and entrypoint
COPY . /usr/src/nextcloud/

# Add custom config for Resend SMTP reply-to and mail settings
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php

# Add pre-start hook to handle upgrade and disable incompatible apps
COPY docker/before-starting.sh /docker-entrypoint-hooks.d/before-starting/10-upgrade.sh
RUN chmod +x /docker-entrypoint-hooks.d/before-starting/10-upgrade.sh

# Ensure correct ownership
RUN chown -R www-data:www-data /usr/src/nextcloud/
