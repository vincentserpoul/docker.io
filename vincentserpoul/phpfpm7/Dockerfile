FROM php:7.0.5-fpm
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apt-get update
RUN apt-get install -y libmemcached-dev libjpeg62-turbo-dev libmcrypt-dev \
                        libpng12-dev libicu-dev unzip

RUN docker-php-ext-install -j1 iconv mcrypt opcache mysqli json gd intl mbstring

RUN apt-get install

RUN curl -fsSL https://github.com/phpredis/phpredis/archive/php7.zip \
            -o redis.zip \
    && mkdir -p redis \
    && unzip redis.zip \
    && rm redis.zip \
    && ( \
        cd phpredis-php7 \
        && phpize \
        && ./configure \
        && make -j1 \
        && make install \
    ) \
    && rm -r redis \
    && docker-php-ext-enable redis

ADD php.ini  /usr/local/etc/php/conf.d/tune.ini

EXPOSE 9000


# docker build --rm -t vincentserpoul/phpfpm7 ./
