FROM vincentserpoul/nginx
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

ADD etc/nginx/sites-available/tgv /etc/nginx/sites-available/tgv
RUN ln -s /etc/nginx/sites-available/tgv /etc/nginx/sites-enabled/tgv

# Set default container command
ENTRYPOINT  ["/usr/sbin/nginx"]
