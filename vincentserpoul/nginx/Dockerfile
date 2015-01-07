# VERSION: nginx-1.6.2

FROM ubuntu:14.04

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

# Install build tools for nginx
RUN apt-get -y install wget git unzip build-essential libc6 libexpat1-dev libgd2-xpm-dev libgeoip1 libgeoip-dev libpam0g libssl1.0.0 libxml2 libperl-dev perl perl-base

# Download nginx
ENV PCRE_VERSION 8.35
ENV ZLIB_VERSION 1.2.8
ENV OPENSSL_VERSION 1.0.1i
# ENV NGINX_VERSION 1.7.5
ENV NGINX_VERSION 1.6.2
ENV HDR_MORE_MOD_VERSION 0.25
ENV DAV_EXT_VERSION 0.0.3
# ENV PSOL_VERSION 1.9.32.1
ENV PSOL_VERSION 1.8.31.4
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

# Add geoIP Data from maxmind
RUN mkdir -p /usr/local/share/GeoIP/ &&\
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O /usr/local/share/GeoIP/GeoLiteCity.dat.gz &&\
    gzip -d /usr/local/share/GeoIP/GeoLiteCity.dat.gz &&\
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz -O /usr/local/share/GeoIP/GeoIP.dat.gz &&\
    gzip -d /usr/local/share/GeoIP/GeoIP.dat.gz

# Configure nginx

RUN cd /usr/src/nginx-${NGINX_VERSION} && ./configure \
    --prefix=/opt/nginx \
    --user=nobody \
    --group=nogroup \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --sbin-path=/usr/local/sbin/nginx \
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
    --add-module=/usr/src/ngx_http_substitutions_filter_module-${HTTP_SUB_FILTER_VERSION}

RUN cd /usr/src/nginx-${NGINX_VERSION} && make && make install

RUN mkdir -p /var/lib/nginx &&\
    mkdir -p /etc/nginx/conf.d &&\
    mkdir -p /etc/nginx/sites-available &&\
    mkdir -p /etc/nginx/sites-enabled

ADD etc/init.d/nginx /etc/init.d/
ADD etc/nginx/nginx.conf /etc/nginx/
RUN sudo chmod +x /etc/init.d/nginx

RUN sudo /usr/sbin/update-rc.d -f nginx defaults

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the default port
EXPOSE 80

# adding websites folder
ADD etc/nginx/sites-available/default /etc/nginx/sites-available/
RUN sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# pagespeed cache
RUN mkdir -p /var/ngx_pagespeed_cache &&\
    mkdir -p /var/log/nginx

# make the website accessible
ADD etc/nginx/html /etc/nginx/html

# log format
ADD etc/nginx/conf.d/* /etc/nginx/conf.d/

# Set default container command
ENTRYPOINT  ["service", "nginx", "start"]

# docker build -t vincentserpoul/nginx docker.io/vincentserpoul/nginx
# docker stop mynginx;docker rm mynginx;
# docker run --name mynginx -i -t -p 80:80 -v /home/core/www:/var/www  -d vincentserpoul/nginx

# docker build -t vincentserpoul/nginx_builder docker.io/vincentserpoul/nginx_builder
# docker ps --all | grep -v vincentserpoul | grep -v busybox | grep -v localhost | grep -v ppdg |  awk '{print $1}' | xargs docker rm
# docker images --no-trunc | grep none | awk '{print $3}' | xargs docker rmi
# docker run vincentserpoul/nginx_builder cat /rootfs.tar > ~/docker.io/vincentserpoul/nano_nginx/rootfs.tar
# docker stop mynanonginx;docker rm mynanonginx;docker build -t vincentserpoul/nano_nginx ./docker.io/vincentserpoul/nano_nginx/
# docker run -dit --name mynanonginx -p 80:80 -v /home/core/www:/var/www vincentserpoul/nano_nginx
# sudo ./docker-enter mynanonginx
