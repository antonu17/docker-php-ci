FROM php:7.0-cli

RUN apt-get update && apt-get install -y \
        zip \
        unzip \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt bcmath sockets zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -L getcomposer.org/installer | php \
    && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer \
    && composer global require hirak/prestissimo --no-interaction --no-progress \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

