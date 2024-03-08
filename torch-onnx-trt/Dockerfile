ARG BASE_IMAGE

FROM $BASE_IMAGE

ARG ONNX_TENSORRT_TAG="release/8.6-GA"
ARG ONNX_VERSION="1.14.1"
ARG PYCUDA_VERSION="2024.1"
ARG TENSOR_RT_OSS_VERSION="v9.3.0"
ARG TORCH_TENSORRT_VERSION="2.2.0"
ARG TORCH_VERSION="2.2.1"
ARG TORCHVISION_VERSION="0.17.1"
ARG ONNXRUNTIME_VERSION="v1.17.1"

ENV DEBIAN_FRONTEND=noninteractive
# ロケールを日本語UTF-8に設定
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ Asia/Tokyo
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    locales \
    gosu \
    sudo \
    curl \
    git \
    vim \
    make \
    build-essential \
    ninja-build \
    protobuf-compiler \
    libprotobuf-dev \
    # ロケールを日本語UTF-8に設定
    # これによりDocker環境下で日本語入力が可能となる
    && locale-gen ja_JP.UTF-8 \
    # clean apt-get cache
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

COPY bashrc /etc/bash.bashrc

# exec sudo commannd with no password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install dependencies
RUN pip install \
    onnx==${ONNX_VERSION} \
    pycuda==${PYCUDA_VERSION} \
    cmake \
    packaging \
    && pip install \
    torch==${TORCH_VERSION} \
    torchvision==${TORCHVISION_VERSION} \
    tensorrt \
    --index-url https://download.pytorch.org/whl/cu121

WORKDIR /

# Install onnx-tensorrt
RUN git clone -b ${ONNX_TENSORRT_TAG} --recursive https://github.com/onnx/onnx-tensorrt \
    && cd onnx-tensorrt \
    && mkdir build \
    && cd build \
    && cmake .. -DTENSORRT_ROOT=/usr/src/tensorrt \
    && make -j$(nproc) \
    && make install
ENV PATH /onnx-tensorrt/build:${PATH}
ENV LD_LIBRARY_PATH /onnx-tensorrt/build:$LD_LIBRARY_PATH

# install onnxruntime
# https://onnxruntime.ai/docs/build/eps.html
RUN git clone https://github.com/microsoft/onnxruntime.git -b ${ONNXRUNTIME_VERSION} \
    && cd onnxruntime \
    && ./build.sh --parallel --enable_pybind \
    --compile_no_warning_as_error --allow_running_as_root --config Release --skip_tests \
    --cuda_home /usr/local/cuda --cudnn_home /usr/lib/x86_64-linux-gnu/ \
    --use_tensorrt --tensorrt_home /usr/src/tensorrt --use_tensorrt_oss_parser \
    --build_wheel \
    && pip install /onnxruntime/build/Linux/Release/dist/*.whl \
    && rm -rf /onnxruntime

# clear python cache
RUN rm -rf ~/.cache/pip \
    && rm -rf ~/.cache/pypoetry/artifacts

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
