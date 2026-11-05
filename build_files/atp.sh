#!/bin/bash

set -euox pipefail

CURRENT_BRANCH="Plasma/6.8"
CUR_DIR=/tmp/atp

git clone https://gitgud.io/aeroshell/atp/aerothemeplasma.git $CUR_DIR
cd $CUR_DIR

mkdir -p repos
mkdir -p manifest
cd repos

# uac-polkit-agent
git clone https://gitgud.io/aeroshell/uac-polkit-agent.git
cd uac-polkit-agent
git checkout $CURRENT_BRANCH
build-and-install
cp build/install_manifest.txt "$CUR_DIR/manifest/uac-polkit-agent_install_manifest.txt"
cd "$CUR_DIR/repos"

# SMOD
git clone https://gitgud.io/aeroshell/smod.git
cd smod
git checkout $CURRENT_BRANCH
build-and-install
cp build/install_manifest.txt "$CUR_DIR/manifest/smod_install_manifest.txt"
# cp smodglow/build-wl/install_manifest.txt "$CUR_DIR/manifest/smodglow_install_manifest.txt"
# cp smodglow/build/install_manifest.txt "$CUR_DIR/manifest/smodglow-x11_install_manifest.txt"

# Aeroshell SDDM KCM
git clone https://gitgud.io/aeroshell/aeroshell-sddm-kcm.git
cd aeroshell-sddm-kcm
build-and-install
cp build/install_manifest.txt "$CUR_DIR/manifest/aeroshell-sddm-kcm_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aeroshell Workspace
git clone https://gitgud.io/aeroshell/aeroshell-workspace.git
cd aeroshell-workspace
git checkout $CURRENT_BRANCH
# fix write to /usr/local
sed -i "s/local\///g" mimetype/CMakeLists.txt
build-and-install
update-mime-database /usr/share/mime
cp build/install_manifest.txt "$CUR_DIR/manifest/aeroshell-workspace_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aeroshell KWin
git clone https://gitgud.io/aeroshell/aeroshell-kwin-components.git
cd aeroshell-kwin-components
git checkout $CURRENT_BRANCH
build-and-install -DKWIN_BUILD_WAYLAND=ON
cp build/install_manifest.txt "$CUR_DIR/manifest/aeroshell-kwin-components_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aerothemeplasma icons
git clone https://gitgud.io/aeroshell/atp/aerothemeplasma-icons.git
cd aerothemeplasma-icons
build-and-install
cp build/install_manifest.txt "$CUR_DIR/manifest/icons_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aerothemeplasma sounds
git clone https://gitgud.io/aeroshell/atp/aerothemeplasma-sounds.git
cd aerothemeplasma-sounds
build-and-install
cp build/install_manifest.txt "$CUR_DIR/manifest/sounds_install_manifest.txt"
cd "$CUR_DIR/repos"

# Aerothemeplasma
cd "$CUR_DIR"
build-and-install -DCMAKE_INSTALL_LIBEXECDIR=libexec
cp build/install_manifest.txt "$CUR_DIR/manifest/aerothemeplasma_install_manifest.txt"
cd "$CUR_DIR/repos"

# libplasma last
git clone https://gitgud.io/aeroshell/libplasma.git
cd libplasma
git checkout $CURRENT_BRANCH
build-and-install
cp build/install_manifest.txt "$CUR_DIR/manifest/libplasma_install_manifest.txt"
cd "$CUR_DIR/repos"

rm /usr/share/wayland-sessions/plasma.desktop

sed -i "s/#Current=01-breeze-fedora/Current=sddm-theme-mod/g" /etc/sddm.conf
sed -i "s/#CursorTheme=/CursorTheme=aero-drop/g" /etc/sddm.conf