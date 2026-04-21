FROM nextcloud:33-apache

# Resend SMTP reply-to config (host/port/auth set via Railway env vars)
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php
RUN chown www-data:www-data /usr/src/nextcloud/config/smtp-config.php
