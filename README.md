# Dockerfiles

Docker Imageを作ってGithub Container Registryにひたすらあげるリポジトリ

Repositories that create Docker Images and give them to the Github Container Registry.

## CUDA + Python (`cuda_python`)

This Docker image includes CUDA and Python and is available for x86_64 platform.

- devel: created from `nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}`
- runtime: created from `nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-runtime-ubuntu${UBUNTU}`

```bash
docker pull ghcr.io/mjun0812/cuda${cuda_version}-python${python_version}-${flavor}-server:latest
```

- **cuda_version**
  - 1222 (12.2.2, Ubuntu22.04)
  - 1211 (12.1.1, Ubuntu22.04)
  - 1180 (11.8.0, Ubuntu22.04)
  - 1171 (11.7.1, Ubuntu22.04)
  - 1162 (11.6.2, Ubuntu20.04)
  - 1131 (11.3.1, Ubuntu20.04)

- **python_version**
  - "312" (3.12.4)
  - "311" (3.11.9)
  - "310" (3.10.14)
  - "39" (3.9.19)
  - "38" (3.8.19)

- **flavor**
  - devel
  - runtime

### example

```bash
docker pull ghcr.io/mjun0812/cuda1211-python311-runtime-server:latest
```

## PyTorch + ONNX + TensorRT (`torch-onnx-trt`)

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

## PyTorch + ONNX + TensorRT + OpenVINO (`torch-onnx-trt-vino`)

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
