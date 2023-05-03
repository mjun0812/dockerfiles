# NVIDIA CUDA Docker Container by mjun

このリポジトリは機械学習用に
CUDA と Python が使えるDockerコンテナを作るためのものです。
ホストマシンに既に Docker > 20.10と 
NVIDIA-Docker2 がインストールされている環境で使ってください。

## 使い方

Docker image の Build を`./build.sh`で，  
コンテナの起動を`./run.sh`で行えます．  
option の確認は`./build.sh -h`，`./run.sh -h`で行えます．

## 構築可能な環境

- Python 3.5--3.10
- CUDA 9--11

Pythonのバージョンは自由に決定できますが，
UbuntuのバージョンはCUDAのバージョンによって制限されるため，
以下のDocker Hubで提供されている組み合わせを使用してください．

<https://hub.docker.com/r/nvidia/cuda>

## 起動例

`build.sh`と`run.sh`では，`-c`と`-u`,`--cudnn`は同じ値を
設定する必要があります．`build.sh`で`-c 11.0.3`にしたら，
`run.sh`でも`-c 11.0.3`として下さい．

- CUDA=11.0.3, Python=3.8.10

```bash
./build.sh -p 3.8.10 -c 11.0.3
```

- CUDA=10.2

```bash
./build.sh -c 10.2
```

- CUDA=9.2

```bash
./build.sh -c 9.2 -u 18.04 -cudnn 7
```

- コンテナ名を変更する

```bash
./exec.sh -v /hoge/path -c 11.0.3 --prefix test

cotainer name: mjun-cuda1103-server-test
```

## Tips

### NVIDIA/CUDA のイメージの更新 2022/04/28

2022/04/28 に，NVIDIA の apt リポジトリの GPG Key が更新された影響で，
古い Image を用いたビルドができなくなっています．
その場合，`docker pull`コマンドでもう一度 Image を取りに行くか，
ローカルの Image を`docker rm`して削除して下さい．

### docker の中で作ったファイルが docker の外で操作出来ない問題

これはdockerコンテナの中では通常root ユーザーで操作を行うため、
作成したファイルの権限が root になってしまうことが原因です。  
なので、本レポジトリでは docker の外と同じユーザーを作成して、
そのユーザーで docker 内にログインするようにしています。  
その代わり、ユーザが docker 内で sudo が使えるようにしています。
パスワードは`$USER`に設定しています。  
なお、この方法を使う場合、Linux の user id と group id を 
docker の外と中で同じにする必要があります。  
詳しくは参考リンクを見てください。

<https://qiita.com/yohm/items/047b2e68d008ebb0f001>

なお、この問題は最近リリースされた rootless-dockerや
mac, windows 版の docker でも発生しません。

### ctrl + d と ctrl + p, q

コンテナを起動したままホストに戻るには、`exec.sh`を実行したあと、
コンテナを detatch(デタッチ, (ctrl + p -> ctrl + q))する必要があります。  
ctrl + d で exit するとコンテナが削除されてしまうので、
事故を防止するためにコンテナ内では ctrl + d を 10 回押さないと 
exit出来ないようにしています．
