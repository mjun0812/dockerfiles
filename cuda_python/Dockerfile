ARG CUDA_VERSION="11.3.1"
ARG UBUNTU="20.04"
ARG CUDNN="8"

# Fromの前後でARGのスコープが変わるので注意
# 上のCUDA_VERSIONはFROMより前に書くこと
FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN}-devel-ubuntu${UBUNTU}

# 環境変数 Versionなど
LABEL maintainer="mjun"
ARG PYTHON
ARG ROOT_PASSWORD
ARG GET_PIP_URL="https://bootstrap.pypa.io/get-pip.py"

# ARG USER_ID
# ARG GROUP_ID
# ARG USER_NAME
# ARG GROUP_NAME

# gitをインストールするときに必要
# tzdataをinstallされてしまうため
ENV DEBIAN_FRONTEND=noninteractive
# ロケールを日本語UTF-8に設定
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ Asia/Tokyo
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1

# ####### SUDO CMD #######

# apt packageのミラー先を日本に変更して高速化
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

# Update Nvidia GPG Key for Ubuntu18.04 image
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

# --no-install-recommends: 依存を最小限にしてinstall
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    # Start Python build dependencies
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    libgl1-mesa-dev \
    # End Python build dependencies
    git \
    zsh \
    locales \
    sudo \
    gosu \
    vim \
    emacs \
    gosu \
    # clean apt-get cache
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    # ロケールを日本語UTF-8に設定
    # これによりDocker環境下で日本語入力が可能となる
    && locale-gen ja_JP.UTF-8

# ctrl + dでコンテナが終了しないようにする
# exit or 10回打てば終了する
RUN echo 'set -o ignoreeof' >> /etc/zsh/zshrc
RUN { \
    echo "export HISTSIZE=10000"; \
    echo "export SAVEHIST=10000"; \
    echo "export LS_OPTIONS='--color=auto'"; \
    echo "alias ls='ls \$LS_OPTIONS'"; \
    echo "autoload -Uz compinit"; \ 
    echo "compinit"; \
    echo "zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'"; \
    echo "zstyle ':completion:*' menu select=2"; \
    } >> /etc/zsh/zshrc

# ####### Install Python #######
RUN wget -q "https://www.python.org/ftp/python/${PYTHON}/Python-${PYTHON}.tar.xz" &&\
    tar xvf Python-${PYTHON}.tar.xz && \
    cd Python-${PYTHON} &&\
    ./configure --without-ensurepip --enable-loadable-sqlite-extensions --enable-shared && \
    make -j 8 &&\
    make install && \
    cd ../ && rm -rf Python-${PYTHON} && \
    python3 -V && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    rm -rf Python-${PYTHON}.tar.xz

# get-pip.pyは3.7以前はスクリプトの場所が変わる
# 3.7>: https://bootstrap.pypa.io/get-pip.py
# 3.6: https://bootstrap.pypa.io/pip/3.6/get-pip.py
RUN curl -kL ${GET_PIP_URL} | python && \
    pip --version &&\
    rm -rf get-pip.py

# ユーザーの作成
# Rootのパス変更
RUN echo "root:root" | chpasswd

# sudo user 作成
# RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} && \
#     useradd -u ${USER_ID} -g ${GROUP_NAME} -G sudo -o -m ${USER_NAME} -s /usr/bin/zsh && \
#     # Userのパス変更
#     echo ${USER_NAME}':'${USER_NAME} | chpasswd

# ####### USER CMD #######
# USER ${USER_NAME}
# WORKDIR /home/${USER_NAME}
# ENV PATH /home/${USER_NAME}/.local/bin:$PATH
# RUN touch /home/${USER_NAME}/.zshrc

# install python package
RUN pip install --no-cache-dir pip wheel

# Tips: 存在が不確定なものをCOPYするときには，1つは存在するものを入れなければならない
COPY Dockerfile pyproject.toml* poetry.lock* requirements.txt* ./

# poetry install
RUN if [ -f pyproject.toml ]; then \
    pip install --no-cache-dir poetry; \
    poetry config virtualenvs.create false; \
    poetry install; \
    fi

# pip install from requirements.txt
RUN if [ -f requirements.txt ]; then \
    pip install --no-cache-dir -r requirements.txt; \
    fi

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
