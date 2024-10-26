# NVIDIA CUDA Docker Container with Python

このリポジトリは機械学習用にCUDAとPythonが使えるDockerコンテナを作るためのものです。
ホストマシンに既にDockerとNVIDIA-Container-Toolkitがインストールされている環境で使ってください。

## 構築可能な環境

- Ubuntu 20.04, 22.04
- Python 3.8--3.12
- CUDA 9--12.4

Pythonは[indygreg/python-build-standalone](https://github.com/indygreg/python-build-standalone)
のビルド済みPythonを使用しています。

UbuntuのバージョンはCUDAのバージョンによって制限されるため，
以下のDocker HubかNGCで提供されている組み合わせを使用してください．

<https://hub.docker.com/r/nvidia/cuda>

<https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda>

## 使い方

### Pull Image and Run

このリポジトリからアップロードしている、ビルド済みのDockerイメージをGitHub Container Registry
から入手可能です。

```bash
./pull_run.sh

# Option Info
./pull_run.sh -h
```

### Local Build and Local Image Run

Docker imageのBuild を`./build.sh`で，コンテナの起動を`./run_local.sh`で行えます．  
optionの確認は`./build.sh -h`，`./run_local.sh -h`で行えます．

## 起動例

`build.sh`と`run_local.sh`では，`-c`と`-u`,`--cudnn`は同じ値を
設定する必要があります．`build.sh`で`-c 11.0.3`にしたら，
`run_local.sh`でも`-c 11.0.3`として下さい．

- CUDA=11.0.3, Python=3.8.10

```bash
./build.sh -p 3.8.10 -c 11.0.3
```

- コンテナ名を変更する

```bash
./run_local.sh --prefix test

cotainer name: mjun-cuda1103-server-test
```
