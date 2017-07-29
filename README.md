# bighorns
Repo for virtual machine set up, software installation, and GRASS and GDAL scripts for AZ Bighorns study in collaboration with NMGFD and University of NM (Las Cruces).

The intent of the project is to vertically sample ~60,000 radio collar GPS locations down to their date and hour, by the solar irradiation of the location across an entire year (~5,800 rasters). We also want to calculate heat load of the surface to infer a daily temperature for the site.

We will [point sample](https://pvanb.wordpress.com/2010/02/15/sampling-raster-values-at-point-locations-in-qgis/) the daily average (global irradiation) for the heat index of the site, as well as the topographic metrics of each GPS collar location.

For the daily/hourly solar models, I am thinking of using the [r.out.xyz](https://grass.osgeo.org/grass72/manuals/r.out.xyz.html) function in a python script

Essentially, I'll parse the .csv file line by line for its longitude and latitude (X,Y) coordinates, the date and the hour of the GPS collar transmission.

I will then run the r.out.xyz with an $X $Y $DAY $HOUR wildcard to select the location and the appropriate raster to sample from the directory.

The results will be written to an output CSV file.


|r.sun|Direct Radiation (daily)|Radiation (hourly)|Radiation (monthly)|
|-----|------------------------|------------------|-------------------|
|Units| w m2 | | | |

|Topography|Slope|Aspect|Topographic Position Index|Topographic Wetness Index|Complexity|
|----------|-----|------|--------------------------|-------------------------|----------|
|Units|radians|radians|unitless|ln(slope)/\alpha|?|
