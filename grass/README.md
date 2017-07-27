# GRASS scripts

`rsun_parallel.py` creates a raster for each hour of each day of the year that are expected to have sunlight: 0500-2100 hrs.

For Hours between 2200-0400 solar irradiance is zero. 

`point_sampler.py` runs through the ~60,000 observation point .csv and samples the raster with the same Julian date and time stamp.
