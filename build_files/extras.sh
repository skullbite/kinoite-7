#!/bin/bash

# rip snailatte/sevulet, gone but not forgotten
set -euox pipefail

cd /tmp

git clone --depth 1 https://gitgud.io/atmk/libaero-qt.git
cd libaero-qt
build-and-install
cd /tmp

git clone --depth 1 https://gitgud.io/atmk/gwenview-aero.git
cd gwenview-aero
build-and-install
cd /tmp

git clone --depth 1 https://gitgud.io/atmk/dolphin-aero.git
cd dolphin-aero
build-and-install
cd /tmp

git clone --depth 1 https://gitgud.io/wackyideas/linver.git
mkdir -p linver/build
cd linver/build
qmake6 ../linver.pro
make
make install
cd /tmp


git clone --depth 1 https://github.com/actuallyaridan/linux-taskmgr.git
cd linux-taskmgr
build-and-install

cd /tmp 

git clone --depth 1 https://gitgud.io/aeroshell/aeroshell-gadgets.git
cd aeroshell-gadgets
build-and-install