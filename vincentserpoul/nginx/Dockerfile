FROM scratch
# ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD rootfs.tar /

# activation of test default
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# redirect logs to stdout
#RUN ln -sf /dev/stdout /var/log/nginx/default-access.#log
#RUN ln -sf /dev/stderr /var/log/nginx/default-error.log
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Set default container command
ENTRYPOINT ["/usr/sbin/nginx"]


# docker build --rm -t vincentserpoul/nginx docker.io/vincentserpoul/nginx
# docker run -dit --name nginx -p 80:80 -p 443:443 vincentserpoul/nginx
