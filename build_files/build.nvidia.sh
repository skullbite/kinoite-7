#!/bin/bash

# Uses https://github.com/renner0e/nvidia-example/

set -euox pipefail

cd /ctx

./kernel.sh
./nvidia.sh
./build.sh