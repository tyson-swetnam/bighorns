# QGIS

In QGIS I used the [Point Sampling Tool](https://plugins.qgis.org/plugins/pointsamplingtool/) to sample the spatial locations of the ~60,000 sheep observations

To calculate the heat load index I am using my `Sol` distributed computing method as well as a r.sun.hourly scripting.

I will [point sample](https://pvanb.wordpress.com/2010/02/15/sampling-raster-values-at-point-locations-in-qgis/)  each GPS collar location for the monthly summed global irradiation and hours of insolation, in addition to calculating the heat index of the site, and topographic metrics

For the daily/hourly solar models, I am thinking of using the [r.out.xyz](https://grass.osgeo.org/grass72/manuals/r.out.xyz.html) function in a python script.

Essentially, I'll parse the .csv file line by line for its longitude and latitude (X,Y) coordinates, the date and the hour of the GPS collar transmission.

I will then run the r.out.xyz with an $X $Y $DAY $HOUR wildcard to select the location and the appropriate raster to sample from the directory.

The results will be written to an output CSV file.


|r.sun|Direct Radiation (daily)|Global Radiation (daily)|Radiation (hourly)|Radiation (monthly)|
|-----|------------------------|------------------------|------------------|-------------------|
|Units| w m2 | | | | |


|Topography|Slope|Aspect|Topographic Position Index|Topographic Wetness Index|Complexity|
|----------|-----|------|--------------------------|-------------------------|----------|
|Units|radians|radians|unitless|ln(slope)/\alpha|?|
