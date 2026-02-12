#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/sys/ /
python /ctx/update_os_release.py

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install -y fastfetch steam tailscale gum glow

cat > /usr/share/ublue-os/image-info.json <<EOF
{
  "image-name": "Kinoite 7",
  "image-vendor": "skullbite",
  "image-ref": "kde-7",
  "image-tag": "latest",
  "image-branch": "main",
  "base-image-name": "Fedora Kinoite",
  "fedora-version": "$(rpm -E %fedora)",
  "version": "$(rpm -E %fedora)",
  "version-pretty": "$(rpm -E %fedora)"
}
EOF

systemctl enable podman.socket