FROM nextcloud:33-apache

# Add custom config for Resend SMTP reply-to and mail settings
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php

# Ensure correct ownership of custom config
RUN chown www-data:www-data /usr/src/nextcloud/config/smtp-config.php
