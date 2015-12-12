FROM alpine
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      redis \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

ENV REDIS_PASSWORD nopassword

RUN echo '#!/bin/sh ' >> /run.sh

RUN if [ ${REDIS_PASSWORD} != 'nopassword' ]; \
    then echo 'redis-server --dir /var/data/redis --appendonly yes  --requirepass "${REDIS_PASSWORD}"'  >> /run.sh; \
    else echo 'redis-server --dir /var/data/redis --appendonly yes ' >> /run.sh; \
    fi
RUN chmod +x /run.sh
RUN mkdir -p /var/data/redis &&\
    chown -R redis:redis /var/data/redis

EXPOSE 6379
CMD ["/run.sh"]

# docker build --rm -t vincentserpoul/redis ./
# docker run -dit --restart=always --name redis -p 6379:6379 -e REDIS_PASSWORD=dev vincentserpoul/redis
