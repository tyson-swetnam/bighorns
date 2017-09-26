#!/bin/bash

# Created by: https://github.com/Robinlovelace/install-gis-ubuntu
# Modified for CyVerse Atmosphere by Tyson Swetnam

# install non-gis specific tools
sudo apt-get install -y guake # guake for retro bash shell dropdown
sudo apt-get install -y texlive-extra-utils 
sudo apt-get install -y software-properties-common # to ease adding new ppas
sudo apt-get install -y libudunits2-dev # udunits2

# from:  https://medium.com/@ramiroaznar/how-to-install-the-most-common-open-source-gis-applications-on-ubuntu-dbe9d612347b
# add repos
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib

# qgis - from http://gis.stackexchange.com/questions/133033/
sudo sh -c 'echo "deb http://qgis.org/debian xenial main" >> /etc/apt/sources.list'  
sudo sh -c 'echo "deb-src http://qgis.org/debian xenial main" >> /etc/apt/sources.list' 
sudo sh -c 'echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial main" >> /etc/apt/sources.list

wget -O - http://qgis.org/downloads/qgis-2017.gpg.key | gpg --import
gpg --fingerprint CAEB3DC3BDF7FB45

gpg --export --armor CAEB3DC3BDF7FB45 | sudo apt-key add -

sudo apt-get update && sudo apt-get install -y --allow-unauthenticated qgis python-qgis  

echo deb https://josm.openstreetmap.de/apt alldist universe | sudo tee /etc/apt/sources.list.d/josm.list > /dev/null
wget -q https://josm.openstreetmap.de/josm-apt.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt install -y josm
sudo apt-get install -y libproj-dev libgeos++-dev

# install gdal
FLAV=$(eval echo `lsb_release -c` | rev | cut -d ' ' -f1 | rev) 
if [ $FLAV = "xenial" ]; then
  sudo apt-get install -y gdal-bin libgdal-dev libgdal1-dev 
  else
  sudo apt-get install -y gdal libgdal libgdal1
fi
