ARG CUDNN_VERSION=7
ARG CUDA_VERSION=10.1
# FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04
FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN_VERSION}-devel-ubuntu18.04
# FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu18.04
ARG PYTHON_VERSION=3.8
SHELL ["/bin/bash", "-c"]
# https://techoverflow.net/2019/05/18/how-to-fix-configuring-tzdata-interactive-input-when-building-docker-images/
ENV \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Prague \
    PATH="$PATH:/root/.local/bin" \
    CUDA_TOOLKIT_ROOT_DIR="/usr/local/cuda" \
    MKL_THREADING_LAYER=GNU
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        pkg-config \
        cmake \
        git \
        wget \
        curl \
        unzip \
        ca-certificates \
        software-properties-common \
        libopenmpi-dev \
    && \
# Install python
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-distutils \
        python${PYTHON_VERSION}-dev \
    && \
    update-alternatives --install /usr/bin/python${PYTHON_VERSION%%.*} python${PYTHON_VERSION%%.*} /usr/bin/python${PYTHON_VERSION} 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 1 && \
# Cleaning
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /root/.cache && \
    rm -rf /var/lib/apt/lists/*
# conda init
RUN \
    wget https://bootstrap.pypa.io/get-pip.py --progress=bar:force:noscroll --no-check-certificate && \
    python${PYTHON_VERSION} get-pip.py && \
    rm get-pip.py && \
    pip --version && \
    pip install --ignore-requires-python -v \
    'ray' \
    'ray[tune]' \
    'ray[default]' \
    'pandas' \
    'tabulate' \
    'tensorboardX' && \
    # Show what we have
    pip list

WORKDIR /gridai/project
COPY . .