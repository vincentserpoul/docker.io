FROM alpine:latest

RUN apk add --update curl redis && rm -rf /var/cache/apk/*
ENV REDIS_PASSWORD password

RUN echo '#!/bin/sh ' >> /run.sh
RUN echo 'redis-server ' >> /run.sh &&\
    echo '--dir /var/data/redis >> /run.sh &&\
    echo '--appendonly yes ' >> /run.sh &&\
    echo '--requirepass "${REDIS_PASSWORD}"' >> /run.sh'
RUN chmod +x /run.sh
RUN mkdir -p /var/data/redis &&\
    chown -R redis:redis /var/data/redis

EXPOSE 6379
CMD ["/run.sh"]

# docker run -dit --restart=always --name redis -p 6379:6379 -e REDIS_PASSWORD=dev vincentserpoul/redis