FROM ubuntu:latest
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Fix locales
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Run upgrades
RUN echo udev hold | dpkg --set-selections && \
    echo initscripts hold | dpkg --set-selections &&\
    echo upstart hold | dpkg --set-selections &&\
    apt-get update -q &&\
    apt-get -y upgrade

# Set correct environment variables.
ENV HOME /root

# Install build tools for php
RUN apt-get -y install wget git unzip vim \
    build-essential libc6 libc6-dev

# Download redis
ENV REDIS_VERSION 3.0.3

WORKDIR /usr/src

# Get redis source
RUN wget -O redis-${REDIS_VERSION}.tar.gz https://github.com/antirez/redis/archive/${REDIS_VERSION}.tar.gz

RUN for file in /usr/src/*.tar.gz; do tar -xf $file; rm -rf $file; done

RUN mkdir /rootfs
RUN cd /usr/src/redis-${REDIS_VERSION} && make && make PREFIX=/rootfs/usr/local/redis install

RUN apt-get install -qy busybox-static

# Build Root FS for nano image creation
WORKDIR /rootfs
RUN mkdir -p bin etc dev dev/pts lib proc sys tmp usr
RUN touch etc/resolv.conf
RUN cp /etc/nsswitch.conf etc/nsswitch.conf
RUN echo root:x:0:0:root:/:/bin/sh > etc/passwd
RUN echo root:x:0: > etc/group
RUN fgrep www-data /etc/passwd >> etc/passwd
RUN fgrep www-data /etc/group >> etc/group
RUN ln -s lib lib64
RUN ln -s usr/lib lib64
RUN ln -s bin sbin
RUN cp /bin/busybox bin
RUN for X in $(busybox --list) ; do ln -s busybox bin/$X ; done
# LDD
RUN bash -c "cp /lib/x86_64-linux-gnu/lib{c,dl,nsl,nss_*,pthread,resolv,crypt,rt,m,gcc_s,expat,z,lzma}.so.* lib"
RUN cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib
RUN chown -R www-data:www-data /rootfs/usr/local/redis/ &&\
    mkdir -p /rootfs/var/log/redis &&\
    mkdir -p /rootfs/var/data/redis
ADD etc/redis/6379.conf /rootfs/etc/redis/6379.conf


RUN tar cf /rootfs.tar .
RUN for X in null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /rootfs.tar -C/ ./dev/$X ; done

CMD /bin/bash

# docker build -t vincentserpoul/redis_builder docker.io/vincentserpoul/redis_builder
# docker run vincentserpoul/redis_builder cat /rootfs.tar > docker.io/vincentserpoul/redis/rootfs.tar
