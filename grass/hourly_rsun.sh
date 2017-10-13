#!/bin/bash
# Run this script from GRASS72 CLI 

# plot current region settings
r.in.gdal input=${PWD}/dem.tif output=elev

# Set region
g.region raster=elev

# Calculate slope & aspect
r.slope.aspect elevation=elev slope=slp aspect=asp

# Calculate r.sun with openmp
# loop for a month (test)
# loop for daylight hours 5AM to 9PM
for day in {352..366}
  do for hour in {5..21}
     do 
        r.sun.mp --overwrite --verbose elevation=elev aspect=asp slope=slp time=${hour} day=${day} beam_rad=beam_rad_${hour}_day${day} glob_rad=glob_rad_${hour}_day${day} threads=44
        r.out.gdal createopt="COMPRESS=LZW" -c -m --overwrite --verbose input=glob_rad_${hour}_day${day} output=glob_rad_${hour}_day${day}.tif format=GTiff type=Float64
        r.out.gdal createopt="COMPRESS=LZW" -c -m --overwrite --verbose input=beam_rad_${hour}_day${day} output=beam_rad_${hour}_day${day}.tif format=GTiff type=Float64
    done
  done
