#!/bin/bash

set -exuo pipefail

# fix dracut looking for the wrong kernel to rebuild
KERNEL_VERSION=$(ls /lib/modules | grep fc)

dnf install -y plymouth plymouth-scripts plymouth-plugin-script ImageMagick
cd /tmp
git clone https://github.com/furkrn/PlymouthVista
cd PlymouthVista

sed -i "s/vista\";/7\";/g" src/plymouth_config.sp
sh compile.sh 
sh install.sh -s

export DRACUT_NO_XATTR=1
/usr/bin/dracut --no-hostonly --kver "${FEDORA_KERNEL}" --reproducible -v --add ostree -f "/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"
