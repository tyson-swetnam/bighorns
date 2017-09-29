# CyVerse Atmosphere

Creating VMs on Atmosphere is easy

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
ezj -3
```

Change ownership of the `/home/anaconda3/` directory

```
sudo chown ${USER}:iplant-everyone /home/anaconda3 -R
```

#### Install JupyterLab(Alpha)

```
conda install -c conda-forge jupyterlab
```

Starting Jupyter Lab

```
PUBLIC_IP=$(curl -s https://4.ifcfg.me/)
jupyter lab --no-browser --ip=0.0.0.0 2>&1 | sed s/0.0.0.0/$PUBLIC_IP/g
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

#### Install Docker Compose 

Install Pip

```
sudo wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py 
```

```
sudo pip install docker-compose
```

### Install Singularity

```
ezs
```

#### Install Singularity container with GRASS and CCTtools Makeflow

I've built a container which has GDAL, GRASS, SAGA-GIS pre-installed, it also has Makeflow and can run the entire r.sun calculation in parallel across additional worker nodes.

```
singularity pull shub://tyson-swetnam/eemt-singularity-dev:master
#rename container (shorten name)
mv tyson-swetnam-eemt-singularity-dev-master.img eemt-current.img
```

```
singularity shell eemt-current.img
```


## Using the Atmosphere Web Desktop

From the Atmosphere or Jetstream page, click the 'Open Web Desktop' or 'Open Web Desktop (Beta)' a new browser tab will open and the web desktop client will launch.

You can use your right-mouse-click to open the programs tab anywhere on the screen.

### Adjust screen resolution

```
xrandr -s WIDTHxHEIGHT
```
where WIDTH and HEIGHT are in pixels, e.g. 1920x1080

### Accessing CyVerse DataStore using `kanki-irodsclient` (Ubuntu 16.04)

From the shell emulator initiate iRODS on the VM using your CyVerse UserID (same as your VM ID) and Password

```
iinit
```

On the Web Desktop double click the 'kanki-irodsclient' icon.


