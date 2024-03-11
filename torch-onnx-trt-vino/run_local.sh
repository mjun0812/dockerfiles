#!/bin/bash

source "$(dirname "$0")"/config.sh

VOLUME="${HOME}/workspace"

GPU_OPTION=""
if type nvcc > /dev/null 2>&1; then
    # Use GPU
    GPU_OPTION="--gpus all"
fi

docker run \
    -it \
    --rm \
    $DETACH \
    $GPU_OPTION \
    --net host \
    --ulimit memlock=-1 \
    --shm-size=128g \
    --env DISPLAY=$DISPLAY \
    --env USER_NAME=$USER_NAME \
    --env USER_ID=$USER_ID \
    --env GROUP_NAME=$GROUP_NAME \
    --env GROUP_ID=$GROUP_ID \
    --workdir $HOME \
    --volume $HOME/.Xauthority:$HOME/.Xauthority:rw \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume $HOME/.cache:$HOME/.cache \
    --volume $VOLUME:$HOME/workspace \
    --name "${CONTAINER_NAME}" \
    "${IMAGE_NAME}" \
    ${@:-bash}
