#!/bin/sh

version=0.1
pwd=$(pwd)

rm -rf horizon-${version}
rm -f horizon_${version}.orig.tar.gz

git archive --format=tar.gz --prefix=horizon-${version}/horizon/ HEAD > horizon-${version}.tar.gz
ln -s horizon-${version}.tar.gz horizon_${version}.orig.tar.gz

tar zxf horizon-${version}.tar.gz
cp -r debian horizon-${version}

cd horizon-${version}
dpkg-buildpackage
cd ..

mkdir -p ${pwd}/deploy/web/tmp
mkdir -p ${pwd}/deploy/app/tmp

cp -f ${pwd}/horizon_${version}-1_amd64.deb ${pwd}/deploy/app/tmp/horizon_amd64.deb
cp -f ${pwd}/horizon_${version}-1_amd64.deb ${pwd}/deploy/web/tmp/horizon_amd64.deb
cp -f ${pwd}/deploy/nginx.conf ${pwd}/deploy/web/tmp/nginx.conf

docker build -t horizon/web deploy/web
docker build -t horizon/app deploy/app
