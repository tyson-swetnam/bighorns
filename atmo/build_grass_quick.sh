#!/bin/bash

sudo apt-get update && sudo apt-get upgrade

# install build dependency packages:
sudo apt-get build-dep grass

# Install binary PROJ GEOS & GDAL 
sudo apt-get install -y libproj-dev \
	proj-data \
	proj-bin \
	libgeos-dev \
	libgdal-dev \
	python-gdal \
	gdal-bin

wget -nv --no-check-certificate https://grass.osgeo.org/grass72/source/grass-7.2.2.tar.gz \
	 && tar xzf grass-7.2.2.tar.gz \
	 && cd grass-7.2.2 \

# configure to taste..
CFLAGS="-O2 -Wall" LDFLAGS="-s" ./configure \
    --with-openmp \
    --with-python=yes \
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
 NPROC=$(nproc)
 time sudo make -j $NPROC 2>&1 | tee build_log.txt

 sudo make install
