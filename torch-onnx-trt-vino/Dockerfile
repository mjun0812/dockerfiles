ARG PYTHON="311"

FROM ghcr.io/mjun0812/cuda1180-python${PYTHON}-server:latest
LABEL maintainer="mjun"

ARG PYTHON_CP="311"
ARG TENSORRT_FULL_VERSION="8.6.1.6"
ARG TENSORRT_MIDDLE_VERSION="8.6.1"
ARG TENSORRT_OSS_VERSION="23.08"
ARG CUDA_MIDDLE_VERSION="11.8"
ARG TENSORRT_OS="ubuntu2204"
ARG ONNX_TENSORRT_TAG="release/8.6-GA"
ARG ONNX_VERSION="1.14.1"
ARG ONNXRUNTIME_VERSION="1.15.1"
ARG ONNXRUNTIME_CLONE_TAG="ae74a517b62baa6d973e46b5b51ac9a640512c46"
ARG TORCH_TENSORRT_VERSION="1.4.0"
ARG POETRY_VERSION="1.6.1"
ARG OPENVINO_VERSION="2023.0.2"
ARG OPENVINO_OS="ubuntu22"

ENV POETRY_HOME=/opt/poetry
ENV PATH=$POETRY_HOME/bin:$PATH
# OpenVINOはbash推奨なので
SHELL ["/bin/bash", "-c"]

# Check CuDNN Version
# RUN cat /usr/include/cudnn_version.h | grep CUDNN_MAJOR -A 2 -m 1

# install Dependence
RUN apt-get update \
    && apt-get install -y \
    cmake \
    protobuf-compiler \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# pip install
COPY ./poetry.* ./pyproject.toml* ./
RUN curl -sSL https://install.python-poetry.org | POETRY_VERSION=${POETRY_VERSION} python - \
    && poetry config virtualenvs.create false \
    && poetry config installer.max-workers 10 \
    && poetry install --no-interaction --no-ansi \
    && pip install onnx==${ONNX_VERSION} onnxruntime==${ONNXRUNTIME_VERSION}

# ####### Install TensorRT #######

# ### Debian Install ###
# https://docs.nvidia.com/deeplearning/tensorrt/install-guide/index.html#installing-debian
# aptでインストールしたPythonにインストールする場合はこっち
# RUN wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/secure/${TENSORRT_MIDDLE_VERSION}/local_repos/nv-tensorrt-local-repo-${TENSORRT_OS}-${TENSORRT_MIDDLE_VERSION}-cuda-${CUDA_MIDDLE_VERSION}_1.0-1_amd64.deb
# RUN dpkg -i nv-tensorrt-local-repo-${TENSORRT_OS}-${TENSORRT_MIDDLE_VERSION}-cuda-${CUDA_MIDDLE_VERSION}_1.0-1_amd64.deb \
#     && cp /var/nv-tensorrt-local-repo-${TENSORRT_OS}-${TENSORRT_MIDDLE_VERSION}-cuda-${CUDA_MIDDLE_VERSION}/*-keyring.gpg /usr/share/keyrings/ \
#     && apt-get update \
#     && apt-get install -y \
#     tensorrt=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-bin=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-samples=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-plugin8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-plugin-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-headers-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-headers-plugin-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-vc-plugin-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-lean8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-lean-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-dispatch8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-dispatch-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvinfer-vc-plugin8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvparsers8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvparsers-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvonnxparsers8=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     libnvonnxparsers-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     python3-libnvinfer-lean=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     python3-libnvinfer-dev=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     python3-libnvinfer=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     python3-libnvinfer-dispatch=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     uff-converter-tf=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     onnx-graphsurgeon=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     graphsurgeon-tf=${TENSORRT_FULL_VERSION}-1+cuda${CUDA_MIDDLE_VERSION} \
#     && cd /usr/src/tensorrt/samples/trtexec \
#     && make \
#     && apt-get -y clean \
#     && rm -rf /var/lib/apt/lists/* \
#     && rm -rf nv-tensorrt-local-repo-${TENSORRT_OS}-${TENSORRT_FULL_VERSION}-cuda-${CUDA_MIDDLE_VERSION}_1.0-1_amd64.deb
# ENV PATH ${PATH}:/usr/src/tensorrt/bin
# ENV TRT_LIBPATH /usr/lib/x86_64-linux-gnu
# ENV TRT_ROOT /usr/src/tensorrt

# ### TAR file Installation ###
# https://docs.nvidia.com/deeplearning/tensorrt/install-guide/index.html#installing-tar
# 自分でビルドしてインストールしたPythonにインストールする場合はこっち
RUN wget https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/secure/${TENSORRT_MIDDLE_VERSION}/tars/TensorRT-${TENSORRT_FULL_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_MIDDLE_VERSION}.tar.gz
RUN tar -xzvf TensorRT-${TENSORRT_FULL_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_MIDDLE_VERSION}.tar.gz \
    && cd TensorRT-${TENSORRT_FULL_VERSION}/python \
    && pip install tensorrt-*-cp${PYTHON_CP}-none-linux_x86_64.whl\
    && pip install tensorrt_lean-*-cp${PYTHON_CP}-none-linux_x86_64.whl \
    && pip install tensorrt_dispatch-*-cp${PYTHON_CP}-none-linux_x86_64.whl \
    && cd ../uff \
    && pip install uff-*.py3-none-any.whl \
    && cd ../graphsurgeon \
    && pip install graphsurgeon-*-py2.py3-none-any.whl \
    && cd ../onnx_graphsurgeon \
    && pip install onnx_graphsurgeon-*-py2.py3-none-any.whl \
    && rm -rf /TensorRT-${TENSORRT_FULL_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_MIDDLE_VERSION}.tar.gz
ENV TRT_LIBPATH /TensorRT-${TENSORRT_FULL_VERSION}/lib
ENV TRT_ROOT /TensorRT-${TENSORRT_FULL_VERSION}
ENV PATH ${PATH}:/TensorRT-${TENSORRT_FULL_VERSION}/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/TensorRT-${TENSORRT_FULL_VERSION}/lib

# ### Add TensorRT OSS Additional Package ###
ENV TRT_OSSPATH /TensorRT
RUN git clone -b ${TENSORRT_OSS_VERSION} https://github.com/nvidia/TensorRT ${TRT_OSSPATH} \
    && cd ${TRT_OSSPATH} \
    && git submodule update --init --recursive
RUN cd ${TRT_OSSPATH} \
    && mkdir -p build \
    && cd build \
    && cmake .. -DTRT_LIB_DIR=${TRT_LIBPATH} -DTRT_OUT_DIR=`pwd`/out -DCUDA_VERSION=${CUDA_MIDDLE_VERSION} \
    && make -j$(nproc) \
    && make install
ENV LD_LIBRARY_PATH ${TRT_OSSPATH}/build/out:$LD_LIBRARY_PATH

# Install onnx-tensorrt
RUN git clone -b ${ONNX_TENSORRT_TAG} --recursive https://github.com/onnx/onnx-tensorrt \
    && cd onnx-tensorrt \
    && mkdir build \
    && cd build \
    && cmake .. -DTENSORRT_ROOT=${TRT_ROOT} \
    && make -j$(nproc) \
    && make install
ENV PATH ${PATH}:/onnx-tensorrt/build
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/onnx-tensorrt/build

# Install torch2trt
RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt.git \
    && cd torch2trt \
    && git checkout 36656b614f3fbc067ac673932e2200d7afdae712 \
    # https://github.com/NVIDIA-AI-IOT/torch2trt/pull/800
    && sed -i "s/collections.Sequence/Sequence/" torch2trt/converters/interpolate.py \
    && sed -i "s/import collections/from collections.abc import Sequence/" torch2trt/converters/interpolate.py \
    # https://github.com/NVIDIA-AI-IOT/torch2trt/issues/409
    && sed -i "s|/usr/include/aarch64-linux-gnu|/TensorRT-8.6.1.6/include|" setup.py \
    && sed -i "s|/usr/lib/aarch64-linux-gnu|/TensorRT-8.6.1.6/lib|" setup.py \
    && python setup.py install --plugins \
    && cd scripts \
    && bash build_contrib.sh

# Install PyTorch-TensorRT
RUN pip install --no-cache torch-tensorrt==${TORCH_TENSORRT_VERSION}
# ####### End Install TensorRT #######


# ####### Install OpenVINO #######
# Install OpenVINO from build source
# https://github.com/openvinotoolkit/openvino/blob/master/docs/dev/build_linux.md

# Install OpenVINO from Binary
# https://docs.openvino.ai/2023.0/openvino_docs_install_guides_installing_openvino_from_archive_linux.html
RUN wget https://storage.openvinotoolkit.org/repositories/openvino/packages/${OPENVINO_VERSION}/linux/l_openvino_toolkit_${OPENVINO_OS}_${OPENVINO_VERSION}.11065.e662b1a3301_x86_64.tgz -O openvino_${OPENVINO_VERSION}.tgz \
    && mkdir /opt/intel \
    && mkdir openvino_${OPENVINO_VERSION} \
    && tar xzvf openvino_${OPENVINO_VERSION}.tgz -C openvino_${OPENVINO_VERSION} --strip-components 1 \
    && rm -rf openvino_${OPENVINO_VERSION}.tgz \
    && mv openvino_${OPENVINO_VERSION} /opt/intel/ \
    && cd /opt/intel/openvino_${OPENVINO_VERSION} \
    && cd /opt/intel \
    && ln -s openvino_${OPENVINO_VERSION} openvino_$(echo "${OPENVINO_VERSION}" | cut -d'.' -f1) \
    && source /opt/intel/openvino_$(echo "${OPENVINO_VERSION}" | cut -d'.' -f1)/setupvars.sh \
    && echo 'source /opt/intel/openvino_'$(echo "${OPENVINO_VERSION}" | cut -d'.' -f1)'/setupvars.sh' >> /etc/bash.bashrc \
    && pip install 'openvino-dev[extras]'
# For Ubuntu20.04 OpenVINO 2022.03.1
# https://storage.openvinotoolkit.org/repositories/openvino/packages/2022.3.1/linux/l_openvino_toolkit_ubuntu20_2022.3.1.9227.cf2c7da5689_x86_64.tgz
# ####### End Install OpenVINO #######

# install onnxruntime
# https://onnxruntime.ai/docs/build/eps.html
RUN pip uninstall -y onnxruntime
RUN git clone https://github.com/microsoft/onnxruntime.git \
    && cd onnxruntime \
    && git checkout ${ONNXRUNTIME_CLONE_TAG} \
    && git submodule update --recursive
# https://github.com/microsoft/onnxruntime/blob/main/tools/ci_build/build.py
# choices = ["CPU_FP32", "CPU_FP16", "GPU_FP32", "GPU_FP16", "VPUX_FP16", "VPUX_U8"]
RUN cd onnxruntime \
    && source /opt/intel/openvino_$(echo "${OPENVINO_VERSION}" | cut -d'.' -f1)/setupvars.sh \
    && ./build.sh --parallel --enable_pybind \
    --compile_no_warning_as_error --allow_running_as_root --config RelWithDebInfo --skip_tests \
    --cuda_home /usr/local/cuda --cudnn_home /usr/lib/x86_64-linux-gnu/ \
    --use_tensorrt --tensorrt_home ${TRT_ROOT} --use_tensorrt_oss_parser --skip_submodule_sync \
    --use_openvino CPU_FP32 --build_wheel --build_shared_lib
RUN pip install /onnxruntime/build/Linux/RelWithDebInfo/dist/*.whl
RUN echo 'CUDA_MODULE_LOADING=LAZY' >> /etc/bash.bashrc

RUN rm -rf ~/.cache

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
