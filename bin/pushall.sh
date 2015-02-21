#bin/sh!
for image in $(ls -d **/*);do docker push $image;done;
