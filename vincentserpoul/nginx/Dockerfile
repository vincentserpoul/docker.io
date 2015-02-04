FROM scratch
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# pagespeed cache
RUN mkdir -p /var/ngx_pagespeed_cache &&\
    mkdir -p /var/log/nginx

EXPOSE 80

# Set default container command
ENTRYPOINT  ["/usr/sbin/nginx"]
