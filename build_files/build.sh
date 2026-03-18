#!/bin/bash

set -ouex pipefail

rsync -rvK /ctx/sys/ /
python /ctx/update_os_release.py
echo "Kin7" >> /etc/hostname

# sed -i "s/#Session=/Session=AeroThemePlasma.desktop/g" /etc/sddm.conf

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install -y fastfetch steam tailscale gum glow

# cat > /usr/share/ublue-os/image-info.json <<EOF
# {
#   "image-name": "Kinoite 7",
#   "image-vendor": "skullbite",
#   "image-ref": "kinoite-7",
#   "image-tag": "latest",
#   "image-branch": "main",
#   "base-image-name": "Fedora Kinoite",
#   "fedora-version": "$(rpm -E %fedora)",
#   "version": "$(rpm -E %fedora)",
#   "version-pretty": "$(rpm -E %fedora)"
# }
# EOF

install -d /usr/share/bash-completion/completions /usr/share/zsh/site-functions /usr/share/fish/vendor_completions.d/
7just --completions bash | sed -E 's/([\(_" ])just/\17just/g' > /usr/share/bash-completion/completions/7just
7just --completions zsh | sed -E 's/([\(_" ])just/\17just/g' > /usr/share/zsh/site-functions/_7just
7just --completions fish | sed -E 's/([\(_" ])just/\17just/g' > /usr/share/fish/vendor_completions.d/7just.fish

systemctl enable podman.socket
systemctl enable kin7-init.service