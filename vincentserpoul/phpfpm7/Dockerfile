FROM php:7.0.6-fpm
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
RUN sed -i 's/pm.max_children = 5/pm.max_children = 25/g' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/pm.max_spare_servers = 3/pm.max_spare_servers = 20/g' /usr/local/etc/php-fpm.d/www.conf && \
    echo "pm.max_requests = 500" >> /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000


# docker build --rm -t vincentserpoul/phpfpm7 ./
