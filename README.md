# letsencrypt-docker
Scripts for automating the SSL certificate creation.
###### Dependencies: docker && docker-compose

# FOLLOW THE STEPS BELOW TO GET YOUR CERIFICATES:

## Run the init script with your base domain name (e.g. example.com)
``` ./init.sh example.com ```

## Execute a test run to make sure your configurations are correct (provide all your target domains)
``` ./testrun.sh example.com www.example.com api.example.com blog.example.com ```

## Get information about your certificates using the information script
``` ./information.sh ```

## Insert your own email into the liverun script to get notified if your certificates are about the expire
``` nano liverun.sh - OR - vim liverun.sh ```
\
change this line of code with your own email: 
\
``` --email you@youremail.com --agree-tos --no-eff-email \ ```

## Execute the liverun with all your target domains as arguments
``` ./liverun.sh example.com www.example.com api.example.com blog.example.com ```

## Execute the dhparam script to generate your dhparam.pem
``` ./dhparam ```

## Profit
