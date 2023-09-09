#!/bin/bash

ONNX_VERSION="1.14.1"
ONNXRUNTIME_VERSION="1.15.1"
TENSORRT_MIDDLE_VERSION="8.6.1"

USER_ID=`id -u`
GROUP_ID=`id -g`
GROUP_NAME=`id -gn`
USER_NAME=$USER

VOLUME="${HOME}/workspace"
CONTAINER_NAME_PREFIX="-$(date '+%s')"

CMD=$@

IMAGE_NAME="${USER_NAME}/torch-onnx${ONNX_VERSION//./}-${ONNXRUNTIME_VERSION//./}-trt${TENSORRT_MIDDLE_VERSION//./}-server:latest"

CONTAINER_NAME="${USER_NAME}-torch-onnx${ONNX_VERSION//./}-${ONNXRUNTIME_VERSION//./}-trt${TENSORRT_MIDDLE_VERSION//./}-server${CONTAINER_NAME_PREFIX}"

if type nvcc > /dev/null 2>&1; then
    # Use GPU
    docker run \
        -it \
        --rm \
        $DETACH \
        --gpus all \
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
        "${CMD:-bash}"
else
    # CPU
    docker run \
        -it \
        --rm \
        $DETACH \
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
        "${CMD:-bash}"
fi
