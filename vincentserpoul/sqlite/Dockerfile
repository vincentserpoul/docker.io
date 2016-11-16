FROM alpine:3.4
MAINTAINER Vincent Serpoul vincent@serpoul.com

RUN apk -U upgrade && \
    apk --update add sqlite \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
