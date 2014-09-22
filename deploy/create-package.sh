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
