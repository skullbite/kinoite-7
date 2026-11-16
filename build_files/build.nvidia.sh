#!/bin/bash

# Uses https://github.com/renner0e/nvidia-example/

set -euox pipefail

cd /ctx

./kernel.sh
./nvidia.sh
./build.sh

TAG=" Desktop "
if [[ $GAMER == "1" ]]; then
    TAG=" Gamer "
fi
sed -i "s/Variant=.*/Variant=NVIDIA${TAG}Edition/g" /etc/xdg/aerothemeplasma/kcm-about-distrorc