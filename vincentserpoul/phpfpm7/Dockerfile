#FROM php:7.0.4-fpm-alpine
FROM vincentserpoul/php-7.0.4-fpm-alpine
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      libmemcached-dev libpng-dev icu-dev \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

RUN docker-php-ext-install -j1 iconv mcrypt opcache mysqli json gd intl mbstring

RUN curl -fsSL 'https://github.com/php-memcached-dev/php-memcached/archive/php7.zip' -o memcached.zip \
    && mkdir -p memcached \
    && unzip memcached.zip \
    && rm memcached.zip \
    && ( \
        cd php-memcached-php7 \
        && phpize \
        && ./configure --enable-memcached --disable-memcached-sasl \
        && make -j1 \
        && make install \
    ) \
    && rm -r memcached \
    && docker-php-ext-enable memcached

ADD php.ini  /usr/local/etc/php/conf.d/tune.ini

EXPOSE 9000

# docker build --rm -t vincentserpoul/phpfpm7 ./
