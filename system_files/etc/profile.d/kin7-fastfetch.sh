if [[ $(/usr/libexec/kin7-config-get no-fastfetch-alias 0) == "0" ]]; then
    alias fastfetch="fastfetch --logo windows"
fi