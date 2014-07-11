# VERSION: HHVM

FROM ubuntu:14.04

MAINTAINER Vincent Serpoul <vincent@serpoul.com>

# HHVM Fastcgi
RUN sudo apt-get -y install hhvm

RUN sudo /usr/share/hhvm/install_fastcgi.sh
RUN sudo update-rc.d hhvm defaults

# Add volume so that it is accessible from outside the container to the fastcgi container
ADD var/www /var/www
VOLUME ["/var/www"]

# Expose the default port
EXPOSE 9000

# Set default container command
ENTRYPOINT  ["service", "hhvm", "start"]

# docker build -t vincentserpoul/hhvm .

# docker stop myhhvm;docker rm myhhvm;
# docker stop myhhvm;docker rm myhhvm;docker run --name myhhvm -i -t -p 9000:9000 -v /home/core/docker.io/vincentserpoul/docker_hhvm/shared/hhvm_log:/var/log/hhvm -v /home/core/www:/var/www --link mymariadb:db --link myredis:redis -d vincentserpoul/phpfpm
