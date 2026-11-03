#!/bin/bash

set -ouex pipefail

build-and-install() {
    cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr $@ -B build .
    cmake --build build
    cmake --install build
}

export -f build-and-install

cd /ctx

./deps.sh
./fonts-wallpapers.sh
./atp.sh
./extras.sh
./plymouthvista.sh
./os-release.py
./finalize.sh
