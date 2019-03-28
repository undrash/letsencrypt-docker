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

# Cleanup staging artifacts

echo "***** Cleaning up staging artifacts ******"

rm -rf /docker-volumes/


echo "****** GENERATING LIVE CERTIFICATES ******"

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
--email andrei@planeeet.com --agree-tos --no-eff-email \
$DOMAIN_ARGS \
&& cd /docker/letsencrypt-docker-nginx/src/letsencrypt \
&& docker-compose down

