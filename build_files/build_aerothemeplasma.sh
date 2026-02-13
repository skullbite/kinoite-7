#!/bin/bash

set -ouex pipefail

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

dnf install -y ninja qt-devel plasma-workspace-devel unzip kvantum qt6-qtmultimedia-devel qt6-qt5compat-devel libplasma-devel qt6-qtbase-devel qt6-qtwayland-devel plasma-activities-devel kf6-kpackage-devel kf6-kglobalaccel-devel qt6-qtsvg-devel wayland-devel plasma-wayland-protocols kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel kdecoration-devel kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel cmake gmp-ecm-devel kf5-plasma-devel libepoxy-devel kwin-devel kf6-karchive kf6-karchive-devel plasma-wayland-protocols-devel qt6-qtbase-private-devel qt6-qtbase-devel kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel kf6-kdbusaddons-devel kf6-sonnet-devel plasma5support-devel plasma-activities-stats-devel polkit-qt6-1-devel libdrm-devel kf6-kitemmodels-devel kf6-kstatusnotifieritem-devel

CUR=/tmp/atp

git clone --depth 1 https://gitgud.io/wackyideas/aerothemeplasma/ $CUR
cd $CUR

sh compile.sh --ninja --wayland
# plasmoids
for i in "$CUR/plasma/plasmoids/src/"*; do
    cd "$i"
    sh install.sh --ninja
done

cd $CUR

for i in "$CUR/plasma/plasmoids/"*; do
    if ! echo $i | grep src; then
        install_component "$i" "Plasma/Applet"
    fi
done

for i in "$CUR/plasma/plasmoids/src/"*; do
    cd "$i"
    sh install.sh --ninja
done

cd $CUR

# kwin components
cp -r "$CUR/kwin/smod" "/usr/share"

for i in "$CUR/kwin/effects/"*; do
    install_component "$i" "KWin/Effect"
done

for i in "$CUR/kwin/tabbox/"*; do
    install_component "$i" "KWin/WindowSwitcher"
done

cp -r $CUR/kwin/{effects,tabbox,outline,scripts} /usr/share/kwin
cd /usr/share/
ln -s kwin kwin-x11
ln -s kwin kwin-wayland
cd $CUR

# plasma components
cp -r $CUR/plasma/{desktoptheme,look-and-feel,layout-templates,shells} /usr/share/plasma
install_component "$CUR/plasma/look-and-feel/authui7" "Plasma/LookAndFeel"
install_component "$CUR/plasma/layout-templates/io.gitgud.wackyideas.taskbar" "Plasma/LayoutTemplate"
install_component "$CUR/plasma/desktoptheme/Seven-Black" "Plasma/Shell"
install_component "$CUR/plasma/shells/io.gitgud.wackyideas.desktop" "Plasma/Shell"

mkdir -p /usr/share/color-schemes
cp $CUR/plasma/color_scheme/Aero.colors /usr/share/color-schemes

cd $CUR/plasma/sddm/login-sessions
sh install.sh --ninja
cd $CUR/plasma/sddm
cp -r sddm-theme-mod /usr/share/sddm/themes
# tar -zcvf "sddm-theme-mod.tar.gz" sddm-theme-mod
# sddmthemeinstaller -i sddm-theme-mod.tar.gz
#rm sddm-theme-mod.tar.gz

cd $CUR

# misc components
cp -r $CUR/misc/kvantum/Kvantum /usr/share/

cd $CUR/misc/libplasma
# sh install.sh --ninja
# TODO: plasmashell core dumps in build context?
# OUTPUT=$(plasmashell --version)
# IFS=' ' read -a array <<< "$OUTPUT"
VERSION=""

for i in $(rpm -qa | grep plasma-desktop); do
    if [[ $i == *"-doc"* ]]; then
	    echo "Skipping"
	else
	    VERSION=$(echo $i | sed "s/plasma-desktop-//g" | sed "s/-.*//g")
	fi
done

# Polkit agent theme installer. nearly verbatim
URL="https://invent.kde.org/plasma/libplasma/-/archive/v${VERSION}/libplasma-v${VERSION}.tar.gz"
ARCHIVE="libplasma-v${VERSION}.tar.gz"
SRCDIR="libplasma-v${VERSION}"

INSTALLDST="/usr/lib/x86_64-linux-gnu/qt6/qml/org/kde/plasma/core/libcorebindingsplugin.so"
LIBDIR="/usr/lib/x86_64-linux-gnu/"

if [ ! -d ${LIBDIR} ]; then
	LIBDIR="/usr/lib64/"
fi

if [ ! -f ${INSTALLDST} ]; then
	INSTALLDST="/usr/lib64/qt6/qml/org/kde/plasma/core/libcorebindingsplugin.so"
fi

if [ ! -d ./build/${SRCDIR} ]; then
	rm -rf build
	mkdir -p build
	echo "Downloading $ARCHIVE"
	curl $URL -o ./build/$ARCHIVE
	tar -xvf ./build/$ARCHIVE -C ./build/
	echo "Extracted $ARCHIVE"
fi

PWDDIR=$(pwd)
cp -r src ./build/$SRCDIR/
cd ./build/$SRCDIR/
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr .. -G Ninja
cmake --build . --target corebindingsplugin

TMPDIR="/tmp/kplugs"
mkdir -p $TMPDIR
cp ./bin/org/kde/plasma/core/libcorebindingsplugin.so $TMPDIR
for filename in "$PWD/bin/libPlasma"*; do
	echo "Copying $filename to $TMPDIR"
	sudo cp "$filename" "$TMPDIR"
done

cd $PWDDIR

INSTALLDST="/usr/lib/x86_64-linux-gnu/qt6/qml/org/kde/plasma/core/libcorebindingsplugin.so"
LIBDIR="/usr/lib/x86_64-linux-gnu/"

if [ ! -d ${LIBDIR} ]; then
	LIBDIR="/usr/lib64/"
fi

if [ ! -f ${INSTALLDST} ]; then
	INSTALLDST="/usr/lib64/qt6/qml/org/kde/plasma/core/libcorebindingsplugin.so"
fi

cp "$TMPDIR/libcorebindingsplugin.so" $INSTALLDST

for filename in "$TMPDIR/libPlasma"*; do
	echo "Copying $filename to $LIBDIR"
	cp "$filename" "$LIBDIR"
done

cd $CUR/misc/uac-polkitagent
# sh install.sh --ninja
# sh add_rule.sh --ninja

URL="https://invent.kde.org/plasma/polkit-kde-agent-1/-/archive/v${VERSION}/polkit-kde-agent-1-v${VERSION}.tar.gz"
ARCHIVE="polkit-kde-agent-1-v${VERSION}.tar.gz"
SRCDIR="polkit-kde-agent-1-v${VERSION}"

INSTALLDST="/usr/lib/x86_64-linux-gnu/polkit-kde-authentication-agent-1"

if [ ! -f ${INSTALLDST} ]; then
	INSTALLDST="/usr/libexec/kf6/polkit-kde-authentication-agent-1"
fi

if [ ! -f ${INSTALLDST} ]; then
	INSTALLDST="/usr/lib64/polkit-kde-authentication-agent-1"
fi

if [ ! -d ./build/${SRCDIR} ]; then
	rm -rf build
	mkdir build
	echo "Downloading $ARCHIVE"
	curl $URL -o ./build/$ARCHIVE
	tar -xvf ./build/$ARCHIVE -C ./build/
	echo "Extracted $ARCHIVE"
fi

cp -r patches/* ./build/$SRCDIR/
cd ./build/$SRCDIR/
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr .. -G Ninja
cmake --build .
cp ./bin/polkit-kde-authentication-agent-1 $INSTALLDST

RULE_DESC=POLKIT_RULES
CONFIG_DIR=/etc/kwinrulesrc

COUNT=$(kreadconfig6 --file $CONFIG_DIR --group General --key count --default 0)
RULES=$(kreadconfig6 --file $CONFIG_DIR --group General --key rules)
UUID=$(uuidgen)
COUNT=$((COUNT+1))

kwriteconfig6 --file $CONFIG_DIR --group $UUID --key Description $RULE_DESC
kwriteconfig6 --file $CONFIG_DIR --group $UUID --key clientmachine localhost
kwriteconfig6 --file $CONFIG_DIR --group $UUID --key minimizerule 2
kwriteconfig6 --file $CONFIG_DIR --group $UUID --key wmclass "(polkit-kde-authentication-agent-1)|(polkit-kde-manager)|(org.kde.polkit-kde-authentication-agent-1)"
kwriteconfig6 --file $CONFIG_DIR --group $UUID --key wmclassmatch 3

kwriteconfig6 --file $CONFIG_DIR --group General --key count $COUNT
kwriteconfig6 --file $CONFIG_DIR --group General --key rules $RULES,$UUID

cd $CUR

mkdir -p /usr/share/sounds
tar -xf $CUR/misc/sounds/sounds.tar.gz --directory /usr/share/sounds

mkdir -p /usr/share/icons
tar -xf "$CUR/misc/icons/Windows 7 Aero.tar.gz" --directory /usr/share/icons
tar -xf $CUR/misc/cursors/aero-drop.tar.gz --directory /usr/share/icons

mkdir -p /usr/share/mime/packages
for i in "$CUR/misc/mimetype/"*; do
    cp -r "$i" /usr/share/mime/packages
done

update-mime-database /usr/share/mime

cp $CUR/misc/branding/kcminfo.png /usr/share/kin7/logo.png

sed -i "s/Theme=bgrt/Theme=PlymouthVista/g" /usr/share/plymouth/plymouthd.defaults
echo -e "[Theme]\nCurrent=sddm-theme-mod" > /etc/sddm.conf

dnf autoremove -y