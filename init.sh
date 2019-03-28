#!/bin/bash

if [ $# -eq 1 ]
        then
                echo "Valid number of arguments provided."
                echo "Your domain is: $1"
        else
                echo "Invalid number of arguments. Please specify a domain!"
                exit 1
fi

DOMAIN=$1

# Initiating setup

echo "******************************"
echo "***** Create directories *****"
echo "******************************"

mkdir -p /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site

echo "******************************"
echo "********* Copy files *********"
echo "******************************"

cp docker-compose.yml /docker/letsencrypt-docker-nginx/src/letsencrypt/docker-compose.yml

cp index.html /docker/letsencrypt-docker-nginx/src/letsencrypt/letsencrypt-site/index.html


cp nginx.conf /docker/letsencrypt-docker-nginx/src/letsencrypt/nginx.conf

echo "Personalizing nginx.conf ....."

sed -i "s,DOMAIN,${DOMAIN},g" /docker/letsencrypt-docker-nginx/src/letsencrypt/nginx.conf

echo "*****************************"
echo "******** Start NGINX ********"
echo "*****************************"

cd /docker/letsencrypt-docker-nginx/src/letsencrypt && docker-compose up -d

echo "Nginx should be starting soon..."
echo "Your IP address is: $(dig +short myip.opendns.com @resolver1.opendns.com)"

