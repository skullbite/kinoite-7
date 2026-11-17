if [[ $(/usr/libexec/kin7-config-get win-7-prompt) == "1" ]]; then
    PS1='C:${PWD//\//\\\\}> '
fi
