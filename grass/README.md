# GRASS scripts

The `rsun_parallel.py` script creates global and direct radiation raster for each hour of each day of the year that are expected to have sunlight, i.e. 0500-2100 hrs.

For Hours between 2200-0400 solar irradiance is zero. 

The `point_sampler.py` loops through the ~60,000 GPS observations (.csv) using the Julian date and time stamp to select latitude and longitude. With the date and time to select an individual raster, the code then point samples each GPS lat and long for the radiation values, and the topographic values.
