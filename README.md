# Dockerfiles

Docker Imageを作ってGithub Container Registryにひたすらあげるリポジトリ

## CUDA + Python

| CUDA   | Python  | Ubuntu | image name                                                   | cmd                               |
| ------ | ------- | ------ | ------------------------------------------------------------ | --------------------------------- |
| 11.8.0 | 3.11.4  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-server:latest            | `./pull_run.sh -p 3.11`           |
| 11.8.0 | 3.10.10 | 22.04  | ghcr.io/mjun0812/cuda1180-python310-server:latest            | `./pull_run.sh`                   |
| 11.8.0 | 3.10.10 | 20.04  | ghcr.io/mjun0812/cuda1180-python310-ubuntu2004-server:latest | `./pull_run.sh -u 20.04`          |
| 11.7.1 | 3.10.10 | 22.04  | ghcr.io/mjun0812/cuda1171-python310-server:latest            | `./pull_run.sh -c 11.7.1 -p 3.10` |
| 11.6.2 | 3.10.10 | 20.04  | ghcr.io/mjun0812/cuda1162-python310-server:latest            | `./pull_run.sh -c 11.6.2 -p 3.10` |
| 11.3.1 | 3.10.10 | 20.04  | ghcr.io/mjun0812/cuda1131-python310-server:latest            | `./pull_run.sh -c 11.3.1 -p 3.10` |
| 11.3.1 | 3.8.16  | 20.04  | ghcr.io/mjun0812/cuda1131-python38-server:latest             | `./pull_run.sh -c 11.3.1 -p 3.8`  |
| 10.2   | 3.8.16  | 18.04  | ghcr.io/mjun0812/cuda102-python38-server:latest              | `./pull_run.sh -c 10.2 -p 3.8`    |

## PyTorch + ONNX + TensorRT + OpenVINO

- Ubuntu 22.04
- Python 3.11
- CUDA 11.8
- PyTorch 2.0.1
- onnx 1.14.1
- TensorRT 8.6.1.6
    - TensorRT OSS 2023.08
    - onnx-tensorrt release/8.6-GA
    - torch2trt 36656b614f3fbc067ac673932e2200d7afdae712
    - PyTorch-TensorRT 1.4.0
- OpenVINO 2023.0.2

```bash
docker pull ghcr.io/mjun0812/torch-onnx1141-1151-trt861-vino202302-server:latest

# or

.cd torch-onnx-trt-vino
./pull_run.sh
```

## PyTorch + ONNX + TensorRT

- Ubuntu 22.04
- Python 3.11
- CUDA 11.8
- PyTorch 2.0.1
- onnx 1.14.1
- TensorRT 8.6.1.6
    - TensorRT OSS 2023.08
    - onnx-tensorrt release/8.6-GA
    - torch2trt 36656b614f3fbc067ac673932e2200d7afdae712
    - PyTorch-TensorRT 1.4.0

```bash
docker pull ghcr.io/mjun0812/torch-onnx1141-1151-trt861-server:latest

# or

.cd torch-onnx-trt
./pull_run.sh
```
