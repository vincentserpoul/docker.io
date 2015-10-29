FROM alpine:edge
MAINTAINER Vincent Serpoul <vincent@serpoul.com>

RUN apk -U upgrade && \
    apk --update add \
      nodejs \
      && \
      rm -rf /tmp/src && \
      rm -rf /var/cache/apk/*

EXPOSE 8080
CMD ["/node"]

# docker build -t vincentserpoul/nodejs ./
# docker run -dit --restart=always --name nodejs -p 8080 vincentserpoul/nodejs
