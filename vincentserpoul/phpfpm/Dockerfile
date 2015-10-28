FROM alpine:edge
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      php-fpm \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

EXPOSE 9000
CMD ["/bin/sh"]

# docker build -t vincentserpoul/phpfpm ./
# docker run -dit --restart=always --name phpfpm -p 3306:3306 vincentserpoul/phpfpm
