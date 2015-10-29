FROM scratch
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /

RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

EXPOSE 80 443

# Set default container command
ENTRYPOINT ["/usr/sbin/nginx"]

# docker build --rm -t vincentserpoul/nginx docker.io/vincentserpoul/nginx
# docker run -dit --name nginx -p 80:80 -p 443:443 vincentserpoul/nginx
