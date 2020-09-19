![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/zaggash/docker-autoupdate?label=build&logo=docker&style=for-the-badge)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/zaggash/docker-autoupdate?logo=docker&sort=date&style=for-the-badge)
![MicroBadger Layers](https://img.shields.io/microbadger/layers/zaggash/docker-autoupdate?logo=docker&style=for-the-badge)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/zaggash/docker-autoupdate?label=size&logo=docker&style=for-the-badge)
![Docker Pulls](https://img.shields.io/docker/pulls/zaggash/docker-autoupdate?label=pulls&logo=docker&style=for-the-badge)

## docker-autoupdater

This Docker image is used to autoupdate swarm services on regular basis.  
It is useful for any personnal setup to avoid manual intervention.  

### Usage locally:  


```
docker run -e TZ='UTC' -v /var/run/docker.sock:/var/run/docker.sock zaggash/docker-autoupdater
```

Where:  
```
-v /var/run/docker.sock:/var/run/docker.sock    | Bind mount the local docker socket to the container.
-e TZ="UTC"                                     | Used to set the TimeZone
```

