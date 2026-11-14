#!/bin/bash

# rip snailatte/sevulet, gone but not forgotten
set -euox pipefail

cd /tmp

git clone --depth 1 https://gitgud.io/atmk/libaero-qt.git
cd libaero-qt
build-and-install
cd /tmp

git clone --depths 1 https://gitgud.io/atmk/kitemview.git
cd kitemview
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

cd /tmp

git clone https://gitgud.io/atmk/app-store.git
cd app-store
git checkout flatpak
build-and-install

cd /tmp

git clone https://github.com/ublue-os/yafti-gtk.git
cd yafti-gtk
git checkout f26443c8669edae05b35e20ad16fc74568637874
git apply /ctx/patches/seven-portal-app.patch
git apply /ctx/patches/seven-portal-desktop.patch

cp io.github.ublue_os.yafti_gtk.desktop /usr/share/applications/seven-portal.desktop
cp yafti_gtk.py /usr/share/kin7