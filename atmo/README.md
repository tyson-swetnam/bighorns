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

## Install Docker

```
ezd
sudo usermod -aG docker $USER
```

[Rocker's Docker Containers for R](https://journal.r-project.org/archive/2017/RJ-2017-065/RJ-2017-065.pdf)

Here I'm using Rocker's geospatial RStudio-Server image:

```
docker pull rocker/geospatial:latest
```

I'm going to start the container detached `-d` to keep it alive when my terminal window is closed:

```
docker run -d -p 8787:8787 rocker/geospatial:latest
```

## Install Singularity

```
ezs
```

Run Rocker Geospatial Docker in Singularity:

```
singularity run --bind /scratch docker://rocker/geospatial:latest
```

Note: I am using the flag `--bind`` to bind in the VM's directory structure `/scratch` directory. 

Pull Singularity container with QGIS, GRASS, SAGA-GIS

```
singularity pull shub://tyson-swetnam/osgeo-singularity
```

