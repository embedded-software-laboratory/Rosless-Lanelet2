# The ubuntu distro to use
ARG DISTRIBUTION=24.04
FROM ubuntu:${DISTRIBUTION} AS lanelet2_deps

# If true, build docker container for development
ARG DEV=0

SHELL ["/bin/bash", "-c"]

# basics
RUN set -ex; \
    export PY_VERSION=python3; \
    if [ "$DEV" -ne "0" ]; then \
        export DEV_PACKAGES="clang-format clang-tidy clang i${PY_VERSION} nano lcov"; \
    fi; \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        bash-completion \
        build-essential \
        curl \
        git \
        cmake \
        keyboard-configuration \
        locales \
        lib${PY_VERSION}-dev \
        software-properties-common \
        sudo \
        wget \
        ${DEV_PACKAGES} && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEV=${DEV}

# dependencies for lanelet2
# libgeographic-dev on ubuntu 22.04 and older
RUN export PY_VERSION=python3; \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libgtest-dev \
        libboost-all-dev \
        libeigen3-dev \
        libgeographiclib-dev \
        libpugixml-dev \
        libboost-python-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# create a user
RUN useradd --create-home --groups sudo --shell /bin/bash developer && \
    mkdir -p /etc/sudoers.d && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer


# environment, dependencies and entry points
USER developer
ENV HOME=/home/developer
WORKDIR /home/developer/workspace

# setup workspace, add dependencies
RUN set -ex; \
    cd /home/developer/workspace && \
    mkdir -p /home/developer/workspace/src

# second stage: get the code
FROM lanelet2_deps AS lanelet2_src

# bring in the code
COPY --chown=developer:developer . /home/developer/workspace/

# third stage: build
FROM lanelet2_src AS lanelet2

# build
RUN  mkdir -p build && cd build
WORKDIR /home/developer/workspace/build

RUN set -ex; \
    if [ "$DEV" -ne "0" ]; then \
      export CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Debug"; \
    else \
      export CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Release"; \
    fi; \
    cmake .. $CMAKE_ARGS && cmake --build . && \
    if [ "$DEV" -ne "0" ]; then \
      rm -rf build logs; \
    else \
      sudo cmake --build . --target install; \
    fi