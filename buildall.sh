#bin/sh!

docker build -t vincentserpoul/nginx_builder vincentserpoul/nginx_builder
docker run vincentserpoul/nginx_builder cat /rootfs.tar > vincentserpoul/nginx/rootfs.tar

docker build -t vincentserpoul/phpfpm_builder vincentserpoul/phpfpm_builder
docker run vincentserpoul/phpfpm_builder cat /rootfs.tar > vincentserpoul/phpfpm/rootfs.tar

for image in hhvm nginx percona phpfpm;do docker build -t vincentserpoul/$image ./vincentserpoul/$image/;done;

# cleanup intermediate images
docker images --no-trunc | grep none | awk '{print $3}' | xargs docker rmi
