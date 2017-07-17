# bighorns
Repo for installation, GRASS and GDAL scripts for AZ Bighorns study in collaboration with NMGFD and University of NM Las Cruces

The point of the project is to vertically sample ~60,000 radio collar GPS locations down to their date and hour, by the solar irradiation of the location.

We will [point sample](https://pvanb.wordpress.com/2010/02/15/sampling-raster-values-at-point-locations-in-qgis/) the daily average (global irradiation) for the heat load index of the site, as well as the topographic metrics of each GPS collar location.

|r.sun|Direct Radiation (daily)|Radiation (hourly)|Radiation (monthly)|
|-----|------------------------|------------------|-------------------|
|Units| w m2 | | | |

|Topography|Slope|Aspect|Topographic Position Index|Topographic Wetness Index|Complexity|
|----------|-----|------|--------------------------|-------------------------|----------|
|Units|radians|radians|unitless|ln(slope)/\alpha|?|
