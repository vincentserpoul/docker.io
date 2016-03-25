FROM php:7.0.4-fpm
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apt-get update
RUN apt-get install -y libmemcached-dev libjpeg62-turbo-dev &&\
    libmcrypt-dev libpng12-dev libicu-dev

RUN docker-php-ext-install -j1 iconv mcrypt opcache mysqli json gd intl mbstring

RUN apt-get install  unzip &&\
    curl -fsSL 'https://github.com/php-memcached-dev/php-memcached/archive/php7.zip' -o memcached.zip \
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
