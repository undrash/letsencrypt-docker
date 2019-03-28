#!/bin/bash

if [ $# -gt 0 ]
	then
		echo "Valid number of arguments provided."
		echo "Your domains are: $@"
	else
		echo "Invalid number of arguments. Please specify at least one domain!"
		exit 1
fi

DOMAIN_ARGS=""

for DOMAIN in $@; do
	DOMAIN_ARGS="$DOMAIN_ARGS -d $DOMAIN"
done

# RUN docker container and get certificate

docker run -it --rm \
-v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
-v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
-v /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site:/data/letsencrypt \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot \
certonly --webroot \
--webroot-path=/data/letsencrypt \
--installer nginx \
--register-unsafely-without-email --agree-tos \
--staging \
$DOMAIN_ARGS

