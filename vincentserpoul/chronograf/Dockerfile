FROM debian:jessie
MAINTAINER vincent@serpoul.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y wget dpkg

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE 10000

# copy binary into image
RUN wget https://s3.amazonaws.com/get.influxdb.org/chronograf/chronograf_0.10.0-rc2_amd64.deb
RUN dpkg -i chronograf_0.10.0-rc2_amd64.deb
RUN sed -i 's/127.0.0.1/0.0.0.0/' /opt/chronograf/config.toml
RUN mkdir /data
RUN sed -i 's/\/opt\/chronograf\/chronograf.db/\/data\/chronograf.db/' /opt/chronograf/config.toml

VOLUME ["/data"]

ENTRYPOINT ["/opt/chronograf/chronograf", "--config", "/opt/chronograf/config.toml"]

# docker build --rm -t vincentserpoul/chronograf:v0.10.0_rc2 ./
# docker run -dit --name chronograf -p 10000:10000 --link influxdb:influxdb vincentserpoul/chronograf:v0.10.0_rc2