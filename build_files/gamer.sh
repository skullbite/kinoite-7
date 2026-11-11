#!/bin/bash

ls /usr/share/wayland-sessions
rm /usr/share/wayland-sessions/plasma.desktop
ln -s /usr/share/wayland-session/aerothemeplasma.desktop /usr/share/wayland-sessions/plasma.desktop
# steamosctl set-default-desktop-session "aerothemeplasma.desktop"