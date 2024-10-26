#!/bin/bash

CUDA_VERSION="11.8.0"
UBUNTU="22.04"
CUDNN="8"
PYTHON="3.11.9"
PYTHON_RELEASE_TAG="20240726"
BASE_IMAGE_FLAVOR="devel"
USER_NAME=$USER

DESCRIPTION=$(cat <<< "CUDA + Python Docker

Option:
    -p, --python: python version. default to $PYTHON
    --tag:        python release tag. default to $PYTHON_RELEASE_TAG
    -c, --cuda:   CUDA Version. default to $CUDA_VERSION
    -u, --ubuntu: Ubuntu Version. default to $UBUNTU
    --cudnn:      CUDNN Version. default to $CUDNN
    --flavor:     Base Image Flavor. (devel, runtime) default to $BASE_IMAGE_FLAVOR"
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
        '--tag')
            PYTHON_RELEASE_TAG="$2"
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
        '--flavor')
            BASE_IMAGE_FLAVOR="$2"
            shift 2
        ;;
    esac
done

version_ge() {
    test "$(printf '%s\n' "$1" "$2" | sort -V | head -n 1)" != "$1"
}

if version_ge "$CUDA_VERSION" "12.4.0"; then
    # CUDA 12.4.0以降はcudnnのversionを含めない
    BASE_IMAGE="nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn-${BASE_IMAGE_FLAVOR}-ubuntu${UBUNTU}"
else
    # CUDA 12.4.0未満はcudnn versionを含める
    BASE_IMAGE="nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-${BASE_IMAGE_FLAVOR}-ubuntu${UBUNTU}"
fi

IMAGE_NAME="${USER_NAME}/cuda${CUDA_VERSION//,/}-python${PYTHON//.}-${BASE_IMAGE_FLAVOR}-server:latest"

docker build \
    --build-arg PYTHON=${PYTHON} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg PYTHON_RELEASE_TAG=${PYTHON_RELEASE_TAG} \
    -t ${IMAGE_NAME} .
