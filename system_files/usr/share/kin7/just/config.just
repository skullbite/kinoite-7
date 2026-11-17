get-config := "/usr/libexec/kin7-config-get"
set-config := "/usr/libexec/kin7-config-set"

get-task-manager:
    @{{ get-config }} task-manager task-manager

set-get-task-manager $option="choose":
    #!/bin/bash

    set -e pipefail
    OPTIONS=("task-manager system-monitor")

    if [[ $option == "choose" ]]; then
        echo -e "Choose an app to be your Task Manager.\nTask Manager is a recreation of the Windows 7 task manager.\nSystem Monitor is KDE's built-in task manager."
        option=$(gum choose $OPTIONS)
    fi

    if [[ $(echo $OPTIONS | sed "s/$option/ /g") == $OPTIONS ]]; then
        echo "Invalid option '$option':"
        echo $OPTIONS
        exit 1
    fi


    TARGET=""
    DELETE_TARGET=""

    case $option in
        task-manager)
            TARGET="org.kde.plasma-systemmonitor"
            DELETE_TARGET="linux-taskmgr"
          ;;
        system-monitor)
            TARGET="linux-taskmgr"
            DELETE_TARGET="org.kde.plasma-systemmonitor"
          ;;
    esac
            

    mkdir -p ~/.local/share/applications
    rm -f ~/.local/share/applications/$DELETE_TARGET
    cp /usr/share/applications/$TARGET.desktop ~/.local/share/applications
    sed -i "s/\[Desktop Entry\]/[Desktop Entry]\nHidden=true/" ~/.local/share/applications/$TARGET.desktop

    {{ set-config }} system-monitor $opt
