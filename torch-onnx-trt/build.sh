#!/bin/bash

source "$(dirname "$0")"/config.sh

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg ONNX_TENSORRT_TAG=${ONNX_TENSORRT_TAG} \
    --build-arg ONNX_VERSION=${ONNX_VERSION} \
    --build-arg ONNXRUNTIME_VERSION=${ONNXRUNTIME_VERSION} \
    --build-arg PYCUDA_VERSION=${PYCUDA_VERSION} \
    --build-arg TENSOR_RT_OSS_VERSION=${TENSOR_RT_OSS_VERSION} \
    --build-arg TORCH_TENSORRT_VERSION=${TORCH_TENSORRT_VERSION} \
    --build-arg TORCH_VERSION=${TORCH_VERSION} \
    --build-arg TORCHVISION_VERSION=${TORCHVISION_VERSION} \
    -t ${IMAGE_NAME} .
