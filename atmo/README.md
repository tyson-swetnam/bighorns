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

## Install Docker

```
ezd
sudo usermod -aG docker $USER
```
