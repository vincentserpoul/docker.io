FROM ubuntu:14.04
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Fix locales
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Enable universe & src
RUN sed -i s/main/'main universe'/ /etc/apt/sources.list

# Set correct environment variables.
ENV HOME /root

# Run upgrades
RUN echo udev hold | dpkg --set-selections && \
    echo initscripts hold | dpkg --set-selections &&\
    echo upstart hold | dpkg --set-selections &&\
    apt-get update -q &&\
    apt-get -y upgrade

# Install build tools for nginx
RUN apt-get -y install wget git unzip build-essential libc6 libexpat1-dev libgd2-xpm-dev libgeoip1 libgeoip-dev libpam0g libssl1.0.0 libxml2 libperl-dev perl perl-base

# Download nginx
ENV PCRE_VERSION 8.35
ENV ZLIB_VERSION 1.2.8
ENV OPENSSL_VERSION 1.0.1k
ENV NGINX_VERSION 1.7.9
ENV HDR_MORE_MOD_VERSION 0.25
ENV DAV_EXT_VERSION 0.0.3
ENV PSOL_VERSION 1.9.32.2
ENV HTTP_SUB_FILTER_VERSION 0.6.4

WORKDIR /usr/src

RUN wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.gz
RUN wget http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz
RUN wget ftp://ftp.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
RUN wget https://github.com/agentzh/headers-more-nginx-module/archive/v${HDR_MORE_MOD_VERSION}.tar.gz
RUN wget https://github.com/arut/nginx-dav-ext-module/archive/v${DAV_EXT_VERSION}.tar.gz
RUN wget https://github.com/pagespeed/ngx_pagespeed/archive/v${PSOL_VERSION}-beta.tar.gz
RUN wget https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/v${HTTP_SUB_FILTER_VERSION}.tar.gz

RUN for file in /usr/src/*.tar.gz; do tar -xf $file; rm -rf $file; done

# Modules
RUN cd ngx_pagespeed-${PSOL_VERSION}-beta &&\
    wget https://dl.google.com/dl/page-speed/psol/${PSOL_VERSION}.tar.gz &&\
    tar -xf ${PSOL_VERSION}.tar.gz &&\
    rm -f ${PSOL_VERSION}.tar.gz

# Configure nginx

RUN cd /usr/src/nginx-${NGINX_VERSION} && ./configure \
    --prefix=/opt/nginx \
    --user=nobody \
    --group=nogroup \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --sbin-path=/usr/sbin/nginx \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
    --http-log-path=/var/log/nginx/access.log \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --http-scgi-temp-path=/var/lib/nginx/scgi \
    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/var/run/nginx.pid \
    --with-http_addition_module \
    --with-http_secure_link_module \
    --with-http_dav_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_spdy_module \
    --with-http_sub_module \
    --with-ipv6 \
    --with-mail \
    --with-mail_ssl_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-openssl=/usr/src/openssl-${OPENSSL_VERSION} \
    --with-openssl-opt="enable-ec_nistp_64_gcc_128 no-krb5 enable-tlsext" \
    --with-pcre=/usr/src/pcre-${PCRE_VERSION} \
    --with-pcre-jit \
    --with-zlib=/usr/src/zlib-${ZLIB_VERSION} \
    --add-module=/usr/src/ngx_pagespeed-${PSOL_VERSION}-beta \
    --add-module=/usr/src/headers-more-nginx-module-${HDR_MORE_MOD_VERSION} \
    --with-http_geoip_module \
    --with-http_image_filter_module \
    --add-module=/usr/src/nginx-dav-ext-module-${DAV_EXT_VERSION} \
    --add-module=/usr/src/ngx_http_substitutions_filter_module-${HTTP_SUB_FILTER_VERSION} &&\
    mkdir -p /var/lib/nginx &&\
    mkdir -p /www

RUN mkdir /rootfs
RUN cd /usr/src/nginx-${NGINX_VERSION} && make && make DESTDIR=/rootfs install

# Add geoIP Data from maxmind
RUN mkdir -p /rootfs/usr/local/share/GeoIP/ &&\
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O /rootfs/usr/local/share/GeoIP/GeoLiteCity.dat.gz &&\
    gzip -d /rootfs/usr/local/share/GeoIP/GeoLiteCity.dat.gz &&\
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz -O /rootfs/usr/local/share/GeoIP/GeoIP.dat.gz &&\
    gzip -d /rootfs/usr/local/share/GeoIP/GeoIP.dat.gz

RUN apt-get install -qy busybox-static

# Build Root FS for nano image creation
WORKDIR /rootfs
RUN mkdir -p bin etc dev dev/pts lib proc sys tmp usr
RUN touch etc/resolv.conf
RUN cp /etc/nsswitch.conf etc/nsswitch.conf
RUN echo root:x:0:0:root:/:/bin/sh > etc/passwd
RUN echo root:x:0: > etc/group
RUN fgrep nobody /etc/passwd >> etc/passwd
RUN fgrep nogroup /etc/group >> etc/group
RUN ln -s lib lib64
RUN ln -s usr/lib lib64
RUN ln -s bin sbin
RUN cp /bin/busybox bin
RUN for X in $(busybox --list) ; do ln -s busybox bin/$X ; done
# thanks to ldd /usr/sbin/nginx
RUN bash -c "cp /lib/x86_64-linux-gnu/lib{c,dl,nsl,nss_*,pthread,resolv,crypt,rt,m,gcc_s,expat,z,lzma}.so.* lib"
RUN bash -c "cp /usr/lib/x86_64-linux-gnu/lib{gd,GeoIP,stdc++,jpeg,png12,freetype,fontconfig,Xpm,vpx,tiff,X11,jbig,xcb,Xau,Xdmcp}.so.* lib"
RUN cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib
ADD etc/nginx /rootfs/etc/nginx
RUN mkdir /rootfs/etc/nginx/sites-enabled
RUN bash -c "mkdir -p /rootfs/var/lib/nginx/{body,fastcgi,proxy,scgi,uwsgi}"
RUN mkdir /rootfs/www && bash -c "mkdir -p /rootfs/www/{empty,default}" && mv /rootfs/opt/nginx/html/* /rootfs/www/default && rm -Rf /rootfs/opt/nginx && chown -R nobody:nogroup /rootfs/www
RUN tar cf /rootfs.tar .
RUN for X in null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /rootfs.tar -C/ ./dev/$X ; done

CMD /bin/bash

# docker build -t vincentserpoul/nginx_builder docker.io/vincentserpoul/nginx_builder
# docker run vincentserpoul/nginx_builder cat /rootfs.tar > rootfs.tar

