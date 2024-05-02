FROM ubuntu:24.04

ENV N80_VERSION=1.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    binutils \
    build-essential \
    bzip2 \
    git \
    sdcc \
    libicu-dev \
    make \
    pkg-config \
    python3-dev \
    unzip \
    wget 

WORKDIR /downloads
COPY ./docker/install_N80.sh /downloads
RUN chmod 755 /downloads/install_N80.sh
RUN /downloads/install_N80.sh

WORKDIR /workdir
COPY ./buildtools/sources/mknexrom.c /workdir
RUN gcc -o /usr/bin/mknexrom /workdir/mknexrom.c
RUN chmod +x /usr/bin/mknexrom
