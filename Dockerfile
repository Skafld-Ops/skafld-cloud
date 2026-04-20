FROM nextcloud:33-apache

# Data was upgraded to v34 — must use v34 source code
# Base image provides PHP extensions, Apache config, and entrypoint
COPY . /usr/src/nextcloud/

# Add custom config for Resend SMTP reply-to and mail settings
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php

# Custom entrypoint wrapper to clean stale v33 apps BEFORE the
# official entrypoint runs rsync + occ upgrade
COPY docker/entrypoint-wrapper.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh

# Ensure correct ownership
RUN chown -R www-data:www-data /usr/src/nextcloud/

ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]
