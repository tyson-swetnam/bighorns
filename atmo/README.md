The following scripts install GIS software on an Atmosphere or Jetstream VM 

The first step is to have `git clone` this repository to your VM

```
#clone the private repository - you will be prompted for your password
git clone https://{your-github-name}@github.com/tyson-swetnam/bighorns.git

# change directory
cd bighorns/atmo
```

# GRASS

to install GRASS natively (without a Singularity container) 

```
. build_grass_quick.sh
```

# QGIS

to install QGIS natively

```
. install_qgis.sh
```
