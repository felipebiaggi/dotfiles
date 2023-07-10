#!/bin/bash

set -e

apt-get -y install \
    git \
    neovim \
    cmake \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    python3 \
    cargo \
    curl && \
    apt autoremove -y


cargo install alacritty

