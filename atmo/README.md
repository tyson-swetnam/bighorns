# Provision a Data Science Workbench on CyVerse

Prerequisites for creating a CyVerse account, and provisioning an Atmosphere instance on CyVerse are hosted on the [CyVerse Learning Center](http://learning.cyverse.org/en/latest/)

[Data Science Workbench Tutorial](https://cyverse-neon-data-institute-2018.readthedocs-hosted.com/en/latest/)

# Instance Creation

I'm using an [Ubuntu 16.04](https://atmo.cyverse.org/application/images/1453) image because of the wide availability of up to date packages. At this time Ubuntu 18.04 doesn't have all of software repositories updated.  

Update OS and reboot

```
sudo apt-get -y update && sudo apt-get -y upgrade

sudo reboot
```
## Download this Github repo

```
git clone https://tyson-swetnam/bighorns

cd bighorns
```

## Install Singularity

```
ezs
```

[Rocker's Docker Containers for R](https://journal.r-project.org/archive/2017/RJ-2017-065/RJ-2017-065.pdf)

### Run Rocker Geospatial Docker with Singularity:

```
singularity exec --bind /scratch --bind /vol_c docker://rocker/geospatial:latest 
```

You can log into RStudio using your CyVerse Atmosphere username and password.

Note: I am using the flag `--bind` to bind in the VM's directory structure `/scratch` directory. 

### Run Singularity container with QGIS, GRASS, SAGA-GIS:

I suggest that you run Singularity from within the Atmosphere Web Desktop. This is because the Web Desktop is faster than X11 remote desktop.

```
singularity exec --bind /scratch shub://tyson-swetnam/osgeo-singularity qgis
```

## Install Docker

```
ezd
sudo usermod -aG docker $USER
```

### Run Rocker Geospatial Docker

```
docker run -v /scratch -v /vol_c -it -d -p 8787:8787 rocker/geospatial
```
Copy the Atmosphere VM's IP address and add the port `:8787` to the end

Open RStudio with the default username `rstudio` and password `rstudio`
