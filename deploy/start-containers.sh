#!/bin/sh

docker stop app web
docker rm -f app web

docker run -d --name app --env-file=../.env.production horizon/app
docker run -d -P --name web --link app:app horizon/web
