> [!NOTE]  
> **This project is NOT affiliated with Microsoft or Windows; We do not claim ownership to any of the assets included.**
# 🪟🐧 Kinoite 7 (or Kin7)

### An OCI image that layers [AeroThemePlasma](https://gitgud.io/aeroshell/atp/aerothemeplasma/) on top of Fedora Kinoite
![Kinoite 7 Preview](https://github.com/skullbite/kinoite-7/blob/main/repo_files/Preview.png?raw=true)

## Features
- Desktop + Gamer editions! (See install)
- Wallpapers from Windows 7
- Immersive recreations of Windows 7 apps (WIP)

## Install
> [!WARNING]
> It is not recommended to rebase from an OS that uses GNOME for the desktop (Fedora Silverblue, Bazzite-GNOME, Bluefin, etc), as it may break the KDE/ATP desktop on Kinoite 7.
>
> Please [reinstall](#neither-of-these) instead.

#### Coming from Fedora Kinoite or a derivative (Bazzite-KDE, Aurora, etc):

##### Desktop
```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7:latest 
```

##### Desktop + NVIDIA drivers
```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7-nvidia:latest 
```

##### Bazzite Deck + Kinoite 7
```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7-gamer:latest 
```

##### Bazzite Deck + Kinoite 7 + NVIDIA drivers
```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7-gamer-nvidia:latest 
```
----
#### Coming from another bootc OS:
> [!NOTE]
> It is recommended to rebase to a signed image after this (shown above)

##### Desktop
```sh
sudo bootc switch ghcr.io/skullbite/kinoite-7:latest
```

##### Desktop + NVIDIA drivers
```sh
sudo bootc switch ghcr.io/skullbite/kinoite-7-nvidia:latest
```
##### Bazzite Deck + Kinoite 7
```sh
sudo bootc switch ghcr.io/skullbite/kinoite-7-gamer:latest 
```

##### Bazzite Deck + Kinoite 7 + NVIDIA drivers
```sh
sudo bootc switch ghcr.io/skullbite/kinoite-7-gamer-nvidia:latest
```
---

### Neither of these?
Currently there is no ISO to install Kinoite 7 with. Install [Fedora Kinoite](https://fedoraproject.org/atomic-desktops/kinoite/download/), and [rebase](#coming-from-fedora-kinoite-or-a-derivative-bazzite-kde-aurora-etc) to Kinoite 7 afterwards.

## Credits
- Universal Blue: [Bootc Image Template](https://github.com/ublue-os/image-template), [Bazzite-Deck](https://github.com/ublue-os/bazzite) image, and [Kinoite](https://github.com/ublue-os/main) image
- AeroShell Community: [AeroThemePlasma](https://gitgud.io/aeroshell/atp/aerothemeplasma)
- catpswin56: [AeroShell Gadgets](https://gitgud.io/aeroshell/aeroshell-gadgets), [Linver](https://gitgud.io/wackyideas/linver)
- ActuallyAridan: [Task Manager Recreation](https://github.com/actuallyaridan/linux-taskmgr)
- Albert Tomanek: Aero [Dolphin](https://gitgud.io/atmk/dolphin-aero)/[GwenView](https://gitgud.io/atmk/dolphin-gwenview)
- Shiny Lisan: Assisted in setting a default wallpaper for the OS
- Frutiger Aero Archive: [W7 Wallpapers](https://frutigeraeroarchive.org/wallpapers/windows_7)
- CachyOS: Two extra [wallpapers](https://github.com/CachyOS/cachyos-wallpapers) (wave, wave2-dark)
- WinBlues 7: Doing this idea first

## "How is this different from WinBlues 7?"
[WinBlues 7](https://github.com/winblues/winblues7) is another image built by [ledif](https://github.com/ledif) that installs ATP for KDE.

- Kinoite 7 ships both a Desktop and Deck (Gamer) image, whereas WinBlues 7 only ships a Deck Release. 
- WinBlues 7 only ships ATP on top of Bazzite Deck, no additional software related to the ATP experience is included.

I heavily recommend checking out the [WinBlues](https://github.com/winblues) project for more bootc OSes meant to simulate older versions of windows for modern linux.