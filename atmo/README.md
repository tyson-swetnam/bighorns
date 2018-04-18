# CyVerse Atmosphere

Creating VMs on Atmosphere is `ez`

Select a featured image with Ubuntu 16

Once the instances is 'active' you can open the web shell to access the command line interface (CLI) or a terminal window and `ssh` into the instance.

```
ssh CyVerseUserID@<IPADDRESS>
```

## `ez` installation of software

We are going to use container technology, i.e. Docker and Singularity, to run our software on the VM.

### Install Jupyter Notebooks (Anaconda) with the R kernel and Python3

```
sudo apt-get update
```

```
ezj
```

Change ownership of the `/opt/anaconda3/` directory

```
sudo chown ${USER}:iplant-everyone /opt/anaconda3 -R
```

#### JupyterLab

Starting Jupyter Lab

```
PUBLIC_IP=$(curl ifconfig.co)
jupyter lab --no-browser --ip=$PUBLIC_IP 2>&1 | sed s/0.0.0.0/$PUBLIC_IP/g
```

### Install Docker

Note: Docker and Docker Compose come pre-installed on Jetstream's [featured Ubuntu](https://use.jetstream-cloud.org/application/images/107) image.

```
ezd
```

#### Run Docker without `sudo`

```
groupadd docker
sudo usermod -aG docker $USER
```
Log out of terminal and log back into the VM

#### Run RStudio-Server

```
docker run -d -p 8787:8787 rocker/geospatial
```

Open a new terminal to the VM, create an SSH tunnel

```
ssh -nNT -L 8787:localhost:8787 $USER@<IPADDRESS OF VM> 
```

Open a new browser tab, and type

```
localhost:8787
```
RStudio username: `rstudio`
RStudio password: `rstudio`
 
### Install Singularity

```
ezs
```

#### Install Singularity container with QGIS, GRASS, and CCTtools Makeflow

I've built a container which has GDAL, GRASS, SAGA-GIS pre-installed, it also has Makeflow and can run the entire r.sun calculation in parallel across additional worker nodes.

SSH into the VM with the `-X` flag to allow X11 remote desktop display.

```
ssh -X $USER@<IPADDRESS OF VM>
```

```
singularity pull --name osgeo-singularity.simg shub://tyson-swetnam/osgeo-singularity

```

Run the container as a CLI

```
singularity shell osgeo-singularity.simg
```

Run the container as a GUI

```
# Open QGIS on your local machine
singularity exec osgeo-singularity.simg qgis
```

```
# Open GRASS on your local machine
singularity exec osgeo-singularity.simg grass74
```

```
# Open SAGA-GIS on your local machine
singularity exec osgeo-singularity.simg saga_gui
```


## Using the Atmosphere Web Desktop

From the Atmosphere or Jetstream page, click the 'Open Web Desktop' or 'Open Web Desktop (Beta)' a new browser tab will open and the web desktop client will launch.

You can use your right-mouse-click to open the programs tab anywhere on the screen.

### Adjust screen resolution

```
xrandr -s 1920x1200
```

where WIDTH and HEIGHT are in pixels, e.g. 1920x1080

### Accessing CyVerse DataStore using `kanki-irodsclient` (Ubuntu 16.04)

From the shell emulator initiate iRODS on the VM using your CyVerse UserID (same as your VM ID) and Password

```
iinit
```

On the Web Desktop double click the 'kanki-irodsclient' icon.


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

