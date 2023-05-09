# Dockerfiles

Docker Imageを作ってGithub Container Registryにひたすらあげるレポジトリ

## CUDA + Python

| CUDA   | Python  | Ubuntu | image name                                        | cmd                               |
| ------ | ------- | ------ | ------------------------------------------------- | --------------------------------- |
| 11.8.0 | 3.10.10 | 22.04  | ghcr.io/mjun0812/cuda1180-python310-server:latest | `./pull_run.sh`                   |
| 11.7.1 | 3.10.10 | 22.04  | ghcr.io/mjun0812/cuda1171-python310-server:latest | `./pull_run.sh -c 11.7.1 -p 3.10` |
| 11.6.2 | 3.10.10 | 20.04  | ghcr.io/mjun0812/cuda1162-python310-server:latest | `./pull_run.sh -c 11.6.2 -p 3.10` |
| 11.3.1 | 3.10.10 | 20.04  | ghcr.io/mjun0812/cuda1131-python310-server:latest | `./pull_run.sh -c 11.3.1 -p 3.10` |
| 11.3.1 | 3.8.16  | 20.04  | ghcr.io/mjun0812/cuda1131-python38-server:latest  | `./pull_run.sh -c 11.3.1 -p 3.8`  |
| 10.2   | 3.8.16  | 18.04  | ghcr.io/mjun0812/cuda102-python38-server:latest   | `./pull_run.sh -c 10.2 -p 3.8`    |

