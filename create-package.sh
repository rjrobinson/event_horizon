#!/bin/sh

version=0.1

rm -rf horizon-${version}
rm -f horizon_${version}.orig.tar.gz

git archive --format=tar.gz --prefix=horizon-${version}/horizon/ HEAD > horizon-${version}.tar.gz
ln -s horizon-${version}.tar.gz horizon_${version}.orig.tar.gz

tar zxf horizon-${version}.tar.gz
cp -r debian horizon-${version}

cd horizon-${version}
dpkg-buildpackage
cd ..

docker build -t horizon .
docker run -i -t horizon /bin/bash
