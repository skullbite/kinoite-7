> [!NOTE]  
> **This project is NOT affiliated with Microsoft or Windows; We do not claim ownership to any of the assets included.**
# 🪟🐧 Kinoite 7 (or Kin7)

### An OCI image that layers [AeroThemePlasma](https://gitgud.io/wackyideas/aerothemeplasma/) on top of Fedora Kinoite
![Kinoite 7 Preview](https://github.com/skullbite/kinoite-7/blob/main/repo_files/Preview.png?raw=true)

## Features
- Steam + Tailscale preinstalled
- Almost* everything offered by ATP
- Wallpapers from Windows 7
- More options for visual changes via 7just
- ~~Apps from Sevulet~~ (WIP)
- ~~Gadgets~~ (WIP)

\* see known issues 

## Install
Switch to us from another bootc image:
```
sudo bootc switch ghcr.io/skullbite/kinoite-7:latest
```

## Credits
- [UBlue](https://github.com/ublue-os/): Made the [image template](https://github.com/ublue-os/image-template), and the [Kinoite](https://github.com/ublue-os/main) image this is based off
- [WackyIdeas](https://gitgud.io/wackyideas): Making ATP
- [Frutiger Aero Archive](https://frutigeraeroarchive.org/wallpapers/windows_7): where the Win7 wallpapers were sourced
- [CachyOS](https://cachyos.org/): Two of their wallpapers looked fitting for this
- [WinBlues 7](https://github.com/winblues/winblues7): The original inspiration for this image + their plymouthvista script


## Known Issues
- SDDM shutdown screen is Vista
- ~~PlymouthVista seemingly doesn't work (No windows-like boot screen)~~
- Window Colors won't open in "Personalize" menu, can still be accessed with the Aero Glass Blur extension settings
- System default wallpaper is Plasmas

## "How is this different from WinBlues 7?"
> TL;DR: This image is based on Kinoite rather than Bazzite, and attempts to incorporate more ATP associated projects.

[WinBlues 7](https://github.com/winblues/winblues7) is another image built by [ledif](https://github.com/ledif) that installs ATP on top of Bazzite KDE Plasma. At the time of writing, the included taskbar component (SevenTasks) is broken.

This image is built on top of [UBlue's kinoite image](https://github.com/ublue-os/main), which only includes the (GUI) apps that come by default in KDE Plasma under Fedora Atomic. (aside from Steam)

Aside from that, the intent of Kinioite 7 is to include as many projects associated with ATP as possible, some being Sevulet and Gadgets.