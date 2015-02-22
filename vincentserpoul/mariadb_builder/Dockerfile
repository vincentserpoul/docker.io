FROM ubuntu:latest
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
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

# Install build tools for php
RUN apt-get -y install wget git unzip vim \
    build-essential dpkg-dev devscripts hardening-wrapper autoconf automake1.9 autotools-dev binutils bison cmake libreadline6-dev libncurses5-dev

# Download mariadb
ENV MARIADB_VERSION 10.0.16

WORKDIR /usr/src

# Get mariadb source
RUN wget -O server-mariadb-${MARIADB_VERSION}.tar.gz https://github.com/MariaDB/server/archive/mariadb-${MARIADB_VERSION}.tar.gz

RUN for file in /usr/src/*.tar.gz; do tar -xf $file; rm -rf $file; done

# Configure php
RUN cd /usr/src/server-mariadb-${MARIADB_VERSION} &&\
    ./BUILD/autorun.sh &&\
    ./configure \
    --prefix=/rootfs/usr/local/mysql --enable-assembler \
    --with-extra-charsets=complex \
    --enable-thread-safe-client \
    --with-big-tables \
    --with-plugin-maria \
    --with-aria-tmp-tables \
    --with-mysqld-ldflags=-static \
    --with-client-ldflags=-static \
    --with-readline \
    --with-ssl \
    --with-plugins=max-no-ndb \
    --with-embedded-server \
    --with-libevent \
    --with-zeromq \
    --with-mysqld-ldflags=-all-static \
    --with-client-ldflags=-all-static \
    --with-zlib-dir=bundled \
    --enable-local-infile

RUN mkdir /rootfs
RUN cd /usr/src/server-mariadb-${MARIADB_VERSION} && make


CMD /bin/bash
