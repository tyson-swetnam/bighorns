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

# iRODS iCommands Setup 

We are storing some data on the CyVerse DataStore

In order to access the DataStore from a non-Atmosphere VM, you need to install iRODS iCommands.

[iRODS](https://irods.org/)

Ubuntu Linux Installation instructions:

```
wget -qO - https://packages.irods.org/irods-signing-key.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/renci-irods.list
sudo apt-get update

sudo apt-get install irods-icommands
```

Connect to the CyVerse Datastore:

```
Processing triggers for man-db (2.7.5-1) ...
tswetnam@js-168-124:~/Downloads$ iinit
One or more fields in your iRODS environment file (irods_environment.json) are
missing; please enter them.
Enter the host name (DNS) of the server to connect to: data.cyverse.org
Enter the port number: 1247
Enter your irods user name: $USER
Enter your irods zone: iplant
Those values will be added to your environment file (for use by
other iCommands) if the login succeeds.

Enter your current iRODS password:
```

# Install Singularity

On an Atmo VM, there is an `ez` command for installing the latest version of Singularity:

```
ezs
```

Pull Tyson's OSGEO Singularity container from Singularity Hub

```
singularity pull --name osgeo.simg shub://tyson-swetnam/osgeo-singularity
```

Run QGIS graphically

```
singularity exec osgeo.simg qgis
```

Run GRASS 7.4 graphically

```
singularity exec osgeo.simg grass74
```

Run CLI

```
singularity shell osgeo.simg
```

# Install Docker

```
ezd
```

```
sudo usermod -aG docker $USER
```

```
docker run -d -p 8787:8787 rocker/geospatial
```

