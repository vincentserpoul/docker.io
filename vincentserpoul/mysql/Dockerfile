FROM mysql/mysql-labs:5.7.7-json

MAINTAINER Vincent Serpoul <vincent@serpoul.com>

COPY etc/mysql/my.cnf /etc/mysql/
ADD etc/mysql/conf.d /etc/mysql/conf.d
ADD var/data /var/data
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]

EXPOSE 3306
CMD ["mysqld"]

# docker-machine create --driver virtualbox ppdg-api
# docker rm ohmy;docker rm mysqldatastore;docker run --name mysqldatastore -p 23:23 -v /var/lib/mysql -v /var/lib/mysql-files busybox /bin/sh;docker build -t "ppdg/mysql57" ./;docker run -dit --name ohmy -p 3306:3306 --volumes-from mysqldatastore -v $(pwd)/log:/var/log -e MYSQL_ROOT_PASSWORD=dev ppdg/mysql57
# docker run -it --link ohmy:mysql --rm mysql/mysql-labs:5.7.7-json sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" < /var/data/schema.sql'
