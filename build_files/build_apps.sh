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

git clone --depth 1 https://github.com/actuallyaridan/linux-taskmgr
cd linux-taskmgr

cmake -B build
cmake --build build -j
mv build/taskmgr /usr/bin
mv linux-taskmgr.desktop /usr/share/applications
