#!/bin/bash
 
# Calculates S_i (Rasmussen et al. 2015) from the Daily radiation outputs.

# In Atmosphere VM:
# sudo singularity shell --bind /vol_c /vol_c/eemt-current
# apt-get install python-gdal

for ((i=1;i<=366;i++)); 
do
    echo -e "Calculating S_i for day $i"
    gdal_calc.py -A "/vol_c/work/global/daily/total_sun_day_$i.tif" -B "/vol_c/work/global/daily/flat_total_sun_day_$i.tif" --outfile="/vol_c/s_i/s_i_day_$i.tif" --calc="A/B"
done
