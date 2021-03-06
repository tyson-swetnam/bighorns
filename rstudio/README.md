# RStudio-Server

I am running a Docker container for RStudio-Server which is supported by the [Rocker Group](https://hub.docker.com/r/rocker/geospatial/)

[Guide: Rocker's Docker Containers for R](https://journal.r-project.org/archive/2017/RJ-2017-065/RJ-2017-065.pdf)

### Docker Rocker/Geospatial

After you've installed Docker, pull the container:

```
docker pull tswetnam/bighorns
```

Run the container detached with extra volumes:

```
docker run   \
  -d \  
  -v ${HOME}:/home/${USER}   \
  -v /scratch:/scratch   \
  -v /vol_b:/vol_b   \
  -it -p 8787:8787   \
  tswetnam/bighorns:latest
```

Copy the Atmosphere VM's IP address into the browser and add the port `:8787` 

Open RStudio with the Rocker default username `rstudio` and password `rstudio`

### Rocker/Geospatial (Docker) with Singularity:

```
singularity exec --bind /scratch --bind /vol_c docker://rocker/geospatial:latest 
```

I have also created another container with the added dependencies and hosted it on this Rep

```
singularity exec --bind /scratch --bind /vol_c docker://tswetnam/bighorns:latest
```

Log into RStudio using your CyVerse Atmosphere username and password.

**Note:** I am using the flag `--bind` to bind in the VM's directory structure `/scratch` directory. 
