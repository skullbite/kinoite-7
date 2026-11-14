#!/bin/bash

rsync -rvK /ctx/sys/ /


if [[ $GAMER == "1" ]]; then
    /ctx/gamer.sh
else
    systemctl disable plasmalogin.service
    systemctl enable sddm.service
fi
echo "kinoite7" >> /etc/hostname

if [[ $GAMER == "0" ]]; then
    cat > /usr/share/ublue-os/image-info.json <<EOF
    {
      "image-name": "kinoite-7",
      "image-vendor": "skullbite",
      "image-ref": "kinoite-7",
      "image-tag": "dev",
      "image-branch": "dev",
      "base-image-name": "kinoite",
      "fedora-version": "$(rpm -E %fedora)",
      "version": "$(rpm -E %fedora)",
      "version-pretty": "$(rpm -E %fedora)"
    }
    EOF
fi

install -d /usr/share/bash-completion/completions /usr/share/zsh/site-functions /usr/share/fish/vendor_completions.d/
7just --completions bash | sed -E 's/([\(_" ])just/\17just/g' > /usr/share/bash-completion/completions/7just
7just --completions zsh | sed -E 's/([\(_" ])just/\17just/g' > /usr/share/zsh/site-functions/_7just
7just --completions fish | sed -E 's/([\(_" ])just/\17just/g' > /usr/share/fish/vendor_completions.d/7just.fish

systemctl enable podman.socket
systemctl enable kin7-init.service
