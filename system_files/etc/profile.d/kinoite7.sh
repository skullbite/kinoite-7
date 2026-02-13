#!/bin/bash
case $(7just _get-config bash-profile cmdprompt) in
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


if [[ $(7just _get-config win-7-prompt) == "1" ]]; then
    PS1='C:${PWD//\//\\\\}> '
fi

if [[ $(7just _get-config no-fastfetch-alias 0) == "0" ]]; then
    alias fastfetch="fastfetch --logo windows"
fi 