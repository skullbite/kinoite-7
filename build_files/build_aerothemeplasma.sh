#!/bin/bash

set -ouex pipefail

mkdir -p /tmp/fake-usr/local
install_component () {
    kpackagetool6 -g -t "$2" -i "$1" || \
    kpackagetool6 -g -t "$2" -u "$1"
}


cd /tmp
git clone --depth 1 https://github.com/mrbvrz/segoe-ui-linux /tmp/segoe
curl -o /usr/share/fonts/lucon.ttf -SsL https://github.com/FSKiller/Microsoft-Fonts/blob/main/lucon.ttf
curl -o /tmp/tv.zip https://www.yohng.com/files/TerminalVector.zip
unzip tv.zip

cp TerminalVector.ttf /usr/share/fonts
cp -r /tmp/segoe/font /usr/share/fonts

fc-cache -f -r -v

dnf install -y ninja plasma-workspace-devel libksysguard-devel unzip kvantum qt6-qtmultimedia-devel qt6-qt5compat-devel libplasma-devel qt6-qtbase-devel qt6-qtwayland-devel plasma-activities-devel kf6-kpackage-devel kf6-kglobalaccel-devel qt6-qtsvg-devel wayland-devel plasma-wayland-protocols kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel kdecoration-devel kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel cmake gmp-ecm-devel kf5-plasma-devel libepoxy-devel kwin-devel kf6-karchive kf6-karchive-devel plasma-wayland-protocols-devel qt6-qtbase-private-devel qt6-qtbase-devel kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel kf6-kdbusaddons-devel kf6-sonnet-devel plasma5support-devel plasma-activities-stats-devel polkit-qt6-1-devel qt-devel libdrm-devel kf6-kitemmodels-devel kf6-kstatusnotifieritem-devel kf6-frameworkintegration-devel

CUR_DIR=/tmp/atp


git clone --depth 1 https://gitgud.io/aeroshell/atp/aerothemeplasma/ $CUR_DIR
cd $CUR_DIR

SU_CMD=
USE_NINJA="-G Ninja"
NINJA_PARAM="--ninja"
LIBEXEC_DIR=libexec


mkdir -p repos
mkdir -p manifest
cd repos

# uac-polkit-agent
git clone https://gitgud.io/aeroshell/uac-polkit-agent.git uac-polkit-agent
cd uac-polkit-agent
git pull
cmake $USE_NINJA -DCMAKE_INSTALL_PREFIX=/usr -B build . || exit 1
cmake --build build || exit 1
$SU_CMD cmake --install build || exit 1
cp build/install_manifest.txt "$CUR_DIR/manifest/uac-polkit-agent_install_manifest.txt"
cd "$CUR_DIR/repos"

# SMOD
git clone https://gitgud.io/aeroshell/smod.git smod
cd smod
git pull
bash install.sh $@
cp build/install_manifest.txt "$CUR_DIR/manifest/smod_install_manifest.txt"
cp smodglow/build-wl/install_manifest.txt "$CUR_DIR/manifest/smodglow_install_manifest.txt"
# cp smodglow/build/install_manifest.txt "$CUR_DIR/manifest/smodglow-x11_install_manifest.txt"

cd "$CUR_DIR/repos"

# Aeroshell Workspace
git clone https://gitgud.io/aeroshell/aeroshell-workspace.git aeroshell-workspace
cd aeroshell-workspace
git pull
# fix write to /usr/local
sed -i "s/local\///g" mimetype/CMakeLists.txt
cat mimetype/CMakeLists.txt
cmake $USE_NINJA -DCMAKE_INSTALL_PREFIX=/usr -B build . || exit 1
cmake --build build || exit 1 
cmake --install build || exit 1
update-mime-database "/usr/share/mime"
cp build/install_manifest.txt "$CUR_DIR/manifest/aeroshell-workspace_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aeroshell KWin
git clone https://gitgud.io/aeroshell/aeroshell-kwin-components.git aeroshell-kwin-components
cd aeroshell-kwin-components
git pull
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -DKWIN_BUILD_WAYLAND=ON -B build . || exit 1
cmake --build build || exit 1
$SU_CMD cmake --install build || exit 1
cp build/install_manifest.txt "$CUR_DIR/manifest/aeroshell-kwin-components_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aerothemeplasma icons
git clone https://gitgud.io/aeroshell/atp/aerothemeplasma-icons aerothemeplasma-icons
cd aerothemeplasma-icons
git pull
cmake $USE_NINJA -DCMAKE_INSTALL_PREFIX=/usr -B build . || exit 1
cmake --build build || exit 1
$SU_CMD cmake --install build || exit 1
cp build/install_manifest.txt "$CUR_DIR/manifest/icons_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aerothemeplasma sounds
git clone https://gitgud.io/aeroshell/atp/aerothemeplasma-sounds aerothemeplasma-sounds
cd aerothemeplasma-sounds
git pull
cmake $USE_NINJA -DCMAKE_INSTALL_PREFIX=/usr -B build . || exit 1
cmake --build build || exit 1
$SU_CMD cmake --install build || exit 1
cp build/install_manifest.txt "$CUR_DIR/manifest/sounds_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aerothemeplasma
cd "$CUR_DIR"
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBEXECDIR=$LIBEXEC_DIR -B build . || exit 1
cmake --build build || exit 1
$SU_CMD cmake --install build || exit 1
cp build/install_manifest.txt "$CUR_DIR/manifest/aerothemeplasma_install_manifest.txt"
cd "$CUR_DIR/repos"

# libplasma last
git clone https://gitgud.io/aeroshell/libplasma.git libplasma
cd libplasma
git pull
cmake $USE_NINJA -DCMAKE_INSTALL_PREFIX=/usr -B build . || exit 1
cmake --build build || exit 1
$SU_CMD cmake --install build || exit 1
cp build/install_manifest.txt "$CUR_DIR/manifest/libplasma_install_manifest.txt"
cd "$CUR_DIR/repos"

echo "Done."

dnf autoremove -y