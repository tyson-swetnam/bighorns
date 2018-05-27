FROM rocker/verse:latest
MAINTAINER "Tyson Swetnam" tswetnam@cyverse.org

# Original Dockerfile from Rocker/Geospatial
# Added several additional R packages and dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    lbzip2 \
    libcurl4-gnutls-dev \
    libfftw3-dev \
    libgdal-dev \
    libgeos-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libjq-dev \
    liblwgeom-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    libxml2-dev \ 
    build-essential \
    netcdf-bin \
    protobuf-compiler \
    tk-dev \
    unixodbc-dev \
  && install2.r --error \
    PerformanceAnalytics \
    RColorBrewer \
    RandomFields \
    RNetCDF \
    boot \
    classInt \
    deldir \
    devtools \
    dlm \
    dplyr \
    foreign \
    gstat \
    hdf5r \
    lidR \
    lubridate \
    mapdata \
    maptools \
    mapview \
    ncdf4 \
    proj4 \
    raster \
    rgdal \
    rgeos \
    rlas \
    plotly \
    sf \
    sp \
    spacetime \
    spatstat \
    spdep \
    tmap \
    truncreg \
    geoR \
    geosphere \
    ## from bioconductor
    && R -e "BiocInstaller::biocLite('rhdf5')" \
    ## from Github
    && R -e "devtools::install_github('hadley/ggplot2')" \
    && R -e "devtools::install_github('sinhrks/ggfortify')" \
    && R -e "devtools::install_github("easyGgplot2", "kassambara")" 
    

    
