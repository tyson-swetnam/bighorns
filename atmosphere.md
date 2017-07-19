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
ezj -R -3
```

Change ownership of the `/home/anaconda3/` directory

```
sudo chown ${USER}:iplant-everyone /home/anaconda3 -R
```

Install R-essentials package

```
conda install -c r r-essentials
```

Install JupyterLab(Alpha)

```
conda install -c conda-forge jupyterlab
```

### Install Docker

```
ezd
```

```
groupadd docker
sudo usermod -aG docker $USER
```

Install Docker Compose (with `pip)

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


## Starting Jupyter Lab

```
PUBLIC_IP=$(curl -s https://4.ifcfg.me/)
jupyter lab --no-browser --ip=0.0.0.0 2>&1 | sed s/0.0.0.0/$PUBLIC_IP/g
```

## Using the Web Desktop

### Accessing CyVerse DataStore using `kanki-irodsclient` (Ubuntu 16.04)

```

```
