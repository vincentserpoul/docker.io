FROM alpine:edge
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk add --update mariadb && rm -rf /var/cache/apk/*
ENV MYSQL_ROOT_PASSWORD password

EXPOSE 3306
CMD ["/bin/sh"]

# docker build -t vincentserpoul/mariadb ./
# docker run -dit --restart=always --name ohmaria -p 3306:3306 -e MYSQL_PASSWORD=dev vincentserpoul/mariadb
