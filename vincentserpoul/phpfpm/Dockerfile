FROM alpine:edge
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      php-fpm \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

ADD etc/php/php-fpm.conf /etc/php/php-fpm.conf
ADD etc/fpm.d/www.conf /etc/fpm.d/www.conf

EXPOSE 9000
CMD ["php-fpm"]

# docker build --rm -t vincentserpoul/phpfpm ./
# docker run -dit --restart=always --name phpfpm -p 9000:9000 vincentserpoul/phpfpm
