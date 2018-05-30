# QGIS

In QGIS I used the [Point Sampling Tool](https://plugins.qgis.org/plugins/pointsamplingtool/) to sample geographic features (slope, aspect, elevation) for the ~60,000 observations. 

In order to sample the hourly solar radiation models I wrote a python script to loop through the dataset by row and sample each observation for the corresponding hour of each particular day.

To calculate the heat load index I used my [EEMT](https://github.com/cyverse-gis/eemt) program to calculate the daily global irradiation of the sites.

I will [point sample](https://pvanb.wordpress.com/2010/02/15/sampling-raster-values-at-point-locations-in-qgis/)  each GPS collar location for the monthly summed global irradiation and hours of insolation, in addition to calculating the heat index of the site, and topographic metrics

# Files

**csv_read.py** This python script loops through a directory of files and samples the rasters by day and hour, outputs are read to an output CSV file.

**qgis_project.py** This python script loads the base DEM and slope, aspect layers into QGIS. 

# Data

Data from the r.sun.mp are stored on Tyson's CyVerse DataStore. To regenerate the data, see the instructions in the [GRASS](../grass) folder. 

|r.sun|Direct Beam Radiation (daily)|Global Radiation (daily)|Global Radiation (monthly)|Daily hours| Monthly hours|
|-----|-----------------------------|------------------------|--------------------------|-----------|--------------|
|Units| w m<sup>2<sup> | w m<sup>2<sup> | w m<sup>2<sup> | hours | hours |


|Topography|Slope|Aspect|Topographic Position Index|Topographic Wetness Index|Complexity|
|----------|-----|------|--------------------------|-------------------------|----------|
|Units|radians|radians|unitless|$$ln(slope)/\alpha$$|?|
