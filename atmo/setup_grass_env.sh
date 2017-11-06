#!/bin/bash

# Setup GRASS Environment
WORKING_DIR=/tmp
LOCATION=$HOME/Documents/tmp_${WORKING_DIR}/PERMANENT
GRASSRC=$HOME/.grassrc72_${WORKING_DIR}
export GISRC=${GRASSRC}
export GRASS_VERBOSE=0

echo "GISDBASE: $HOME/grass_data" >> $GRASSRC
echo "LOCATION_NAME: tmp_${WORKING_DIR}" >> $GRASSRC
echo "MAPSET: PERMANENT" >> $GRASSRC
echo "GRASS_GUI: text" >> $GRASSRC

# Create a mapset
grass72 -c epsg:4269 ${PWD}/mytmp -e

# Run GRASS72
grass72 ${PWD}/mytmp/PERMANENT
