#!/bin/sh

pwd=$(pwd)

docker stop app web
docker rm -f app web

docker run -d --name app --env-file=../.env.production horizon/app
docker run -d -p 80:80 -p 443:443 -v ${pwd}/ssl:/etc/nginx/ssl:ro --name web --link app:app horizon/web
