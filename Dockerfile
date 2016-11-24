FROM php:7.0-alpine

RUN apk --update add \
        coreutils \
        curl \
        git \
        unzip \
        zip \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt bcmath zip \
    && rm -rf /var/cache/apk/*

RUN curl -L getcomposer.org/installer | php
RUN chmod +x composer.phar && mv composer.phar /usr/local/bin/composer
RUN composer global require hirak/prestissimo --no-interaction --no-progress
