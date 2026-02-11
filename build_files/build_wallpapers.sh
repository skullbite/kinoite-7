#!/bin/bash

set -ouex pipefail

# W7 wallpapers ripped from the Frutiger Aero Archive
# https://frutigeraeroarchive.org/wallpapers/windows_7
# https://www.deviantart.com/windowsaesthetics/art/Ultimate-Windows-Wallpaper-Pack-942163195

# Wave+WaveDark ripped from CachyOS
# https://github.com/CachyOS/cachyos-wallpapers

make_wallpaper () {
    WP_PATH="/usr/share/wallpapers/$1/contents/images"
    IMG_SUFFIX=${2##*.}
    mkdir -p "$WP_PATH"
    cp "$2" "$WP_PATH/$3.$IMG_SUFFIX"
    SIZES=("640x480 800x600 1280x800 1280x1024 1440x900 1600x1200 1638x1024 1680x1050 1920x1080 1920x1200 2560x1400 2560x1600")
    SIZES=$(echo $SIZES | sed "s/$3 //g")
    for ii in $SIZES; do
        ln -s "$WP_PATH/$3.$IMG_SUFFIX" "$WP_PATH/$ii.$IMG_SUFFIX"
    done

    echo {\"KPlugin\":{\"Name\":\"$1\",\"Authors\":[{\"Name\":\"$4\"}]}} > "/usr/share/wallpapers/$DISPLAY_NAME/metadata.json"
}

rm -f /usr/share/wallpapers/Default
for i in $(ls /ctx/wallpapers/win7); do
    # sed why...
    DISPLAY_NAME="Win7 - #$(python -c "import re;print(re.findall(\"img(.*).jpg\", \"$i\")[0])")"
    # DISPLAY_NAME=$(sed -rn "s/^img(.*).jpg/Windows 7 - \1/" /tmp/win-bg)

    make_wallpaper "$DISPLAY_NAME" "/ctx/wallpapers/win7/$i" 1920x1200 "Microsoft"
done

for i in $(ls /ctx/wallpapers/cachyos); do
    make_wallpaper "$i" "/ctx/wallpapers/cachyos/$i" 3840x2160 "CachyOS"
done 

ln -s "/usr/share/wallpapers/Win7 - #0" /usr/share/wallpapers/Default
# cat /usr/share/plasma/wallpapers/org.kde.image/contents/config/main.xml