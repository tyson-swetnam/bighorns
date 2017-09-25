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
sudo sh -c 'echo "deb-src http://qgis.org/debian xenial main " >> /etc/apt/sources.list'  
wget -O - http://qgis.org/downloads/qgis-2016.gpg.key | gpg --import
gpg --fingerprint 073D307A618E5811
gpg --export --armor 073D307A618E5811 | sudo apt-key add -
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


# install R/RStudio - see
# http://stackoverflow.com/questions/29667330
echo "install a few dependancies for our workflow"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install libgstreamer0.10-0 -y
sudo apt-get install libgstreamer-plugins-base0.10-dev -y
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install libopenblas-base -y
sudo apt-get install libxml2-dev -y
sudo apt-get install make -y
sudo apt-get install gcc -y
sudo apt-get install git -y
sudo apt-get install pandoc -y
sudo apt-get install libjpeg62 -y
sudo apt-get install unzip -y
sudo apt-get install curl -y
sudo apt-get install littler -y
sudo apt-get install openjdk-7-* -y
sudo apt-get install gedit -y
sudo apt-get install jags -y
sudo apt-get install imagemagick -y
sudo apt-get install docker-engine -y
sudo apt-get install libv8-dev -y

echo "edit the sources file to prepare to install R"
# see http://cran.r-project.org/bin/linux/ubuntu/README
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list' 

echo "get keys to install R"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 

echo "install R and some helpers"
sudo apt-get update
sudo apt-get install r-base  -y
sudo apt-get install r-base-dev -y
sudo apt-get install r-cran-xml  -y
sudo apt-get install r-cran-rjava -y
sudo R CMD javareconf # for rJava

echo "install RStudio-Server from the web"

sudo apt-get install -f -y
sudo apt-get install -y gdebi-core
sudo wget https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-server-1.1.339-amd64.deb 
sudo gdebi -n rstudio-server-1.1.339-amd64.deb
# use daily build to get rmarkdown & latest goodies
# http://stackoverflow.com/a/15046782/1036500
# check if 32 or 64 bit and install appropriate version... 
# http://stackoverflow.com/a/106416/1036500
# 
# MACHINE_TYPE=`uname -m`
# if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here

# URL=$(wget -q -O -  https://www.rstudio.org/download/daily/server/ubuntu64/ | grep -o -m 1 "https[^\']*" )

# FILE=`mktemp`; sudo wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE

# else
  # 32-bit stuff here

# URL=$(wget -q -O -  https://www.rstudio.org/download/daily/server/ubuntu32 | grep -o -m 1 "https[^\']*" )

#FILE=`mktemp`; sudo wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
#fi

echo "start R and install commonly used packages"
# http://stackoverflow.com/q/4090169/1036500
# Make an R script file to use in a moment...
LOADSTUFF="options(repos=structure(c(CRAN='http://cran.rstudio.com/')))
update.packages(checkBuilt = TRUE, ask = FALSE)
packages <- c('devtools', # for easy package development and installation from github
              'knitr',    # for dynamic documents
              'roxygen2',  # for installing sf
              'tidyverse' # stack of packages from Hadley Wickham and friends
              )
install.packages(packages)
# some from github
devtools::install_github(c('rstudio/leaflet'))
geopkgs = c(
  'sp',       # spatial data classes and functions
  'rgdal',    # spatial data I/O
  'rgeos',    # spatial manipulation
  'sf',       # newschool spatial data classes + functions
  'tmap',     # powerful and flexible mapping package
  'mapview',  # a quick way to create interactive maps (depends on leaflet)
  'shiny',    # for converting your maps into online applications
  'OpenStreetMap', # for downloading OpenStreetMap tiles
  'rasterVis',# raster visualisation (depends on the raster package)
  'geojsonio',# for reading/writing geojson files
  'rmapshaper', # access to the mapshaper JavaScript library from R
  'stplanr'   # some functions from transport planning
)
install.packages(geopkgs)"

# put that R code into an R script file
FILENAME1="loadstuff.r"
sudo echo "$LOADSTUFF" > /tmp/$FILENAME1

# Make a shell file that contains instructions in bash for running that R script file
# from the command line. There may be a simpler way, but nothing I tried worked.
NEWBASH='#!/usr/bin/env
sudo Rscript /tmp/loadstuff.r'
FILENAME2="loadstuff.sh"

# put that bash code into a shell script file
sudo echo "$NEWBASH" > /tmp/$FILENAME2

# run the bash file to exectute the R code and install the packages
sh /tmp/loadstuff.sh
# clean up by deleting the temp file
rm /tmp/loadstuff.sh
