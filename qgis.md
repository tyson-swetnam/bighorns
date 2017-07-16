# Building QGIS on the Atmosphere VM

Configure the QGIS repository, append to `/etc/apt/sources.list`:

```
sudo su
echo "deb http://qgis.org/debian xenial main" >> /etc/apt/sources.list
echo "deb-src http://qgis.org/debian xenial main" >> /etc/apt/sources.list
exit
```

Add authentication keys

```
wget -O - http://qgis.org/downloads/qgis-2016.gpg.key | gpg --import
gpg --fingerprint 073D307A618E5811

gpg --export --armor 073D307A618E5811 | sudo apt-key add -
```

Update with the new repository, and install QGIS, GDAL, and GRASS

```
sudo apt-get update
sudo apt-get install -y qgis python-qgis qgis-plugin-grass
```

Log into the Apache Guacamole web shell and right click mouse, select Education > QGIS Desktop

Right click on desktop and open Terminal Emulator, increase screen resolution:

```
xrandr -s 1920x1200
```
