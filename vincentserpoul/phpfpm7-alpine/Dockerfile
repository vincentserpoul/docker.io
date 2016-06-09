FROM vincentserpoul/php-7.0.7-fpm-alpine
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      libmemcached-dev libpng-dev icu-dev \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

RUN docker-php-ext-install -j1 iconv mcrypt opcache mysqli json gd intl mbstring

ADD php.ini  /usr/local/etc/php/conf.d/tune.ini

EXPOSE 9000

# docker build --rm -t vincentserpoul/phpfpm7 ./
