#!/bin/bash

set -ouex pipefail

dnf install -y plymouth plymouth-scripts plymouth-plugin-script ImageMagick

git clone https://github.com/furkrn/PlymouthVista /tmp/PlymouthVista
CUR=/tmp/PlymouthVista
cd $CUR
sh compile.sh
chmod +x PlymouthVista.script
# sh pv_conf.sh -s AuthuiStyle -v 7 -i PlymouthVista.script

sh pv_conf.sh
cp $CUR/lucon_disable_anti_aliasing.conf /etc/fonts/conf.d/10-lucon_disable_anti_aliasing.conf
sh gen_blur.sh
cp $CUR/systemd/system/update-plymouth-vista-state-boot.service /etc/systemd/system
cp $CUR/systemd/system/update-plymouth-vista-state-quit.service /etc/systemd/system
cp $CUR/systemd/hibernation/plymouth-vista-hibernate.service /etc/systemd/system
cp $CUR/systemd/hibernation/plymouth-vista-resume-from-hibernation.service /etc/systemd/system
cp $CUR/systemd/user/update-plymouth-vista-state-logon.service /etc/systemd/user
# TODO: Bound this variable to a config value, either thru 7just or system settings
sed "s/\$\(.*\)\"/10\"/g" -i systemd/slowdown/plymouth-vista-slow-boot-animation.service
cat systemd/slowdown/plymouth-vista-slow-boot-animation.service
cp systemd/slowdown/plymouth-vista-slow-boot-animation.service /etc/systemd/system
systemctl enable update-plymouth-vista-state-{boot,quit}.service
systemctl enable plymouth-vista-{hibernate,resume-from-hibernation}.service
systemctl enable plymouth-vista-slow-boot-animation.service

cp -r $(pwd) /usr/share/plymouth/themes/PlymouthVista
#chmod +x ./compile.sh
#chmod +x ./install.sh
#./compile.sh
#./install.sh -s -q
sh omitPlymouth.sh
plymouth-set-default-theme PlymouthVista
dracut --force --regenerate-all --verbose

rm /usr/share/wayland-sessions/plasma.desktop
