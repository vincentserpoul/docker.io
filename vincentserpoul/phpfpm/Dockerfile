FROM scratch
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /

EXPOSE 9000

# Set default container command
ENTRYPOINT  ["/usr/local/sbin/php-fpm"]

# CMD /bin/sh
