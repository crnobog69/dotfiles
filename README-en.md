# 🪐 Dotfiles (GNU STOW)

---

  [Српски (🇷🇸)](README.md) | [English (🇬🇧)](README-en.md)

---

# Table of Contents:

- ## 📜 | [Scripts](#scripts)
- ## 🗼 | [Personal configuration files | Gnu Stow](#personal-configuration-files)
- ## 🪐 | [Other](#other)

---

# 🐧

| Category            | Details                                    | Other                                  |
|---------------------|--------------------------------------------|----------------------------------------|
| **OS**              | Arch Linux (EndeavourOS)                   | -                                      |
| **DE**              | KDE Plasma 6.1                             | -                                      |
| **Icons**           | Custom Papirus-Dark - [Catppuccin Latte Lavender Folders](https://github.com/catppuccin/papirus-folders)          | -                                      |
| **Compositor**      | Wayland                                    | -                                      |
| **Shell**           | zsh (oh-my-zsh, Powerlevel10k theme)       | bash                                    |
| **Terminal**        | Kitty                                      | Alacritty, Konsole                      |
| **IDE**             | VS Code                                    | Zed                                     |
| **File Manager**    | Dolphin                                    | Thunar                                  |
| **Browser**         | Brave                                      | Firefox Developer Edition              |

---

<br>

> [!IMPORTANT]
> For `zsh` first follow this [**tutorial**](https://www.youtube.com/watch?v=ud7YxC33Z3w).

> [!NOTE]
> Only **kitty**, **zed**, **zsh**, **fastfetch**, **alacritty** are to be used with GNU STOW.

> [!NOTE]
> [brave-maps](brave-maps) - For now only for [`Chromium`](https://alternativeto.net/category/browsers/chromium-based/) browsers

# Scripts:

You need to give permission to script(s):

```
chmod +x pkg-rs.sh
```

```
chmod +x pkg-en-sh
```

```
chmod +x push.sh
```

```
chmod +x pull.sh
```

## 📦 | Packages

- 🇷🇸 | `pkg-rs.sh` - листа пакета/програма које користим
- 🇬🇧 | `pkg-en-sh` - list of packages/programs I use

> [!NOTE]
> There is no difference between these **two scripts** except that one is in **Serbian** and the other is in **English**.
> <br>
> If you want to **add/remove** any **package/program**, just **open** the script (the script in the **language** of your choice) with a **text editor** of your choice and **edit it**.

## 🔄 | Git

- `push.sh` - customized `push` script for my `dotfiles`
- `pull.sh` - customized `pull` script for my `dotfiles`

# Personal configuration files:

`GNU Stow`

- 😺 | `kitty` (Mocha Green, Mocha Purple, Tokyo Night)
- ⚡ | `zed`
- 🐚 | `zsh`
- 🖼️ | `fastfetch`
- 🌴 | `alacritty`

## Manual setup:
- 🖥️ | [`kde`](kde/README.md) <= guide
- 🌐 | [`tabliss`](tabliss/README.md) <= guide
- 💬 | [`vencord`](vencord/README.md) <= guide
- 🎵 | [`spicetify`](spicetify/README.md) <= guide
- 🐇 | [`mangadex`](mangadex/README.md) <= guide
- 🐈 | [`miruro`](miruro/README.md) <= guide
- 🐒 | [`violentmonkey`](violentmonkey/README.md) <= guide
- 🦊 | [`firefox`](firefox/README.md) <= guide
- ⚛️ | [`cobaltium`](https://github.com/crnobog69/cobaltium) <= guide
- 🦁 | [`brave`](brave/README.md) <= guide
- 🗺️ | [`brave-maps`](https://github.com/crnobog69/cobaltium) <= guide (same as [`cobaltium`](https://github.com/crnobog69/cobaltium))
- 🧰 | [`assets`](assets/) - images, icons and other

## 🛠️ Setup

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
   stow kitty-cat-green zed zsh fastfetch alacritty
   ```

   or (one)

   ```
   cd ~/.dofiles
   stow zed
   ```

## 🔄 Updating

```
cd ~/.dotfiles
git pull
```

# Other

- 😺 | [Catppuccin](https://github.com/catppuccin)
- 🗼 | [Tokyo Night](https://github.com/tokyo-night)
- 🗺️ | [Brave Maps](https://github.com/stignarnia/add-maps-links-brave-search)
- 🐇 | [MangaDex](https://github.com/crnobog69/mangadex)
- 🐈 | [Miruro](https://github.com/crnobog69/miruro-catppuccin)
- 🎵 | [Spicetify](https://github.com/spicetify/cli)
- ⚛️ | [Cobaltium](https://github.com/crnobog69/cobaltium)
- 🐒 | [Violentmonkey](https://github.com/crnobog69/violentmonkey-mocha)
- 🦊 | [Crnobog - Creator/Me](https://github.com/crnobog69)

<br>

Repositories:

🐙 | [`Github | Repository`](https://github.com/crnobog69/dotfiles)

🏔️ | [`Codeberg | Repository`](https://codeberg.org/crnobog/dotfiles)

🦊 | [`GitLab Repository`](https://gitlab.com/crnobog/dotfiles)

<br>

---