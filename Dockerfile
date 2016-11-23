FROM php:7.0-alpine

RUN apk --update add \
        curl \
        zip \
        unzip \
        git \
        vim \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt bcmath zip

RUN curl -L getcomposer.org/installer | php
RUN chmod +x composer.phar && mv composer.phar /usr/local/bin/composer
RUN composer global require hirak/prestissimo --no-interaction --no-progress
