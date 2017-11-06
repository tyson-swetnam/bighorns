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

# iCommands Setup 

[CyVerse Tutorial](https://pods.iplantcollaborative.org/wiki/display/DS/Setting+Up+iCommands)

To connect to the CyVerse Data Store from a Jetstream or Atmosphere VM without iCommands installed:

```
wget ftp://ftp.renci.org/pub/irods/releases/4.1.11/ubuntu14/irods-icommands-4.1.11-ubuntu14-x86_64.deb
```

```
dpkg -i irods-icommands-4.1.11-ubuntu14-x86_64.deb
```

Connect to the CyVerse Datastore:

```
{
    "irods_host": "FULLY.QUALIFIED.DOMAIN.NAME",
    "irods_port": 1247,
    "irods_default_resource": "demoResc",
    "irods_home": "/tempZone/home/USERNAME",
    "irods_cwd": "/tempZone/home/USERNAME",
    "irods_user_name": "USERNAME",
    "irods_zone_name": "tempZone",
    "irods_client_server_negotiation": "request_server_negotiation",
    "irods_client_server_policy": "CS_NEG_REFUSE",
    "irods_encryption_key_size": 32,
    "irods_encryption_salt_size": 8,
    "irods_encryption_num_hash_rounds": 16,
    "irods_encryption_algorithm": "AES-256-CBC",
    "irods_default_hash_scheme": "SHA256",
    "irods_match_hash_policy": "compatible"
}


Processing triggers for man-db (2.7.5-1) ...
tswetnam@js-168-124:~/Downloads$ iinit
One or more fields in your iRODS environment file (irods_environment.json) are
missing; please enter them.
Enter the host name (DNS) of the server to connect to: data.cyverse.org
Enter the port number: 1247
Enter your irods user name: tyson_swetnam
Enter your irods zone: iplant
Those values will be added to your environment file (for use by
other iCommands) if the login succeeds.

Enter your current iRODS password:
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
