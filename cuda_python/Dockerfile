ARG BASE_IMAGE
# Fromの前後でARGのスコープが変わるので注意
# 上のARGはFROMより前に書くこと
FROM $BASE_IMAGE
LABEL maintainer="mjun"

ARG PYTHON="3.11.9"
ARG PYTHON_RELEASE_TAG="20240726"

ENV DEBIAN_FRONTEND=noninteractive
# ロケールを日本語UTF-8に設定
ENV LANG="ja_JP.UTF-8"
ENV LANGUAGE="ja_JP:ja"
ENV LC_ALL="ja_JP.UTF-8"
ENV TZ="Asia/Tokyo"
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1
# .pycファイルを生成しない
ENV PYTHONDONTWRITEBYTECODE=1

# apt packageのミラー先を日本に変更して高速化
# RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

# --no-install-recommends: 依存を最小限にしてinstall
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    libgl1-mesa-dev \
    git \
    zsh \
    locales \
    sudo \
    gosu \
    vim \
    emacs \
    gosu \
    ninja-build \
    ca-certificates \
    zstd \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# ロケールを日本語UTF-8に設定
# これによりDocker環境下で日本語入力が可能となる
RUN locale-gen ja_JP.UTF-8 \
    && update-locale LANG=ja_JP.UTF-8

# exec sudo commannd with no password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# ####### Install Python #######
RUN curl -L "https://github.com/indygreg/python-build-standalone/releases/download/${PYTHON_RELEASE_TAG}/cpython-${PYTHON}+${PYTHON_RELEASE_TAG}-x86_64-unknown-linux-gnu-install_only.tar.gz" -o python.tar.gz \
    && tar xvf python.tar.gz -C /usr/local \
    && rm -f python.tar.gz
ENV PATH="/usr/local/python/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/python/lib:$LD_LIBRARY_PATH"

# install python package
RUN pip install -U pip wheel setuptools && rm -rf /root/.cache/pip

COPY zshrc /etc/zsh/zshrc
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
