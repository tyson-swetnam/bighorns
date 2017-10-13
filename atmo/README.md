The following scripts install GIS software on an Atmosphere or Jetstream VM 

Log into the Apache Guacamole web shell and right click mouse, select Applications > Education > QGIS Desktop

Right click on desktop and open Terminal Emulator, increase screen resolution:

```
xrandr -s 1920x1200
```

The next step is to use `git` and `clone` this repository to your VM from this Github page

```
#clone the private repository - you will be prompted for your password
git clone https://github.com/tyson-swetnam/bighorns.git

# change directory
cd bighorns/atmo
```

# GRASS

to install GRASS natively (without Singularity container) 

```
. build_grass_quick.sh
```

# QGIS

to install QGIS natively

```
. install_qgis.sh
```
