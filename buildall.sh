#bin/sh!
for image in $(ls -d **/*);do docker build -t $image ./$image/;done;

# cleanup intermediate images
docker images --no-trunc | grep none | awk '{print $3}' | xargs docker rmi
