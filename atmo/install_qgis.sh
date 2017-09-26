#!/bin/bash

# Created by: https://github.com/Robinlovelace/install-gis-ubuntu
# Modified for CyVerse Atmosphere by Tyson Swetnam

# Install non-gis specific tools
sudo apt-get update
sudo apt-get install -y guake # guake for retro bash shell dropdown
sudo apt-get install -y texlive-extra-utils 
sudo apt-get install -y software-properties-common # to ease adding new ppas
sudo apt-get install -y libudunits2-dev # udunits2

# From:  https://medium.com/@ramiroaznar/how-to-install-the-most-common-open-source-gis-applications-on-ubuntu-dbe9d612347b
# Add Ubuntu GIS repos
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

# Install Postgres (for PostGIS)
sudo apt-get install -y postgresql postgresql-contrib

# Add QGIS to sources.list
sudo sh -c 'echo "deb http://qgis.org/debian xenial main" >> /etc/apt/sources.list'  
sudo sh -c 'echo "deb-src http://qgis.org/debian xenial main" >> /etc/apt/sources.list' 
sudo sh -c 'echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial main" >> /etc/apt/sources.list'

# Add QGIS keys
wget -O - http://qgis.org/downloads/qgis-2017.gpg.key | gpg --import
gpg --fingerprint CAEB3DC3BDF7FB45
gpg --export --armor CAEB3DC3BDF7FB45 | sudo apt-key add -

# Install QGIS w/ Python
sudo apt-get install -y --allow-unauthenticated qgis python-qgis 

# Install GRASS-GUI
sudo add-apt-repository ppa:grass/grass-stable
sudo apt-get install -y --allow-unauthenticated grass grass-dev

# In
echo deb https://josm.openstreetmap.de/apt alldist universe | sudo tee /etc/apt/sources.list.d/josm.list > /dev/null
wget -q https://josm.openstreetmap.de/josm-apt.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt install -y josm
sudo apt-get install -y libproj-dev libgeos++-dev

# Detect and install GDAL
FLAV=$(eval echo `lsb_release -c` | rev | cut -d ' ' -f1 | rev) 
if [ $FLAV = "xenial" ]; then
  sudo apt-get install -y gdal-bin libgdal-dev libgdal1-dev 
  else
  sudo apt-get install -y gdal libgdal libgdal1
fi

sudo apt -y autoremove
