# Download a DEM

We used a 50 MB USGS 10 meter DEM for our analysis. 

# GRASS scripts

The `rsun_parallel.py` script creates global and direct radiation raster for each hour of each day of the year that are expected to have sunlight, i.e. 0500-2100 hrs. The existing script is set to run from Julian day 1 to 31.

For early AM and nigh time hours between 2200-0400 solar irradiance is zero, the models are not created. 

The script for sampling the gps coordinates from the `.csv` file is in the QGIS folder.
