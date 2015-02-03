FROM busybox
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# pagespeed cache
RUN mkdir -p /var/ngx_pagespeed_cache &&\
    mkdir -p /var/log/nginx

EXPOSE 80

# Set default container command
#ENTRYPOINT  ["/usr/sbin/nginx"]
ENTRYPOINT ["/bin/sh"]

# docker build -t vincentserpoul/nginx ./docker.io/vincentserpoul/nginx/
# docker run -dit --name mynanonginx -p 80:80 -v /home/core/www:/var/www  -d vincentserpoul/nginx
