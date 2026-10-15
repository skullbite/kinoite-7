#!/bin/bash

set -exuo pipefail

dnf install -y cmake ninja qt6-qtbase-devel qt6-qtbase kf6-kunitconversion-devel kf6-kholidays-devel extra-cmake-modules qt6-qtdeclarative-devel kf6-ktextwidgets-devel kf6-kio-devel

CUR=/tmp/win-gadgets
git clone --depth 1 https://gitgud.io/aeroshell/aeroshell-gadgets $CUR
cd $CUR

cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -B build .
cmake --build build
cmake --install build
