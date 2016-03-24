FROM debian:jessie
MAINTAINER vincent@serpoul.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y aptitude curl wget debian-keyring debian-archive-keyring apt-transport-https sendmail

RUN wget https://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg

ADD dotdeb.list /etc/apt/sources.list.d/dotdeb.list

RUN apt-get update
RUN apt-get -y install php7.0 php7.0-cli php7.0-curl php7.0-opcache \
        php7.0-dev php7.0-mysql php7.0-intl  \
        php7.0-gd php7.0-json php7.0-fpm php7.0-memcached

RUN apt-get autoremove -y

ADD www.conf /etc/php/7.0/fpm/php-fpm.conf
ADD php.ini  /etc/php/7.0/fpm/php.ini

RUN mkdir -p /run/php
EXPOSE 9000

RUN ln -sf /dev/stdout /var/log/php-fpm_access.log
RUN ln -sf /dev/stderr /var/log/php-fpm_error.log

ENTRYPOINT ["/usr/sbin/php-fpm7.0"]
CMD ["-F", "-R"]

# docker build --rm -t vincentserpoul/phpfpm7 ./
