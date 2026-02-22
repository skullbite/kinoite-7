#!/bin/bash

set -exuo pipefail

dnf install -y plymouth plymouth-scripts plymouth-plugin-script ImageMagick
cd /tmp
git clone https://github.com/furkrn/PlymouthVista
cd PlymouthVista

sed -i "s/vista\";/7\";/g" src/plymouth_config.sp
cat src/plymouth_config.sp
sh compile.sh 
sh install.sh -s