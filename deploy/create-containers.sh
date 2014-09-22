# #!/bin/sh

version=0.1
pwd=$(pwd)

mkdir -p ${pwd}/web/tmp
mkdir -p ${pwd}/app/tmp

cp -f ${pwd}/horizon_${version}-1_amd64.deb ${pwd}/app/tmp/horizon_amd64.deb
cp -f ${pwd}/unicorn.rb ${pwd}/app/tmp/unicorn.rb

cp -f ${pwd}/horizon_${version}-1_amd64.deb ${pwd}/web/tmp/horizon_amd64.deb
cp -f ${pwd}/nginx.conf ${pwd}/web/tmp/nginx.conf

docker build -t horizon/web web
docker build -t horizon/app app
