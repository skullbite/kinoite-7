#!/bin/bash

set -euox pipefail

export BASE_IMAGE_NAME="kinoite"
export AKMODNV_PATH="/tmp/rpms/nvidia"
export MULTILIB=0
export IMAGE_NAME="kinoite-7-nvidia"

cd /tmp

/tmp/rpms/nvidia/ublue-os/nvidia-install.sh

rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json
ln -sf libnvidia-ml.so.1 /usr/lib64/libnvidia-ml.so
tee /usr/lib/bootc/kargs.d/00-nvidia.toml <<EOF
kargs = ["rd.driver.blacklist=nouveau", "modprobe.blacklist=nouveau", "nvidia-drm.modeset=1", "initcall_blacklist=simpledrm_platform_driver_init"]
EOF