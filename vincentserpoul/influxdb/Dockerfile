FROM busybox:ubuntu-14.04

MAINTAINER Vincent Serpoul "<vincent@serrpoul.com>"

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE 8083 8086 8086/udp 8088 2003 4242 25826

WORKDIR /app

# copy binary into image
COPY influxd /app/

# Add influxd to the PATH
ENV PATH=/app:$PATH

# Generate a default config
RUN influxd config > /etc/influxdb.toml

# Use /data for all disk storage
RUN sed -i 's/dir = "\/.*influxdb/dir = "\/data/' /etc/influxdb.toml

VOLUME ["/data"]

ENTRYPOINT ["influxd", "--config", "/etc/influxdb.toml"]

# To generate the standalone binary:
# export GO_VER=1.5.3-alpine
# export GOROOT=/Users/Shared/go
# export GOPATH=your GO PATH inside the docker host
#
# git clone https://github.com/influxdb/usage-client influxdb/usage-client
# git clone git@github.com:influxdb/influxdb.git influxdb/influxdb
# git checkout <commit of the release hash>
#
# from influx folder:
# docker run -it -v "${GOPATH}":/gopath -v "$(pwd)":/app -e "GOPATH=/gopath" -w /app golang:$GO_VER sh -c 'CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o influxd ./cmd/influxd'
#
# from this folder:
# docker build --rm -t vincentserpoul/influxdb:v0.10.0 ./
# docker stop influxdb;docker rm influxdb;docker run -dit --name influxdb --restart=always  -p 8083:8083 -p 8086:8086 -p 8088:8088 vincentserpoul/influxdb:v0.10.0