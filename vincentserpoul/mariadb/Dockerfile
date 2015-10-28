FROM alpine:edge
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      mariadb mariadb-client \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    MYSQL_USER="user" \
    MYSQL_PASSWORD="password"

ADD etc/mysql/my.cnf /etc/mysql/
ADD start.sh /

RUN chmod u+x /start.sh
RUN mkdir -p /var/log/mysql
RUN chown -R mysql: /var/log/mysql

EXPOSE 3306
CMD ["/start.sh"]

# docker build --rm -t vincentserpoul/mariadb ./
# sudo docker rm mariadatastore;sudo docker run --name mariadatastore -p 23:23 -v /var/lib/mysql -v /var/lib/mysql-files busybox /bin/sh;
# docker stop ohmaria;docker rm ohmaria;docker run -dit --restart=always --name ohmaria -p 3306:3306 -e MYSQL_USER=user -e MYSQL_PASSWORD=password --volumes-from mariadatastore vincentserpoul/mariadb
