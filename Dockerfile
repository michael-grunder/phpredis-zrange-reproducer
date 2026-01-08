FROM php:8.4.3-fpm-alpine3.21

RUN apk add --no-cache \
      ${PHPIZE_DEPS} \
      redis \
    && pecl install lzf \
    && docker-php-ext-enable lzf \
    && pecl install -o -f -D 'enable-redis-lzf="yes"' redis \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/pear \
    && apk del ${PHPIZE_DEPS}

COPY reproducer.php /root/reproducer.php
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
