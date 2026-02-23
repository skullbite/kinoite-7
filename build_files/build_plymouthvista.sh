#!/bin/bash

set -exuo pipefail

# fix dracut looking for the wrong kernel to rebuild
FEDORA_KERNEL=$(ls /lib/modules | grep fc)

dnf install -y plymouth plymouth-scripts plymouth-plugin-script ImageMagick
cd /tmp
git clone https://github.com/furkrn/PlymouthVista
cd PlymouthVista

sed -i "s/vista\";/7\";/g" src/plymouth_config.sp
sh compile.sh 
sh install.sh -s
dracut --force --verbose --kver $FEDORA_KERNEL