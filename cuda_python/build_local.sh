#!/bin/bash

CUDA_VERSION="11.8.0"
UBUNTU="22.04"
CUDNN="8"
PYTHON="3.11.5"
ROOT_PASSWORD=$USER
USER_NAME=$USER

DESCRIPTION=$(cat <<< "CUDA + Python Docker
同階層にpoetry, requirements.txtを置くと自動でパッケージがインストールされます．

Option:
    -p, --python: python version. default to $PYTHON
    -c, --cuda:   CUDA Version. default to $CUDA_VERSION
    -u, --ubuntu: Ubuntu Version. default to $UBUNTU
    --cudnn:      CUDNN Version. default to $CUDNN
    --root-pass:  SUDO Password in container. default to '$ROOT_PASSWORD' (username)"
)

for OPT in "$@"; do
    case $OPT in
        '-h' | '--help')
            echo "$DESCRIPTION"
            exit 0;
        ;;
        '-p' | '--python')
            PYTHON="$2"
            shift 2
        ;;
        '-c' | '--cuda')
            CUDA_VERSION="$2"
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
        '--root-pass')
            ROOT_PASSWORD="$2"
            shift 2
        ;;
    esac
done

# get-pipは，3.7以前と後でスクリプトの場所が変わる
GET_PIP_URL="https://bootstrap.pypa.io/get-pip.py"
if [[ "$PYTHON" == *3.6* ]]; then
    GET_PIP_URL="https://bootstrap.pypa.io/pip/3.6/get-pip.py"
elif [[ "$PYTHON" == *3.5* ]]; then
    GET_PIP_URL="https://bootstrap.pypa.io/pip/3.5/get-pip.py"
fi

if [[ "$CUDA_VERSION" == 10.* ]]; then
    # 古いCUDAの場合は，nvcr.ioからpullする
    BASE_IMAGE="nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}"
else
    BASE_IMAGE="nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}"
fi

IMAGE_NAME="${USER_NAME}/cuda${CUDA_VERSION//./}-python${PYTHON//./}-server:latest"

docker build \
    --build-arg PYTHON=${PYTHON} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg ROOT_PASSWORD=${ROOT_PASSWORD} \
    --build-arg GET_PIP_URL=${GET_PIP_URL} \
    -t ${IMAGE_NAME} .

