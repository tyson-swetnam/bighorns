#!/bin/bash

#post
echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

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
