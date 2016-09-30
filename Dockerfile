FROM alpine:edge

RUN apk --update add \
    php7 \
    php7-fpm \
    php7-json \
    php7-zlib \
    php7-xml \
    php7-pdo \
    php7-phar \
    php7-openssl \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-mysqlnd \
    php7-gd \
    php7-mcrypt \
    php7-curl \
    php7-opcache \
    php7-ctype \
    php7-intl \
    php7-bcmath \
    php7-xmlreader \
    php7-zip \
    --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ 

RUN rm -rf /var/cache/apk/*

CMD ["php", "-a"]
