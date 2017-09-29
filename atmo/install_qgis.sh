#!/bin/bash

# Created by: https://github.com/Robinlovelace/install-gis-ubuntu
# Modified for CyVerse Atmosphere by Tyson Swetnam

# Update and Upgrade
sudo apt-get -y update && sudo apt-get -y upgrade

# Install non-gis specific tools
sudo apt-get install -y texlive-extra-utils 
sudo apt-get install -y software-properties-common # to ease adding new ppas
sudo apt-get install -y libudunits2-dev # udunits2

# Install Postgres (for PostGIS)
sudo apt-get install -y postgresql postgresql-contrib

# Add QGIS and GRASS to sources.list
sudo sh -c 'echo "deb http://qgis.org/ubuntugis xenial main" >> /etc/apt/sources.list'  
sudo sh -c 'echo "deb-src http://qgis.org/ubuntugis xenial main" >> /etc/apt/sources.list' 
sudo sh -c 'echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial main" >> /etc/apt/sources.list'

# Add QGIS keys
wget -O - http://qgis.org/downloads/qgis-2017.gpg.key | gpg --import
gpg --fingerprint CAEB3DC3BDF7FB45
gpg --export --armor CAEB3DC3BDF7FB45 | sudo apt-key add -

# Install QGIS w/ Python
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated qgis python-qgis qgis-plugin-grass
