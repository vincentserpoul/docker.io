#!/bin/sh

docker build --rm -t vincentserpoul/nginx_build -f Dockerfile_build ./
docker run vincentserpoul/nginx_build cat /rootfs.tar > ./rootfs.tar
docker build --rm -t vincentserpoul/nginx ./
