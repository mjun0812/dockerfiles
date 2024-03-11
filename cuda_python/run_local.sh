#!/bin/bash

CUDA_VERSION="11.8.0"
UBUNTU="22.04"
CUDNN="8"
PYTHON="3.11.5"
CONTAINER_NAME_PREFIX="-$(date '+%s')"
VOLUME="${HOME}/workspace"
USER_ID=`id -u`
GROUP_ID=`id -g`
GROUP_NAME=`id -gn`
USER_NAME=$USER
BASE_IMAGE_FLAVOR="devel"

DESCRIPTION=$(cat <<< "CUDA + Python Docker
同階層にpoetry, requirements.txtを置くと自動でパッケージがインストールされます
Volumeはコンテナ内の~/workspaceにマウントされます

Option:
    -v, --volume: Mount Volume. default is $VOLUME
    -c, --cuda:   CUDA Version. default is $CUDA_VERSION
    -u, --ubuntu: Ubuntu Version. default is $UBUNTU
    --cudnn:      CUDNN Version. default is $CUDNN
    -p, --python: python version. default to $PYTHON
    --flavor:     Base Image Flavor. (devel, runtime) default to $BASE_IMAGE_FLAVOR
    --prefix:     Set Container Name Prefix. Ex.hoge-cuda112-server-[prefix]. default is unixtime.
    -d: Detach(background) run."
)

for OPT in "$@"; do
    case $OPT in
        '-h' | '--help')
            echo "$DESCRIPTION"
            exit 0;
        ;;
        '-c' | '--cuda')
            CUDA_VERSION="$2"
            shift 2
        ;;
        '-p' | '--python')
            PYTHON="$2"
            shift 2
        ;;
        '-u' | '--ubuntu')
            UBUNTU="$2"
            shift 2
        ;;
        '--cudnn')
            CUDNN="$2"
            shift 2
        ;;
        '--flavor')
            BASE_IMAGE_FLAVOR="$2"
            shift 2
        ;;
        '-v' | '--volume')
            VOLUME="$2"
            shift 2
        ;;
        '-d' | '--detach')
            DETACH='-d'
            shift 2
        ;;
        '--prefix')
            CONTAINER_NAME_PREFIX="-$2"
            shift 2
        ;;
    esac
done

IMAGE_NAME="${USER_NAME}/cuda${CUDA_VERSION}-python${PYTHON}-${BASE_IMAGE_FLAVOR}-server:latest"
CONTAINER_NAME="${USER_NAME}-cuda${CUDA_VERSION//./}-python${PYTHON//./}}-${BASE_IMAGE_FLAVOR}-server${CONTAINER_NAME_PREFIX}"

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
    ${@:-zsh}
