FROM nextcloud:33-apache

# Data was upgraded to v34 — must use v34 source code
# Base image provides PHP extensions, Apache config, and entrypoint
COPY . /usr/src/nextcloud/

# Add custom config for Resend SMTP reply-to and mail settings
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php

# Fix: base image bundles apps with max-version="33" that our source
# doesn't overwrite (activity, password_policy, etc). Bump them to 34
# so occ upgrade doesn't fail on shipped app compatibility checks.
RUN find /usr/src/nextcloud/apps -name "info.xml" -exec \
    sed -i 's/max-version="33"/max-version="34"/g' {} \;

# Ensure correct ownership
RUN chown -R www-data:www-data /usr/src/nextcloud/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
