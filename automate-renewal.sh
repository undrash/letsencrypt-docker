#!/bin/bash

echo "****** Writing to crontab ******"

(crontab -l ; echo "0 23 * * * docker run --rm -it --name certbot \
-v "/docker-volumes/etc/letsencrypt:/etc/letsencrypt" \
-v "/docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt" \
-v "/docker-volumes/data/letsencrypt:/data/letsencrypt" \
-v "/docker-volumes/var/log/letsencrypt:/var/log/letsencrypt" \
certbot/certbot renew --webroot \
-w /data/letsencrypt --quiet") | crontab - \
&& echo "SUCCESS! Renewal will be attempted every day at 23:00"

