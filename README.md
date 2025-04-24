# Dockerfiles

Docker Imageを作ってGithub Container Registryにひたすらあげるリポジトリ

This repository provides Docker images and publishes them to the GitHub Container Registry.

## CUDA + Python (`cuda_python`)

This Docker image is including CUDA and Python at x86_64 platform.

- devel: created from `nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}`
- runtime: created from `nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-runtime-ubuntu${UBUNTU}`

```bash
docker pull ghcr.io/mjun0812/cuda${cuda_short_version}-python${python_short_version}-${flavor}:latest

# example
docker pull ghcr.io/mjun0812/cuda12.4-python3.11-devel:latest
docker pull ghcr.io/mjun0812/cuda12.1-python3.11-runtime:latest
```

- **cuda_short_version**
  - 12.8 (12.8.1, Ubuntu24.04)
  - 12.4 (12.4.1, Ubuntu22.04)
  - 12.1 (12.1.1, Ubuntu22.04)
  - 11.8 (11.8.0, Ubuntu22.04)
  - 11.3 (11.3.1, Ubuntu20.04)

- **python_short_version**
  - 3.12
  - 3.11
  - 3.10

- **flavor**
  - devel (including all cuda lib (ex. nvcc), but large image.)
  - runtime (light volume image, but including only cuda runtime)
 
### script

```bash
cd cuda_python

# Local build
./build.sh -c 12.8.1 -p 3.13
./run_local.sh -v 12.8.1 -p 3.13

# Pull ghcr.io
./pull_run.sh -v 12.8.1 -p 3.13
```

## (no longer maintenance) PyTorch + ONNX + TensorRT (`torch-onnx-trt`)

Base Image: `nvcr.io/nvidia/tensorrt:23.12-py3`

- Ubuntu 22.04
- CUDA 12.1
- Python 3.10
- PyTorch 2.2.1
- onnx 1.15.0
- onnxruntime 1.17.1
- TensorRT 8.6.3

```bash
docker pull ghcr.io/mjun0812/torch-onnx1150-1171-trt-server:latest

# or

cd torch-onnx-trt
./pull_run.sh
```

## (no longer maintenance) PyTorch + ONNX + TensorRT + OpenVINO (`torch-onnx-trt-vino`)

Base Image: `nvcr.io/nvidia/tensorrt:23.12-py3`

- Ubuntu 22.04
- CUDA 12.1
- Python 3.10
- PyTorch 2.2.1
- onnx 1.15.0
- onnxruntime 1.17.1
- TensorRT 8.6.3
- OpenVINO 2023.3.0

```bash
docker pull ghcr.io/mjun0812/torch-onnx1150-1171-trt-vino-server:latest

# or

cd torch-onnx-trt-vino
./pull_run.sh
```
