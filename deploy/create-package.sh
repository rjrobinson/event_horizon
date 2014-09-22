# #!/bin/sh

version=0.1
pwd=$(pwd)

rm -rf horizon-${version}
rm -f horizon_${version}.orig.tar.gz

cd ..
git archive --format=tar.gz --prefix=horizon-${version}/horizon/ HEAD > deploy/horizon-${version}.tar.gz
cd deploy
ln -s horizon-${version}.tar.gz horizon_${version}.orig.tar.gz

tar zxf horizon-${version}.tar.gz
cp -r debian horizon-${version}

cd horizon-${version}
dpkg-buildpackage
cd ..

mkdir -p ${pwd}/web/tmp
mkdir -p ${pwd}/app/tmp

cp -f ${pwd}/horizon_${version}-1_amd64.deb ${pwd}/app/tmp/horizon_amd64.deb
cp -f ${pwd}/unicorn.rb ${pwd}/app/tmp/unicorn.rb

cp -f ${pwd}/horizon_${version}-1_amd64.deb ${pwd}/web/tmp/horizon_amd64.deb
cp -f ${pwd}/nginx.conf ${pwd}/web/tmp/nginx.conf

docker build -t horizon/web web
docker build -t horizon/app app
