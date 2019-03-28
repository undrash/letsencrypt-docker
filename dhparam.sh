#!/bin/bash

echo "******** Generating dhparam *********"

mkdir -p /docker-volumes/dh-param/

openssl dhparam -out /docker-volumes/dh-param/dhparam-2048.pem 2048 \
&& echo "*****************************************" \
&& echo "Can be found in /docker-volumes/dh-param/" \
&& echo "*****************************************"

