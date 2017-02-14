FROM php:7.1-cli

RUN apt-get update && apt-get install -y \
        zip \
        unzip \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        libicu-dev \
        g++ \
    && docker-php-ext-install -j$(nproc) iconv mcrypt bcmath zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) gd intl

RUN curl -L getcomposer.org/installer | php \
    && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer \
    && composer global require hirak/prestissimo --no-interaction --no-progress

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

