FROM mysql:5.7

MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD etc/mysql/conf.d etc/mysql/conf.d
RUN chmod -R go-rwx /etc/mysql/conf.d
RUN chmod -R u-x /etc/mysql/conf.d

ADD var/data /var/data

COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]

EXPOSE 3306
CMD ["mysqld"]

# sudo docker rm -f ohmy;
# sudo docker rm mysqldatastore;sudo docker run --name mysqldatastore -p 23:23 -v /var/lib/mysql -v /var/lib/mysql-files busybox /bin/sh;
# sudo docker build -t "vincentserpoul/mysql57" ./;
# sudo docker run -dit --name ohmy -p 3306:3306 --volumes-from mysqldatastore -v $(pwd)/log:/var/log -e MYSQL_ROOT_PASSWORD=dev vincentserpoul/mysql57
# sudo docker exec -it ohmy "mysql -root -pdev < /var/data/data.sql"
