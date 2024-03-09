# Dockerfiles

Docker Image を作って Github Container Registry にひたすらあげるリポジトリ

## CUDA + Python

| CUDA   | Python  | Ubuntu | image name                                                   | cmd                               |
| ------ | ------- | ------ | ------------------------------------------------------------ | --------------------------------- |
| 12.1.1 | 3.11.5  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-server:latest            | `./pull_run.sh -c 12.1.1 -p 3.11` |
| 11.8.0 | 3.11.5  | 22.04  | ghcr.io/mjun0812/cuda1180-python311-server:latest            | `./pull_run.sh -p 3.11`           |
| 11.8.0 | 3.10.13 | 22.04  | ghcr.io/mjun0812/cuda1180-python310-server:latest            | `./pull_run.sh`                   |
| 11.8.0 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1180-python310-ubuntu2004-server:latest | `./pull_run.sh -u 20.04`          |
| 11.7.1 | 3.10.13 | 22.04  | ghcr.io/mjun0812/cuda1171-python310-server:latest            | `./pull_run.sh -c 11.7.1 -p 3.10` |
| 11.6.2 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1162-python310-server:latest            | `./pull_run.sh -c 11.6.2 -p 3.10` |
| 11.3.1 | 3.10.13 | 20.04  | ghcr.io/mjun0812/cuda1131-python310-server:latest            | `./pull_run.sh -c 11.3.1 -p 3.10` |
| 11.3.1 | 3.8.16  | 20.04  | ghcr.io/mjun0812/cuda1131-python38-server:latest             | `./pull_run.sh -c 11.3.1 -p 3.8`  |
| 10.2   | 3.8.16  | 18.04  | ghcr.io/mjun0812/cuda102-python38-server:latest              | `./pull_run.sh -c 10.2 -p 3.8`    |

## PyTorch + ONNX + TensorRT + OpenVINO

- Ubuntu 22.04
- Python 3.10
- CUDA 12.1
- PyTorch 2.2.1
- onnx 1.15.0
- OpenVINO 2024.0.0

```bash
docker pull ghcr.io/mjun0812/torch-onnx1150-1171-trt-vino-server:latest

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
- TensorRT 8.6.3

```bash
docker pull ghcr.io/mjun0812/torch-onnx1150-1171-trt-server:latest

# or

.cd torch-onnx-trt
./pull_run.sh
```
