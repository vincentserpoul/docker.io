FROM scratch
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /

EXPOSE 6379

# Set default container command
CMD ["/usr/local/redis/bin/redis-server", "/etc/redis/6379.conf"]
