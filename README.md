# Dockerfiles

Docker Imageを作ってGithub Container Registryにひたすらあげるリポジトリ

Repositories that create Docker Images and give them to the Github Container Registry.

## CUDA + Python (`cuda_python`)

- devel: created from `nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}`
- runtime: created from `nvcr.io/nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-runtime-ubuntu${UBUNTU}`

### devel

| CUDA   | Python  | Ubuntu | image name                                                         | cmd                               |
| ------ | ------- | ------ | ------------------------------------------------------------------ | --------------------------------- |
| 12.1.1 | 3.11.5  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-devel-server:latest            | `./pull_run.sh -c 12.1.1 -p 3.11` |
| 11.8.0 | 3.11.5  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-devel-server:latest            | `./pull_run.sh -p 3.11`           |
| 11.8.0 | 3.10.13 | 22.04  | ghcr.io/mjun0812/cuda1180-python310-devel-server:latest            | `./pull_run.sh`                   |
| 11.8.0 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1180-python310-ubuntu2004-devel-server:latest | `./pull_run.sh -u 20.04`          |
| 11.7.1 | 3.10.13 | 22.04  | ghcr.io/mjun0812/cuda1171-python310-devel-server:latest            | `./pull_run.sh -c 11.7.1 -p 3.10` |
| 11.6.2 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1162-python310-devel-server:latest            | `./pull_run.sh -c 11.6.2 -p 3.10` |
| 11.3.1 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1131-python310-devel-server:latest            | `./pull_run.sh -c 11.3.1 -p 3.10` |
| 11.3.1 | 3.8.16  | 20.04  | ghcr.io/mjun0812/cuda1131-python38-devel-server:latest             | `./pull_run.sh -c 11.3.1 -p 3.8`  |
| 10.2   | 3.8.16  | 18.04  | ghcr.io/mjun0812/cuda102-python38-devel-server:latest              | `./pull_run.sh -c 10.2 -p 3.8`    |

### runtime

| CUDA   | Python  | Ubuntu | image name                                                           | cmd                               |
| ------ | ------- | ------ | -------------------------------------------------------------------- | --------------------------------- |
| 12.1.1 | 3.11.5  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-runtime-server:latest            | `./pull_run.sh -c 12.1.1 -p 3.11` |
| 11.8.0 | 3.11.5  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-runtime-server:latest            | `./pull_run.sh -p 3.11`           |
| 11.8.0 | 3.10.13 | 22.04  | ghcr.io/mjun0812/cuda1180-python310-runtime-server:latest            | `./pull_run.sh`                   |
| 11.8.0 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1180-python310-ubuntu2004-runtime-server:latest | `./pull_run.sh -u 20.04`          |
| 11.7.1 | 3.10.13 | 22.04  | ghcr.io/mjun0812/cuda1171-python310-runtime-server:latest            | `./pull_run.sh -c 11.7.1 -p 3.10` |
| 11.6.2 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1162-python310-runtime-server:latest            | `./pull_run.sh -c 11.6.2 -p 3.10` |
| 11.3.1 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1131-python310-runtime-server:latest            | `./pull_run.sh -c 11.3.1 -p 3.10` |
| 11.3.1 | 3.8.16  | 20.04  | ghcr.io/mjun0812/cuda1131-python38-runtime-server:latest             | `./pull_run.sh -c 11.3.1 -p 3.8`  |
| 10.2   | 3.8.16  | 18.04  | ghcr.io/mjun0812/cuda102-python38-runtime-server:latest              | `./pull_run.sh -c 10.2 -p 3.8`    |

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
