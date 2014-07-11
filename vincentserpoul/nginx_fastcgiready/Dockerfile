FROM vincentserpoul/nginx:latest

MAINTAINER Vincent Serpoul <vincent@serpoul.com>

# Fastcgi config (works for phpfpm and hhvm)
ADD etc/nginx/fastcgi.conf /etc/nginx/

# Add certificates for ssl
RUN mkdir -p /etc/ssl
ADD etc/ssl/dev.mywebsite.com.key /etc/ssl/
ADD etc/ssl/certs/dev.mywebsite.com.crt /etc/ssl/certs/
RUN chmod 400 /etc/ssl/dev.mywebsite.com.key

# Add config for the new test ssl website (that will be shared through volumes with the fastcgi server)
ADD etc/nginx/sites-available/dev.mywebsite.com /etc/nginx/sites-available/
RUN sudo ln -s /etc/nginx/sites-available/dev.mywebsite.com /etc/nginx/sites-enabled/dev.mywebsite.com

# Expose the ssl port
EXPOSE 443

# docker build -t vincentserpoul/nginx_fastcgiready .
# docker stop mynginx_fastcgiready;docker rm mynginx_fastcgiready; docker run --name mynginx_fastcgiready -i -t -p 443:443  --volumes-from myphpfpm_53 -v /home/core/docker.io/vincentserpoul/nginx_fastcgiready/shared/nginx_log:/var/log/nginx --link myphpfpm_53:fastcgi_server  -d vincentserpoul/nginx_fastcgiready

