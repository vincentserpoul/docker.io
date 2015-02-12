FROM ubuntu:latest
# inspired by https://github.com/hacfi/dockerfiles/tree/master/percona
# and https://github.com/tutumcloud/tutum-docker-mariadb
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

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

# Prerequisites
RUN apt-get install -y wget vim

RUN sudo wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add - &&\
    echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list &&\
    sudo apt-get update &&\
    sudo apt-get -y install libgmp-dev libmemcached-dev hhvm

RUN sudo /usr/share/hhvm/install_fastcgi.sh
RUN sudo update-rc.d hhvm defaults

# Add volume so that it is accessible from outside the container to the fastcgi container
ADD var/www /var/www
VOLUME ["/var/www"]

# Expose the default port
EXPOSE 9000

# Set default container command
ENTRYPOINT  ["service", "hhvm", "start"]
