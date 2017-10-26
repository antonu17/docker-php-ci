FROM php:7.0-cli-alpine

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 1.5.2

RUN echo "===> Install build tools and libs..." \
 && apk --no-cache add --virtual .build-deps $PHPIZE_DEPS openssl-dev \
    icu-dev libmcrypt-dev sqlite-dev zlib-dev postgresql-dev \
 && apk --no-cache add curl git icu-libs libmcrypt zlib openssl \
    \
    \
 && echo "===> Add php extensions..." \
 && docker-php-ext-install -j5 bcmath pcntl intl mcrypt pdo_mysql pdo_sqlite pdo_pgsql \
 && pecl channel-update pecl.php.net \
 && yes '' | pecl install apcu mongodb redis \
 && docker-php-ext-enable apcu mongodb opcache redis \
    \
    \
 && echo "===> Configure PHP..." \
 && echo "apc.enable_cli=On" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini \
 && echo "memory_limit=-1" > "$PHP_INI_DIR/conf.d/memory-limit.ini" \
 && echo "date.timezone=${PHP_TIMEZONE:-UTC}" > "$PHP_INI_DIR/conf.d/date_timezone.ini" \
    \
    \
 && echo "===> Install composer..." \
 && curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer \
 && php -r " \
    \$signature = '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && composer --ansi --version --no-interaction \
 && composer --ansi --no-interaction global require hirak/prestissimo \
    \
    \
 && echo "===> Cleanup image..." \
 && docker-php-source delete \
 && rm -rf /usr/src/* \
 && apk --no-cache del .build-deps

CMD ["composer"]
