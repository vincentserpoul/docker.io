FROM centurylink/ca-certs
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /

RUN ln -s etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

EXPOSE 80

# Set default container command
ENTRYPOINT  ["/usr/sbin/nginx"]
