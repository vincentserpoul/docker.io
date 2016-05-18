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

RUN mkdir -p /var/log/mysql
RUN chown -R mysql:mysql /var/log/mysql
RUN chmod -R go-rwx /etc/mysql /var/log/mysql
RUN chmod -R u-x /etc/mysql /var/log/mysql

ADD start.sh /
RUN chmod u+x /start.sh

# forward request and error logs to docker log collector as mariadb is not the
# ran process
RUN ln -sf /dev/stdout /var/log/mysql/ohmaria_slow_query.log
RUN ln -sf /dev/stderr /var/log/mysql/ohmaria_error.log

EXPOSE 3306
CMD ["/start.sh"]

# docker build --rm -t vincentserpoul/mariadb ./
# docker rm mariadatastore;docker run --name mariadatastore -v /var/lib/mysql busybox /bin/sh;
# docker stop ohmaria;docker rm ohmaria;docker run -dit --restart=always --name ohmaria -p 3306:3306 -e MYSQL_USER=user -e MYSQL_PASSWORD=password --volumes-from mariadatastore vincentserpoul/mariadb
