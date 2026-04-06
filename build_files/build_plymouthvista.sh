#!/bin/bash

set -exuo pipefail

compile_kernel () {
    /usr/bin/dracut --no-hostonly --kver "${KERNEL_VERSION}" --reproducible -v --add ostree -f "/lib/modules/${KERNEL_VERSION}/initramfs.img"
    chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"
}

installSystemdServices() {
    local serviceInstallDirectory=$1
    local asUserService=$2

    if [[ ! -d $serviceInstallDirectory ]]; then
        echo "$serviceDirectory does not exist, ignoring it."
        return
    fi

    installDir="/etc/systemd/system" 

    cp $serviceInstallDirectory/* $installDir

    for f in $serviceInstallDirectory/*.service; do
        serviceName=$(basename $f)
        systemctl enable $serviceName
    done
}


# fix dracut looking for the wrong kernel to rebuild
KERNEL_VERSION=$(ls /lib/modules | grep ba)

dnf install -y plymouth plymouth-scripts plymouth-plugin-script ImageMagick
cd /tmp
git clone https://github.com/furkrn/PlymouthVista
cd PlymouthVista

sed -i "s/vista\";/7\";/g" src/plymouth_config.sp
sed -i "s/UseLegacyBootScreen = 1/UseLegacyBootScreen = 0/g" src/plymouth_config.sp
sed -i "s/UseShadow = 0/UseShadow = 1/g" src/plymouth_config.sp
sed -i "s/BootSlowdown = 0/BootSlowdown = 10/g" src/plymouth_config.sp
sed -i "s/Starting Windows/Starting Kinoite/g" src/plymouth_config.sp
sed -i "s/Microsoft Corporation/Fedora Community/g" src/plymouth_config.sp
sh compile.sh 


USER_SYSTEMD_SERVICES="$(pwd)/systemd/user"
SYSTEM_SYSTEMD_SERVICES="$(pwd)/systemd/system"
HIBERNATE_SYSTEMD_SERVICES="$(pwd)/systemd/hibernation"
SLOWDOWN_SYSTEMD_SERVICES="$(pwd)/systemd/slowdown"
NO_WALL_SYSTEMD_SERVICES="$(pwd)/systemd/no-wall"
INSTALL_DIR="/usr/share/plymouth/themes/PlymouthVista"


chmod 777 $INSTALL_DIR/PlymouthVista.script
echo "Installing fade services..."
installSystemdServices "$SYSTEM_SYSTEMD_SERVICES" 0
installSystemdServices "$USER_SYSTEMD_SERVICES" 1

chmod 777 $INSTALL_DIR/PlymouthVista.script
echo "Installing hibernation services..."
installSystemdServices "$HIBERNATE_SYSTEMD_SERVICES" 0

if [[ $(./pv_conf.sh -g BootTime) != 0 ]]; then
    echo "Installing boot slow down systemd services..."
    installSystemdServices "$SLOWDOWN_SYSTEMD_SERVICES" 0
fi
if [[ $(./pv_conf.sh -g DisableWall) == 1 ]]; then
    echo "Installing no wall services..."
    installSystemdServices "$NO_WALL_SYSTEMD_SERVICES" 0
else
    echo "Uninstall no wall services if they are still present..."
    tryUninstallSystemdServices "$NO_WALL_SYSTEMD_SERVICES" 0
    fi

export DRACUT_NO_XATTR=1
compile_kernel
# sh omitPlymouth.sh
# compile_kernel
