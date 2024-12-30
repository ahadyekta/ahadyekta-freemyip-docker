# freemyip dockerfile
docker image to update dynamic dns freemyip frequently.

## build dockerfile
``` docker build -t freemyip-docker-image .```

## run docker image
first make your subdomain in freemyip.com and get token

``` docker run -d --name freemyip -e TOKEN="TOKEN" -e DOMAIN="subdomain.freemyip.com" freemyip-docker-image ```