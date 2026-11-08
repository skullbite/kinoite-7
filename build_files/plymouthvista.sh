#!/bin/bash

set -euox pipefail

cd /tmp

git clone https://github.com/furkrn/PlymouthVista.git
cd PlymouthVista

sed -i "s/vista\";/7\";/g" src/plymouth_config.sp
sed -i "s/UseLegacyBootScreen = 1/UseLegacyBootScreen = 0/g" src/plymouth_config.sp
sed -i "s/UseShadow = 0/UseShadow = 1/g" src/plymouth_config.sp
sed -i "s/BootSlowdown = 0/BootSlowdown = 10/g" src/plymouth_config.sp
sed -i "s/Starting Windows/Starting Kinoite/g" src/plymouth_config.sp
sed -i "s/Microsoft Corporation/Fedora Community/g" src/plymouth_config.sp

chmod +x {compile,install,omitPlymouth}.sh
./compile.sh 
./install.sh -s

# ./omitPlymouth.sh
DRACUT_CONF_LOCATION='/etc/dracut.conf.d/omit_plymouth.conf'
DRACUT_CONF='\nomit_dracutmodules+=" plymouth "'

printf "$DRACUT_CONF" > "$DRACUT_CONF_LOCATION"

/usr/bin/dracut --force --regenerate-all --verbose

KERNEL_VERSION=$(ls /lib/modules | grep fc)

/usr/bin/dracut --no-hostonly --kver "${KERNEL_VERSION}" --reproducible -v --add ostree -f "/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"