#!/bin/bash

# rip snailatte/sevulet, gone but not forgotten

set -exuo pipefail

dnf install -y kf6-kio cmake ninja kf6-kio-devel kf6-kparts-devel kf6-baloo-devel kf6-kcoreaddons-devel libjpeg-turbo-devel exiv2-devel lcms2-devel kimageannotator-qt6-devel libkdcraw-devel kcolorpicker-qt6-devel patchelf

cd /tmp

git clone --depth 1 https://gitgud.io/atmk/libaero-qt
cd libaero-qt

mkdir build
cd build
cmake .. -D CMAKE_INSTALL_PREFIX=/usr
make
make install

cd /tmp

git clone --depth 1 https://gitgud.io/atmk/gwenview-aero
cd gwenview-aero

cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -B build .
cmake --build build
cmake --install build

cd /tmp

git clone --depth 1 https://gitgud.io/atmk/dolphin-aero
cd dolphin-aero

cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -B build .
cmake --build build
cmake --install build

git clone --depth 1 https://gitgud.io/wackyideas/linver
cd linver

mkdir -p build
cd ./build/
qmake6 ../linver.pro
make
make install

# cd /tmp

curl -o /usr/bin/run-7 https://github.com/jayrickaby/run-7/releases/download/v0.6.0/run-7
chmod +x /usr/bin/run-7

