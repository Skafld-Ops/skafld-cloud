FROM nextcloud:33-apache

# Copy our forked source code over the default Nextcloud source
# The entrypoint copies from /usr/src/nextcloud to /var/www/html on first run
COPY . /usr/src/nextcloud/

# Add custom config for reply-to and additional mail settings
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php

# Ensure correct ownership
RUN chown -R www-data:www-data /usr/src/nextcloud/
