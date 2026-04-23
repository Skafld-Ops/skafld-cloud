FROM nextcloud:33-apache

# Install ffmpeg for video/audio preview generation
# and additional utilities for document previews
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        libmagickcore-7.q16-10-extra \
    ; \
    rm -rf /var/lib/apt/lists/*

# PHP tuning: OPcache, APCu, upload limits
COPY docker/php-tuning.ini /usr/local/etc/php/conf.d/99-skafld-tuning.ini

# Nextcloud config overlays (loaded alphabetically from config/)
COPY docker/smtp-config.php /usr/src/nextcloud/config/smtp-config.php
COPY docker/redis-config.php /usr/src/nextcloud/config/redis-config.php
COPY docker/performance-config.php /usr/src/nextcloud/config/performance-config.php
COPY docker/s3-config.php /usr/src/nextcloud/config/s3-config.php

RUN chown -R www-data:www-data /usr/src/nextcloud/config/
