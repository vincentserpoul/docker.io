FROM scratch
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /

EXPOSE 9000

# for magento cache to run
RUN mkdir -p /var/tmp/ /tmp/ && chown -R www-data:www-data /var/tmp/ /tmp

# Set default container command
ENTRYPOINT  ["/usr/local/sbin/php-fpm"]

#CMD /bin/sh

# docker build --rm -t vincentserpoul/phpfpm53 docker.io/vincentserpoul/phpfpm53/
# docker run --name phpfpm  --link ohmaria:dbwrite01 --link ohmaria:dbread01 --link redissessions:redissessions --link rediscache:rediscache --link redisfullpagecache:redisfullpagecache -it -p 9053:9000 --restart=always -v /home/core/giftcardmall/:/var/www/paypal-gifts.com vincentserpoul/phpfpm53
