#!/bin/bash

#post
echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
bison \
build-essential \
ccache \
checkinstall \
cmake \
curl \
ffmpeg2theora \
flex \
g++ \
gcc \
gettext \
ghostscript \
libavcodec-dev \
libavformat-dev \
libav-tools \
libavutil-dev \
libboost-program-options-dev \
libboost-thread-dev \
libcairo2 \
libcairo2-dev \
libffmpegthumbnailer-dev \
libfftw3-3 \
libfftw3-dev \
libfreetype6-dev \
libgcc1 \
libglu1-mesa-dev \
libgsl-dev \
libgtk2.0-dev \
libgtkmm-3.0-dev \
libjasper-dev \
liblas-c-dev \
libncurses5-dev \
libnetcdf-dev \
libperl-dev \
libpng12-dev \
libpnglite-dev \
libpq-dev \
libproj-dev \
libreadline6 \
libreadline6-dev \
libsqlite3-dev \
libswscale-dev \
libtiff5-dev \
libwxbase3.0-dev   \
libwxgtk3.0-dev \
libxmu-dev \
libxmu-dev \
libzmq3-dev \
netcdf-bin \
openjdk-8-jdk \
pkg-config \
proj-bin \
proj-data \
python \
python-dateutil \
python-dev \
python-numpy \
python-opengl \
python-wxgtk3.0 \
python-wxtools \
python-wxversion \
rsync \
sqlite3 \
subversion \
swig \
unzip \
vim \
wget \
wx3.0-headers \
wx-common \
zlib1g-dev \

# Run Makefile
sudo make -f gis_dependency.makefile

echo "Updating library paths"
cd /etc/ld.so.conf.d
echo "/opt/gis/lib" >> gis.conf
echo "/opt/gis/lib64" >> gis.conf
echo "/opt/gis/grass-7.2.2/lib" >> grass.conf
ldconfig

# environment
GISBASE=/opt/gis/grass-7.2.2
GRASS_PROJSHARE=/usr/share/proj
LD_LIBRARY_PATH=/opt/gis/lib:/opt/gis/grass-7.2.2/lib
PATH=/opt/gis/bin:/opt/gis/grass-7.2.2/bin:$PATH
PYTHONPATH=/opt/gis/lib/python2.7/site-packages
export GISBASE GRASS_PROJSHARE LD_LIBRARY_PATH PATH PYTHONPATH

# build info
echo "Timestamp:" `date --utc` | tee /image-build-info.txt

