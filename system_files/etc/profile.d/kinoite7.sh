#!/bin/bash
case $(/usr/libexec/kin7-config-get bash-profile cmdprompt) in
    cmdprompt)
        echo -e "Fedora Kinoite [Version $(uname -r)]\nCopyright (c) $(date +%Y) Fedora Community. All rights reserved.\n"
        ;;
    # ublue)
        # /usr/libexec/ublue-motd
    #    ;;
    fastfetch)
        fastfetch --logo windows
        ;;
esac


if [[ $(/usr/libexec/kin7-config-get win-7-prompt) == "1" ]]; then
    PS1='C:${PWD//\//\\\\}> '
fi

if [[ $(/usr/libexec/kin7-config-get no-fastfetch-alias 0) == "0" ]]; then
    alias fastfetch="fastfetch --logo windows"
fi 