#!/bin/sh

rm -rf horizon-0.1
rm -f horizon_0.1.orig.tar.gz

git ls-tree --name-only master | sed 's/$/ usr\/share\/horizon/' > debian/install

git archive --format=tar.gz --prefix=horizon-0.1/ master > horizon-0.1.tar.gz
ln -s horizon-0.1.tar.gz horizon_0.1.orig.tar.gz

tar zxf horizon-0.1.tar.gz
cp -r debian horizon-0.1

cd horizon-0.1
dpkg-buildpackage
cd ..

docker build -t horizon .
docker run -i -t horizon /bin/bash
