FROM php:7-fpm
MAINTAINER vincent@serpoul.com

RUN apt-get update -y
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mysql curl json opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install redis \
    && docker-php-ext-enable redis

COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY php.ini /usr/local/etc/php/
# ADD php.ini  /etc/php/7.0/fpm/php.ini
RUN ln -sf /dev/stdout var/log/php-fpm_access.log &&\
    ln -sf /dev/stderr var/log/php-fpm_error.log

# docker build --rm -t vincentserpoul/phpfpm7 ./
