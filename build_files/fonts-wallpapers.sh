#!/bin/bash

set -euox pipefail

DEFAULT_WP="/usr/share/wallpapers/Win7 - #0/contents/images/1920x1200.jpg"

make_wallpaper () {
    # $1 = Display name
    # $2 = Path to image
    # $3 = Default size of image
    # $4 = Author of wallpaper
    WP_PATH="/usr/share/wallpapers/$1/contents/images"
    IMG_SUFFIX=${2##*.}
    mkdir -p "$WP_PATH"
    cp "$2" "$WP_PATH/$3.$IMG_SUFFIX"
    SIZES=("640x480 800x600 1280x800 1280x1024 1440x900 1600x1200 1638x1024 1680x1050 1920x1080 1920x1200 2560x1400 2560x1600")
    SIZES=$(echo $SIZES | sed "s/$3 //g")
    for ii in $SIZES; do
        ln -s "$WP_PATH/$3.$IMG_SUFFIX" "$WP_PATH/$ii.$IMG_SUFFIX"
    done

    echo "{\"KPlugin\":{\"Name\":\"$1\",\"Authors\":[{\"Name\":\"$4\"}]}}" > "/usr/share/wallpapers/$1/metadata.json"
}

cd /tmp

# fonts
git clone --depth 1 https://github.com/mrbvrz/segoe-ui-linux.git /tmp/segoe
curl -o /usr/share/fonts/lucon.ttf -SsL https://github.com/FSKiller/Microsoft-Fonts/blob/main/lucon.ttf
curl -o /tmp/tv.zip https://www.yohng.com/files/TerminalVector.zip
unzip tv.zip

cp TerminalVector.ttf /usr/share/fonts
cp -r /tmp/segoe/font /usr/share/fonts

fc-cache -f -r -v

# wallpapers
tar -xvf /ctx/wallpapers.tar.gz
ls /tmp

rm -f /usr/share/wallpapers/Default
for i in $(ls /tmp/wallpapers/win7); do
    # sed why...
    DISPLAY_NAME="Win7 - #$(python -c "import re;print(re.findall(\"img(.*).jpg\", \"$i\")[0])")"
    # DISPLAY_NAME=$(sed -rn "s/^img(.*).jpg/Windows 7 - \1/" /tmp/win-bg)

    make_wallpaper "$DISPLAY_NAME" "/tmp/wallpapers/win7/$i" 1920x1200 "Microsoft"
done

for i in $(ls /tmp/wallpapers/cachyos); do
    make_wallpaper "$i" "/tmp/wallpapers/cachyos/$i" 3840x2160 "CachyOS"
done 

ln -s "/usr/share/wallpapers/Win7 - #0" /usr/share/wallpapers/Default                                                                                                                                                                                                                                                                                                                                                                                                                      

mkdir -p /usr/share/backgrounds

ln -sf "$DEFAULT_WP" /usr/share/backgrounds/default.jxl
ln -sf "$DEFAULT_WP" /usr/share/backgrounds/default-dark.jxl

FEDORA_BG_DIR="/usr/share/backgrounds/fedora-workstation"
mkdir -p $FEDORA_BG_DIR

ln -s "$DEFAULT_WP" $FEDORA_BG_DIR/default.jxl
ln -s "$DEFAULT_WP" $FEDORA_BG_DIR/default-dark.jxl

ln -s "$DEFAULT_WP" $FEDORA_BG_DIR/default.png
ln -s "$DEFAULT_WP" $FEDORA_BG_DIR/default-dark.png
