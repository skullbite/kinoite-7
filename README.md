> [!NOTE]  
> **This project is NOT affiliated with Microsoft or Windows; We do not claim ownership to any of the assets included.**
# 🪟🐧 Kinoite 7 (or Kin7)

### An OCI image that layers [AeroThemePlasma](https://gitgud.io/wackyideas/aerothemeplasma/) on top of Fedora Kinoite
![Kinoite 7 Preview](https://github.com/skullbite/kinoite-7/blob/main/repo_files/Preview.png?raw=true)

## Features
- Steam + Tailscale preinstalled
- Everything offered by ATP
- Wallpapers from Windows 7
- Gadgets

## Install
Switch to us from another bootc image:
```
sudo bootc switch ghcr.io/skullbite/kinoite-7:latest
```

## Credits
- [UBlue](https://github.com/ublue-os/): Made the [image template](https://github.com/ublue-os/image-template), and the [Kinoite](https://github.com/ublue-os/main) image this is based off
- [WackyIdeas](https://gitgud.io/wackyideas): Making ATP
- [catpswin56](https://gitgud.io/catpswin56): Made Vista Gadgets
- [atmk](https://gitgud.io/atmk): Made Aero Dolphin/GwenView
- [Frutiger Aero Archive](https://frutigeraeroarchive.org/wallpapers/windows_7): Where the Win7 wallpapers were sourced
- [CachyOS](https://cachyos.org/): Two of their wallpapers looked fitting for this
- [WinBlues 7](https://github.com/winblues/winblues7): The original inspiration for this image

## "How is this different from WinBlues 7?"
[WinBlues 7](https://github.com/winblues/winblues7) is another image built by [ledif](https://github.com/ledif) that installs ATP for KDE.

- Kinoite 7 ships both a Desktop and Deck (Gamer) image, whereas WinBlues 7 only ships a Deck Release. 
- WinBlues 7 only ships ATP on top of Bazzite Deck, no additional software related to the ATP experience.

I heavily recommend checking out the [WinBlues](https://github.com/winblues) project for more bootc oses meant to simulate older versions of windows for modern linux.