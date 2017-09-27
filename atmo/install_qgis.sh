#!/bin/bash

# Created by: https://github.com/Robinlovelace/install-gis-ubuntu
# Modified for CyVerse Atmosphere by Tyson Swetnam

# Update and Upgrade
sudo apt-get update && sudo apt-get upgrade

# Install non-gis specific tools
sudo apt-get install -y texlive-extra-utils 
sudo apt-get install -y software-properties-common # to ease adding new ppas
sudo apt-get install -y libudunits2-dev # udunits2

# From:  https://medium.com/@ramiroaznar/how-to-install-the-most-common-open-source-gis-applications-on-ubuntu-dbe9d612347b
# Add Ubuntu GIS repos
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

# GRASS Dependencies
sudo apt-get install -y \
  build-essential \
  flex make bison gcc libgcc1 g++ cmake ccache \
  python python-dev \
  python-opengl \
  python-wxversion python-wxtools python-wxgtk3.0 \
  python-dateutil libgsl-dev python-numpy \
  python-gdal gdal-bin \
  wx3.0-headers wx-common libwxgtk3.0-dev \
  libwxbase3.0-dev   \
  libncurses5-dev \
  zlib1g-dev gettext \
  libtiff5-dev libpnglite-dev \
  libcairo2 libcairo2-dev \
  sqlite3 libsqlite3-dev \
  libpq-dev \
  libreadline6 libreadline6-dev libfreetype6-dev \
  libfftw3-3 libfftw3-dev \
  libboost-thread-dev libboost-program-options-dev liblas-c-dev \
  resolvconf \
  libjasper-dev \
  subversion \
  libav-tools libavutil-dev ffmpeg2theora \
  libffmpegthumbnailer-dev \
  libavcodec-dev \
  libxmu-dev \
  libavformat-dev libswscale-dev \
  libproj-dev proj-data proj-bin \
  libgeos-dev libgeos++-dev \
  libgdal-dev libgdal1-dev \
  gdal libgdal libgdal1 \
  netcdf-bin libnetcdf-dev \
  checkinstall \
  libglu1-mesa-dev libxmu-dev \
  ghostscript

# Install Postgres (for PostGIS)
sudo apt-get install -y postgresql postgresql-contrib

# Install OpenStreetMap
echo deb https://josm.openstreetmap.de/apt alldist universe | sudo tee /etc/apt/sources.list.d/josm.list > /dev/null
wget -q https://josm.openstreetmap.de/josm-apt.key -O- | sudo apt-key add -
sudo apt install -y josm

# Add QGIS and GRASS to sources.list
sudo sh -c 'echo "deb http://qgis.org/debian xenial main" >> /etc/apt/sources.list'  
sudo sh -c 'echo "deb-src http://qgis.org/debian xenial main" >> /etc/apt/sources.list' 
sudo sh -c 'echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial main" >> /etc/apt/sources.list'

# Add QGIS keys
wget -O - http://qgis.org/downloads/qgis-2017.gpg.key | gpg --import
gpg --fingerprint CAEB3DC3BDF7FB45
gpg --export --armor CAEB3DC3BDF7FB45 | sudo apt-key add -

# Install QGIS w/ Python
sudo apt-get install -y --allow-unauthenticated qgis python-qgis 

# Build GRASS 7.2.2 from source
cd /opt
wget https://grass.osgeo.org/grass72/source/grass-7.2.2.tar.gz
tar xzf grass-7.2.2.tar.gz
cd grass-7.2.2/

# install any additional build dependency packages:
sudo apt-get build-dep grass

# configure to taste..
CFLAGS="-O2 -Wall" LDFLAGS="-s" ./configure \
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
time make -j 4 2>&1 | tee build_log.txt

sudo make install
