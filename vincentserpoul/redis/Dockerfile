FROM alpine:edge
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade &&\
    apk --update add redis &&\
    rm -rf /tmp/src &&\
    rm -rf /var/cache/apk/*

ENV REDIS_PASSWORD dev

RUN mkdir -p /var/data/redis &&\
    chown -R redis:redis /var/data/redis

EXPOSE 6379
CMD redis-server --dir /var/data/redis --appendonly yes --requirepass ${REDIS_PASSWORD}

# docker build --rm -t vincentserpoul/redis ./
# docker run -dit --restart=always --name redis -p 6379:6379 -e REDIS_PASSWORD=dev vincentserpoul/redis
