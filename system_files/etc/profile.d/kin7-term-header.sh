case $(/usr/libexec/kin7-config-get bash-profile cmdprompt) in
    cmdprompt)
        . /etc/os-release
        echo -e "$NAME [Version $(uname -r)]\nCopyright (c) $(date +%Y) Fedora Community. All rights reserved.\n"
      ;;
    ublue)
        7just motd
      ;;
    fastfetch)
        fastfetch --logo windows
      ;;
esac