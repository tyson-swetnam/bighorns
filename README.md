# Contents

## Authors

Tyson Lee Swetnam <sup>1</sup>*, Jay Gedir <sup>2</sup>

<sup>1</sup> BIO5 Institute, University of Arizona, Tucson AZ

<sup>2</sup> New Mexico State University, Las Cruces NM

\* Corresponding Author: tswetnam \<at> cyverse \<dot> org

AZ Bighorns study in collaboration with NMGFD and New Mexico State University (NMSU), Las Cruces NM.

The intent is to vertically sample the solar irradiation of locations across an entire year (~5,800 rasters), using ~60,000 radio collar GPS locations, by the date and hour. We calculate heat load of the surface to infer a local air temperature for the sites at the time of the GPS ping. Sheep locations are compared to an equal number of random locations to establish whether their patterns of movement are driven by topographic complexity. 

Why are the sheep are selecting a location in time: elevation, slope, aspect, temperature, local shading?

# Repository roadmap

## atmo

Scripts for launching CyVerse [Atmosphere](https://atmo.cyverse.org) cloud, with software installation instructions.

## grass

Scripts run in GRASS CLI

## qgis

Scripts run in QGIS

## rstudio

RStudio Server .RMD files

## Dockerfile

I have ported the [Rocker/Geospatial](https://hub.docker.com/r/rocker/geospatial/) Dockerfile from DockerHub and added a few more libraries to run our analyses in RStudio-Server.

```
docker pull tswetnam/bighorns
```

```
docker run 
```

## acknowledgements

