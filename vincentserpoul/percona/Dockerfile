FROM ubuntu:14.04

MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ENV DEBIAN_FRONTEND noninteractive

# inspired by https://github.com/hacfi/dockerfiles/tree/master/percona
# and https://github.com/tutumcloud/tutum-docker-mariadb

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Fix locales
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Set correct environment variables.
ENV HOME /root

# Run upgrades
RUN echo udev hold | dpkg --set-selections && \
echo initscripts hold | dpkg --set-selections &&\
echo upstart hold | dpkg --set-selections &&\
apt-get update -q &&\
apt-get -y upgrade

# Install percona
RUN apt-get -y install
ADD etc/key/percona.key /tmp/percona.key
RUN cat /tmp/percona.key | sudo apt-key add -
ADD etc/apt/sources.list.d/percona.list /etc/apt/sources.list.d/percona.list
RUN apt-get update

RUN apt-get install -y percona-server-server-5.6 percona-server-client-5.6

ADD etc/mysql/my.cnf /etc/mysql/my.cnf

ADD dbinit/init_percona_db.sh /init_percona_db.sh
ADD dbinit/run.sh /run.sh
RUN chmod 775 /*.sh

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

EXPOSE 3306
CMD ["/run.sh"]

# docker build -t vincentserpoul/percona docker.io/vincentserpoul/percona/
# docker stop mysql_datastore;docker rm mysql_datastore;
# storage : docker run -d -v /var/lib/mysql --name mysql_datastore -p 23:23 busybox
# docker stop mypercona;docker rm mypercona;docker run -i -t --volumes-from mysql_datastore --name="mypercona" -p 3306:3306 -e PERCONA_PASS="password" -d vincentserpoul/percona
