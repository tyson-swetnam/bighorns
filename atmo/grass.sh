#!/bin/bash

# Build GRASS 7.2.2 from source
cd /opt
wget https://grass.osgeo.org/grass72/source/grass-7.2.2.tar.gz
tar xzf grass-7.2.2.tar.gz
cd grass-7.2.2/

# install any additional build dependency packages:
sudo apt-get build-dep grass

# configure to taste..
CFLAGS="-O2 -Wall" LDFLAGS="-s" sudo ./configure \
    --with-openmp \
    --enable-largefile=yes \
    --with-nls \
    --with-cxx \
    --with-proj-share=/usr/share/proj/ \
    --with-geos \
    --with-wxwidgets \
    --with-cairo \
    --with-opengl-libs=/usr/include/GL \
    --with-freetype=yes --with-freetype-includes="/usr/include/freetype2/" \
    --with-postgres=yes --with-postgres-includes="/usr/include/postgresql" \
    --with-sqlite=yes \
    --with-mysql=yes --with-mysql-includes="/usr/include/mysql" \
    --with-odbc=no \
     2>&1 | tee config_log.txt

# build using 4 CPU cores
time sudo make -j 4 2>&1 | tee build_log.txt

sudo make install
