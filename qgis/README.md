# QGIS

In QGIS I used the [Point Sampling Tool](https://plugins.qgis.org/plugins/pointsamplingtool/) to sample geographic features (slope, aspect, elevation) for the ~60,000 observations. 

In order to sample the hourly solar radiation models I wrote a python script (`global_hourly_sample.py`) to loop through the dataset by row and sample each observation for the corresponding hour of each particular day.

To calculate the heat load index I used my [EEMT](https://github.com/cyverse-gis/eemt) program to generate the daily global irradiation of complex terrain, flat surfaces, and hours of sun. I calculated S_i using the BASH script `global_daily_s_i.sh`

To sample the 60,000 observations I wrote a python script to loop through the list `global_daily_s_i_sample.py`

I used the [point sample tool](https://pvanb.wordpress.com/2010/02/15/sampling-raster-values-at-point-locations-in-qgis/) to extract topographic metrics of each site.

# Singularity

I have built the latest version of QGIS 3 in a Singularity container hosted on [SingularityHub](https://www.singularity-hub.org/collections/567)

The QGIS container can be launched using the command:

```
singularity exec --bind /vol_c --bind /scratch shub://tyson-swetnam/osgeo-singularity qgis
```

# Docker

I initially ran these analyses in QGIS 2.18 with Python 2.7. With the release of QGIS 3, the version of Python has also gone to 3.51. To repeat the analyses using the Python2 scripts I've provided, I suggest using a Docker container from [kartoza/qgis-desktop](https://hub.docker.com/r/kartoza/qgis-desktop/):

```
docker run --rm --name="qgis-desktop-2.18" \
	-i -t \
	-v ${HOME}:/home/${USER} \
	-v /vol_c:/vol_c \
	-v /scratch:/scratch \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	kartoza/qgis-desktop:2.18 
```

# Files

**global_hourly_sample.py** This python script loops through a directory of files and samples the rasters by day and hour, outputs are read to an output CSV file.

**global_daily_s_i_sample.py** This python script loops through the same file list and samples the daily S_i values.

**qgis_project.py** This python script loads the base DEM and slope, aspect layers into QGIS. 

# Data

Data from the r.sun.mp are stored on Tyson's CyVerse DataStore. To regenerate the data, see the instructions in the [GRASS](../grass) folder. 

|r.sun|Direct Beam Radiation (daily)|Global Radiation (daily)|Global Radiation (monthly)|Daily hours| Monthly hours|
|-----|-----------------------------|------------------------|--------------------------|-----------|--------------|
|Units| w m<sup>2<sup> | w m<sup>2<sup> | w m<sup>2<sup> | hours | hours |
