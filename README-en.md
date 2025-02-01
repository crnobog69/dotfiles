<div align="center">
  
# 🪐 | Dotfiles (GNU STOW)

</div>

<div align="center">

> [!WARNING]
> Documentation is located on [***Dotdocs***](https://dotdocs.vercel.app/) website.
> Documentation that is located here will not be updated.

---

[Српски (🇷🇸)](README.md) | [English (🇬🇧)](README-en.md)

---

</div>

## Table of Contents:

- ### 📜 | [Scripts](#scripts)
- ### 🗼 | [Personal configuration files](#personal-configuration-files)
- ### 🪐 | [Other](#other)

---

<details>
  <summary>🐧 | PC Configuration</summary>

| Category         | Details                             | Other                                                                                                    |
| ---------------- | ----------------------------------- | -------------------------------------------------------------------------------------------------------- |
| **OS**           | Arch Linux (Garuda Linux)           | Windows 11                                                                                               |
| **DE**           | KDE Plasma 6.2                      | -                                                                                                        |
| **Icons**        | BeautyLine                          | Custom Papirus-Dark - [Catppuccin Latte Lavender Folders](https://github.com/catppuccin/papirus-folders) |
| **Compositor**   | Wayland                             | -                                                                                                        |
| **Shell**        | zsh (Starship, Zoxide, Zinit, Tmux) | fish, bash                                                                                               |
| **Промт**        | Starship                            | -                                                                                                        |
| **Terminal**     | Kitty                               | Alacritty, Konsole                                                                                       |
| **IDE**          | VS Codium, VS Code, micro           | Zed                                                                                                      |
| **File Manager** | Dolphin                             | Thunar                                                                                                   |
| **Browser**      | Brave                               | Firefox Developer Edition                                                                                |

</details>

---

<br>

> [!NOTE]
> Browser extension[brave-maps](brave-maps) - For now only for [`Chromium`](https://alternativeto.net/category/browsers/chromium-based/) browsers

---

## Scripts:

### Linux

You need to give permission to script(s):

```
cd dotfiles
chmod +x scripts/pkg-rs.sh
chmod +x scripts/pkg-en.sh
chmod +x scripts/cgit.sh
chmod +x scripts/kolo.sh
chmod +x scripts/ftn.sh
chmod +x scripts/crc.sh
chmod +x scripts/entropy.sh
chmod +x scripts/zap.sh
chmod +x scripts/catbox.sh
chmod +x scripts/litterbox.sh
chmod +x scripts/spicetify.sh
chmod +x push.sh
chmod +x pull.sh
```

/

```
cd dotfiles && chmod +x scripts/pkg-rs.sh scripts/pkg-en.sh scripts/cgit.sh scripts/kolo.sh scripts/ftn.sh scripts/crc.sh scripts/entropy.sh scripts/zap.sh push.sh pull.sh
```

### Windows

#### Power Shell

```
Set-ExecutionPolicy RemoteSigned
```

#### CMD (Admininstrator)

```
powershell -Command "Set-ExecutionPolicy RemoteSigned"
```

### 📦 | Packages

In [`scripts`](scripts).

- 🇷🇸 | `pkg.sh` - листа пакета/програма које користим
- 🇬🇧 | `pkg-en-sh` - list of packages/programs I use

> [!NOTE]
> The only difference is the language. To adjust, modify the file [`scripts/packages.json`](scripts/packages.json).

### 🔄 | Git

- `push.sh` - customized `pull`/`push` script for my `dotfiles`
- `pull.sh` - customized `pull` script for my `dotfiles`
- `push.ps1` - customized `pull`/`push` script (Windows)
- `pull.ps1` - customized `pull` script (Windows)

### 🐧 | Other

> [!NOTE] > `ftn.` - stand for **_Faculty of Technical Sciences_**.

- `ftn.sh` - a custom script that shows whether the week is even or odd.
- `ftn.ps1` - a custom script that shows whether the week is even or odd. (Widnows)
- [`vhs-en.sh`](scripts/vhs/README-en.md) - Video Processing Script (in `scripts/vhs`)
- `pasters` - a script that uses the API of [paste.rs](https://paste.rs/)
- [`kolo`](https://github.com/crnobog69/kolo) - Script for searching Arch Linux depositories (AUR included)
- `crc.sh` - a customized script for compiling programs written in the `C` programming language using `gcc`
- `entropy.sh` - customized script for system cleanup
- `zap.sh` - customized script for system update with support for multiple operating systems
- `catbox.sh` - customized script for using [catbox.moe](https://catbox.moe/)
- `litterbox.sh` - customized script for using [litterbox.catbox.moe](https://litterbox.catbox.moe/)
- `install-wakapi.sh` - personalized install script for [wakapi](https://github.com/flyingrub/wakapi) for self-hosting
- `desktopify.sh` - personalized script for creating `.desktop` file for AppImage application
- `cgit.sh` - personalized script for `git`
- `papirus.sh` - personalized script for customizing [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- `lama.sh` - personalized script for using [Ollama](https://github.com/ollama/ollama)

---

## Personal configuration files:

### `GNU Stow`

- 😺 | `kitty` (Mocha Green, Mocha Purple, Tokyo Night)
- 🖋️ | `micro` (Mocha Transparent, Mocha)
- ⚡ | `zed`
- 🐚 | `zsh`
- 🐚 | `bash`
- 🐟 | `fish`
- 🖼️ | `fastfetch`
- 🌴 | `alacritty`
- 🚀 | `starship`
- 🥺 | `bottom`
- 📢 | `cava`
- 🦇️ | `bat`
- 🏆 | `btop`
- 🏖️ | `rio`
- 🦆 | `yazi`
- 🌈 | `lsd`
- 🎥 | `mpv`
- ⚙️ | `nvim`
- 💽 | `tmux`
- 🦌 | `vs-code`
- 🦝 | `filen`
- 🐧 | `transparency.toggle`, `plasmusic-toolbar`, `zayron.simple.separator`, `apdatifier`

### Manual setup:

- Visit [`crnobog69/extra`](https://github.com/crnobog69/extra)

- 🧰 | [`assets`](assets/) - images, icons and other

### Other

- 📰 | [`cmd`](cmd/cmd-en.md) - Basic Commands for Arch Linux and custom commands

## 🛠️ Setup

> [!NOTE]
> For `Tmux` you need to install: [`tmux-plugins/tpm`](https://github.com/tmux-plugins/tpm), [`tmuxplugins/tmux-cpu`](https://github.com/tmux-plugins/tmux-cpu) and (optional) [`catppuccin/tmux`](https://github.com/catppuccin/tmux).

1. Install GNU Stow (Arch Linux):

   ```
   sudo pacman -S stow
   ```

2. Clone the repository:

   ```
   git clone https://github.com/crnobog69/dotfiles.git
   ```

3. Apply configurations:

   ```
   cd ~/.dotfiles
   stow kitty-cat-green zed zsh fastfetch micro starship fish bottom cava bat mpv
   ```

   or (one)

   ```
   cd ~/.dofiles
   stow zed
   ```

### 🔄 Updating

```
cd ~/.dotfiles
git pull
```

---

## Other

- 😺 | [Catppuccin](https://github.com/catppuccin)
- 🗼 | [Tokyo Night](https://github.com/tokyo-night)
- 🗺️ | [Brave Maps](https://github.com/stignarnia/add-maps-links-brave-search)
- 🐇 | [MangaDex](https://github.com/crnobog69/mangadex)
- 🐈 | [Miruro](https://github.com/crnobog69/miruro-catppuccin)
- 🎵 | [Spicetify](https://github.com/spicetify/cli)
- ⚛️ | [Cobaltium](https://github.com/crnobog69/cobaltium)
- 📝 | [Notesnook](https://github.com/crnobog69/notesnook)
- 🦀 | [pasters](https://github.com/crnobog69/pasters-terminal)
- 📻 | [kolo](https://github.com/crnobog69/kolo)
- 🐒 | [Violentmonkey](https://github.com/crnobog69/violentmonkey-mocha)
- 🦊 | [Crnobog - Creator/Me](https://github.com/crnobog69)

<br>

#### Repositories (Dotfiles):

🐙 | [`Github | Repository`](https://github.com/crnobog69/dotfiles)

🏔️ | [`Codeberg | Repository`](https://codeberg.org/crnobog/dotfiles)

🦊 | [`GitLab Repository`](https://gitlab.com/crnobog/dotfiles)

<br>

#### Repositories (Extra):

🐙 | [`Github | Repository`](https://github.com/crnobog69/extra)

🏔️ | [`Codeberg | Repository`](https://codeberg.org/crnobog/extra)

🦊 | [`GitLab Repository`](https://gitlab.com/crnobog/extra)

<br>

#### Repositories (dotwin | Windows):

🐙 | [`Github | Repository`](https://github.com/crnobog69/dotwin)

🏔️ | [`Codeberg | Repository`](https://codeberg.org/crnobog/dotwin)

🦊 | [`GitLab Repository`](https://gitlab.com/crnobog/dotwin)

<br>

---
