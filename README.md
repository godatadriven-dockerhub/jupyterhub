# JupyterHub in Docker

JupyterHub docker container based on either OpenJDK 8 and Miniconda 3 or only Miniconda 3 in case of the nospark build.

[![](https://images.microbadger.com/badges/image/godatadriven/jupyterhub.svg)](https://microbadger.com/images/godatadriven/jupyterhub "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/godatadriven/jupyterhub.svg)](https://microbadger.com/images/godatadriven/jupyterhub "Get your own version badge on microbadger.com") 

## Running the container
By default jupyterhub is run:

```
docker run -p 8000:8000 godatadriven/jupyterhub 
```

However, to be able to login you need to provide a config accessible through a volume and pass the necessary arguments:

```
docker run -p 8000:8000 -v /local_folder:/config godatadriven/jupyterhub --config /config/jupyterhub_config.py
```