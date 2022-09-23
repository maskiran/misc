#! /bin/bash

# you can provide all the args that are valid in docker run when starting a new container

NAME=pu
DOCKER_ARGS=$@
# name and hostname can be overwritten from the args
DOCKER_ARGS="--name $NAME --hostname $NAME $DOCKER_ARGS"

if [[ $(docker inspect $NAME -f '{{.State.Status}}' 2> /dev/null) != "running" ]]; then
    echo "Starting a new container"
    docker run -d -t $DOCKER_ARGS u
fi

docker exec -it $NAME zsh