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


## Setting up RStudio-Server with the `ezj -R` function on Atmosphere

Recently we set up a `ez` script which is executed in the terminal or web shell to install Anaconda3 with Jupyter Notebook. One of the features is to install R kernel with Jupyter. It also installs `r-essentials` with numerous common R packages.

To set up RStudio-Server with the `conda` installation of R you need to set up the bash profile.

1. Add `anaconda3` to your path

```
export PATH="/home/anaconda3/bin:$PATH"
```

2. Add to your `~/.bash_profile`:

```
sudo sh -c 'echo "export RSTUDIO_WHICH_R="/home/anaconda3/bin/R"" >> ~/.bash_profile'
```

3. Install RStudio-Server using the [latest version](https://www.rstudio.com/products/rstudio/download-server/)

```
sudo apt-get install gdebi-core
```

4. modify `/etc/rstudio/rserver.conf`

```
sudo sh -c 'echo "rsession-which-r=/home/anaconda3/bin/R" >> /etc/rstudio/rserver.conf'
```
5. Install RStudio-Server

```
cd /home
sudo wget https://download2.rstudio.org/rstudio-server-1.0.143-amd64.deb
sudo gdebi -n rstudio-server-1.0.143-amd64.deb
```

Note - this *might* fail on the first try. 
```
user_name@128:/home$ sudo gdebi rstudio-server-1.0.143-amd64.deb
Reading package lists... Done
Building dependency tree
Reading state information... Done
Reading state information... Done

RStudio Server
 RStudio is a set of integrated tools designed to help you be more productive with R. It includes a console, syntax-highlighting editor that supports direct code execution, as well as tools for plotting, history, and workspace management.
Do you want to install the software package? [y/N]:y
(Reading database ... 136874 files and directories currently installed.)
Preparing to unpack rstudio-server-1.0.143-amd64.deb ...
Unpacking rstudio-server (1.0.143) over (1.0.143) ...
Setting up rstudio-server (1.0.143) ...
useradd: user 'rstudio-server' already exists
groupadd: group 'rstudio-server' already exists
rsession: no process found
Created symlink from /etc/systemd/system/multi-user.target.wants/rstudio-server.service to /etc/systemd/system/rstudio-server.service.
Job for rstudio-server.service failed because the control process exited with error code. See "systemctl status rstudio-server.service" and "journalctl -xe" for details.
● rstudio-server.service - RStudio Server
   Loaded: loaded (/etc/systemd/system/rstudio-server.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2017-05-13 09:30:40 MST; 13ms ago
  Process: 2226 ExecStop=/usr/bin/killall -TERM rserver (code=exited, status=1/FAILURE)
  Process: 2233 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited, status=0/SUCCESS)
 Main PID: 2236 (rserver)
    Tasks: 3
   Memory: 824.0K
      CPU: 10ms
   CGroup: /system.slice/rstudio-server.service
           └─2236 /usr/lib/rstudio-server/bin/rserver

May 13 09:30:40 128.196.64.129 systemd[1]: rstudio-server.service: Service hold-off time over, scheduling restart.
May 13 09:30:40 128.196.64.129 systemd[1]: Stopped RStudio Server.
May 13 09:30:40 128.196.64.129 systemd[1]: Starting RStudio Server...
May 13 09:30:40 128.196.64.129 systemd[1]: Started RStudio Server.
May 13 09:30:40 128.196.64.129 rserver[2236]: ERROR Unable to find an installation of R on the system (which R didn't return va...pp:472
May 13 09:30:40 128.196.64.129 systemd[1]: rstudio-server.service: Main process exited, code=exited, status=1/FAILURE
Hint: Some lines were ellipsized, use -l to show in full.
```

6. Restart RStudio-Server

```
rstudio-server start
```

7. There were a couple of issues installing packages for the first time in RStudio

In R:
```
options(repos='http://cran.rstudio.com/')
options(download.file.method = "wget")
```

In terminal:
```
sudo ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3 /usr/lib/libgfortran.so
```
