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
Switch to us from another bootc image:
```sh
# Coming from Fedora Atomic or a derivative? (Bazzite, Aurora, etc)

# Desktop
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7:latest 

# Desktop + NVIDIA drivers
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7-nvidia:latest 

# Bazzite Deck + Kinoite 7
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7-gamer:latest 

# Bazzite Deck + Kinoite 7 + NVIDIA drivers
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/skullbite/kinoite-7-gamer-nvidia:latest 
```

```sh
# Coming from another bootc os? 
# It's recommended to `rpm-ostree rebase` to a signed image after you `bootc switch` (shown above)

# Desktop
sudo bootc switch ghcr.io/skullbite/kinoite-7:latest

# Desktop + NVIDIA drivers
sudo bootc switch ghcr.io/skullbite/kinoite-7-nvidia:latest

# Bazzite Deck + Kinoite 7
sudo bootc switch ghcr.io/skullbite/kinoite-7-gamer:latest 

# Bazzite Deck + Kinoite 7 + NVIDIA drivers
sudo bootc switch ghcr.io/skullbite/kinoite-7-gamer-nvidia:latest
```

## Credits
- Universal Blue: [Bootc Image Template](https://github.com/ublue-os/image-template), [Bazzite-Deck](https://github.com/ublue-os/bazzite) image, and [Kinoite](https://github.com/ublue-os/main) image
- AeroShell Community: [AeroThemePlasma](https://gitgud.io/aeroshell/atp/aerothemeplasma)
- catpswin56: [AeroShell Gadgets](https://gitgud.io/aeroshell/aeroshell-gadgets), [Linver](https://gitgud.io/wackyideas/linver)
- ActuallyAridan: [Task Manager Recreation](https://github.com/actuallyaridan/linux-taskmgr)
- Albert Tomanek: Aero [Dolphin](https://gitgud.io/atmk/dolphin-aero)/[GwenView](https://gitgud.io/atmk/dolphin-gwenview)
- Frutiger Aero Archive: [Wallpapers](https://frutigeraeroarchive.org/wallpapers/windows_7)
- [CachyOS](https://cachyos.org/): Two extra wallpapers
- [WinBlues 7](https://github.com/winblues/winblues7): Inspiration

## "How is this different from WinBlues 7?"
[WinBlues 7](https://github.com/winblues/winblues7) is another image built by [ledif](https://github.com/ledif) that installs ATP for KDE.

- Kinoite 7 ships both a Desktop and Deck (Gamer) image, whereas WinBlues 7 only ships a Deck Release. 
- WinBlues 7 only ships ATP on top of Bazzite Deck, no additional software related to the ATP experience.

I heavily recommend checking out the [WinBlues](https://github.com/winblues) project for more bootc OSes meant to simulate older versions of windows for modern linux.