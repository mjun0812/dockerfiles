ARG BASE_IMAGE
# Fromの前後でARGのスコープが変わるので注意
# 上のARGはFROMより前に書くこと
FROM $BASE_IMAGE
LABEL maintainer="mjun"

ARG PYTHON="3.11"

ENV DEBIAN_FRONTEND=noninteractive \
    # ロケールを日本語UTF-8に設定
    LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo" \
    # 標準出力・標準エラーのストリームのバッファリングを行わない
    PYTHONUNBUFFERED=1 \
    # .pycファイルを生成しない
    PYTHONDONTWRITEBYTECODE=1

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
    jq \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# ロケールを日本語UTF-8に設定
# これによりDocker環境下で日本語入力が可能となる
RUN locale-gen ja_JP.UTF-8 \
    && update-locale LANG=ja_JP.UTF-8

# exec sudo commannd with no password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# ####### Install Python #######
RUN URL=$(curl -sSL https://api.github.com/repos/astral-sh/python-build-standalone/releases/latest | jq -r '.. | .browser_download_url? // empty'| grep ${PYTHON} | grep 'cpython-.*x86_64-unknown-linux-gnu-install_only.tar.gz$') \
    && echo $URL > hoge\
    && curl -L $URL -o python.tar.gz \
    && tar xvf python.tar.gz -C /usr/local \
    && rm -f python.tar.gz
ENV PATH="/usr/local/python/bin:$PATH" \
    LD_LIBRARY_PATH="/usr/local/python/lib:$LD_LIBRARY_PATH"

COPY zshrc /etc/zsh/zshrc
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
