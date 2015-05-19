# there is a bug from nodejs 0.12 so we will not use the compiled one now
#FROM scratch
## ALL CREDITS GOES TO: https://github.com/Zenithar/dockerfiles
#MAINTAINER Vincent Serpoul <vincent@serpoul.com>
#
#ADD rootfs.tar /
#
#EXPOSE 8080
#CMD bin/bash
FROM gliderlabs/alpine:3.1
RUN apk-install nodejs
CMD ["node"]
