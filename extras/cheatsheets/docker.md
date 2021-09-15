# 🐳 Docker Cheat Sheet
*Source: [https://github.com/erangaeb/dotfiles]*


# 💧 Images
### List images
    docker images

### Delete image
    docker rmi <image id> or docker rmi -f <image-id>

### Delete image with tag
    docker rmi <image-name>:<tag>
    docker rmi rabbitmq:0.7

### Delete all images
    docker rmi $(docker images -q)

### Delete dangling images
    docker rmi $(docker images -f dangling=true -q)

### Delete all unused images
    docker rmi $(docker ps -q)
    docker images -q |xargs docker rmi

### Tag image
    docker tag <image-id> <name><tag>
    docker tag c0c21e0808be rabbitmq:0.7

### Compress image
    docker save -o <saving name> <image-name>:<tag>
    docker save -o mq.tar rabbitmq:0.7

### Load compressed image
    docker load -i <saved file>
    docker load -i mq.tar



# 💧 Containers

### Start container
    docker start <container-id>

### Stop container
    docker stop <container-id>

### Stop all containers
    docker stop $(docker ps -a -q)

### Restart container
    docker restart <container-id>

### List running container
    docker ps

### List all containers
    docker ps -a

### Container logs
    docker logs <container-id>

### Tail container logs
    docker logs -f --tail 0 <container-id>
    docker logs -f --tail 0 7d

### Login/connect to container
    docker exec -it <container-id> bash

### Login/connect to container as root user
    docker exec -u 0 -it <container-id> bash

### Delete container
    docker rm <container-id> or docker rm -f <container-id>

### Delete all containers
    docker rm $(docker ps -a -q)

### Delete stopped/exited containers
    docker rm $(docker ps -a | grep Exited | awk '{print $1}')

### Copy files container to host
    docker cp <container-id>:<containers path> <host path>
    docker cp 34fe3333:/opt/docker/lam.txt .

### Find process id of container
    docker inspect -f '{{.State.Pid}}' <container id>


# 💧 Docker logs

### Linux
    /var/log/docker.log

### osx (Inside boot2docker)
    /var/log/docker.log
    /var/log/boot2docker.log

### Container log linux
    /var/lib/docker/containers/<container-id>/<container-id>.log

### Container log osx(Inside boot2docker)
    /var/lib/docker/containers/<container-id>/<container-id>.log

### Remove running contaner log
    truncate -s 0 /var/lib/docker/containers/<containerid>/<containerid>-json.log


# 💧 Volumes

### Delete dangling volumes
    docker volume rm $(docker volume ls -qf dangling=true)