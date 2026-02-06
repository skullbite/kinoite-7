#!/bin/bash

set -ouex pipefail

install_component () {
    kpackagetool6 -g -t "$2" -i "$1" || \
    kpackagetool6 -g -t "$2" -u "$1"
}

rsync -rvK /ctx/sys/ /

# git clone --depth 1 https://gitgud.io/Gamer95875/Windows-7-Better /usr/share/themes/Windows-7-Better
git clone --depth 1 https://github.com/mrbvrz/segoe-ui-linux /tmp/segoe
curl -o /usr/share/fonts/lucon.ttf -SsL https://github.com/FSKiller/Microsoft-Fonts/blob/main/lucon.ttf

cp -r /tmp/segoe/font /usr/share/fonts

fc-cache -f -r -v

dnf install --skip-broken -y ninja plasma-workspace-devel unzip kvantum qt6-qtmultimedia-devel qt6-qt5compat-devel libplasma-devel qt6-qtbase-devel qt6-qtwayland-devel plasma-activities-devel kf6-kpackage-devel kf6-kglobalaccel-devel qt6-qtsvg-devel wayland-devel plasma-wayland-protocols kf6-ksvg-devel kf6-kcrash-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kio-devel kdecoration-devel kf6-ki18n-devel kf6-knotifications-devel kf6-kirigami-devel kf6-kiconthemes-devel cmake gmp-ecm-devel kf5-plasma-devel libepoxy-devel kwin-devel kf6-karchive kf6-karchive-devel plasma-wayland-protocols-devel qt6-qtbase-private-devel qt6-qtbase-devel kf6-knewstuff-devel kf6-knotifyconfig-devel kf6-attica-devel kf6-krunner-devel kf6-kdbusaddons-devel kf6-sonnet-devel plasma5support-devel plasma-activities-stats-devel polkit-qt6-1-devel qt-devel libdrm-devel kf6-kitemmodels-devel kf6-kstatusnotifieritem-devel qt6-qtmultimedia-devel plymouth-scripts plymouth-plugin-script ImageMagick steam tailscale fastfetch

git clone --depth 1 https://gitgud.io/snailatte/7s-notepad /tmp/7np
cd /tmp/7np
sh build.sh

cp -R ./installation/hicolor /usr/share/icons/
cat ./installation/notepad.desktop | sed "s/~\/.local/\/usr/g" > /usr/share/applications/notepad.desktop
cp -f ./build/notepad /usr/bin

git clone --depth 1 https://gitgud.io/snailatte/7s-photoview /tmp/7pv
cd /tmp/7pv
sh build.sh
cp -r ./installation/hicolor /usr/share/icons/
cp -f ./installation/photoview.desktop /usr/share/applications
cat /usr/share/applications/photoview.desktop | sed "s/\~\/.local/\/usr/g" > /usr/share/applications/photoview.desktop
cp -f ./build/photoview /usr/bin


git clone --depth 1 https://gitgud.io/wackyideas/aerothemeplasma/ /tmp/atp
cd /tmp/atp
CUR="/tmp/atp"

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
    echo "Installing kwin/$i..."
    install_component "$i" "KWin/Effect"
done

for i in "$CUR/kwin/tabbox/"*; do
    install_component "$i" "KWin/WindowSwitcher"
done

cp -r $CUR/kwin/{effects,tabbox,outline,scripts} "/usr/share/kwin"
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

cp $CUR/misc/branding/kcminfo.png /usr/share/fed7/logo.png

sed -i "s/Theme=bgrt/Theme=PlymouthVista/g" /usr/share/plymouth/plymouthd.defaults
sed -i "s/#Current=01-breeze-fedora/Current=sddm-theme-mod/g" /etc/sddm.conf
# TODO: Install script is very much user-level.
git clone https://github.com/furkrn/PlymouthVista /tmp/PlymouthVista
CUR=/tmp/PlymouthVista
cd $CUR
sh compile.sh
 dracut --force --omit plymouth --regenerate-all --verbose
chmod +x PlymouthVista.script

cp $CUR/lucon_disable_anti_aliasing.conf /etc/fonts/conf.d/10-lucon_disable_anti_aliasing.conf
sh gen_blur.sh

cp $CUR/systemd/system/update-plymouth-vista-state-boot.service /etc/systemd/system
cp $CUR/systemd/system/update-plymouth-vista-state-quit.service /etc/systemd/system
cp $CUR/systemd/hibernation/plymouth-vista-hibernate.service /etc/systemd/system
cp $CUR/systemd/hibernation/plymouth-vista-resume-from-hibernation.service /etc/systemd/system

cp $CUR/systemd/user/update-plymouth-vista-state-logon.service /etc/systemd/user


# TODO: Bound this variable to a config value, either thru 7just or system settings
sed "s/\$\(.*\)\"/10\"/g" -i systemd/slowdown/plymouth-vista-slow-boot-animation.service
cat systemd/slowdown/plymouth-vista-slow-boot-animation.service
cp systemd/slowdown/plymouth-vista-slow-boot-animation.service /etc/systemd/system

systemctl enable update-plymouth-vista-state-{boot,quit}.service
systemctl enable plymouth-vista-{hibernate,resume-from-hibernation}.service
systemctl enable plymouth-vista-slow-boot-animation.service
 
cp -r $(pwd) /usr/share/plymouth/themes/PlymouthVista
# chmod +x ./compile.sh
# chmod +x ./install.sh
# ./compile.sh
# ./install.sh -s -q
plymouth-set-default-theme -R PlymouthVista
rm /usr/share/wayland-sessions/plasma.desktop

systemctl enable podman.socket
systemctl enable kvantum-config-write.service

dnf autoremove -y
