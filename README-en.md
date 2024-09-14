# 🏠 Dotfiles (GNU STOW)

---

  [Српски (🇷🇸)](README.md) | [English (🇬🇧)](README-en.md)

---

> [!NOTE]
> Only **kitty**, **zed**, **zsh**, **fastfetch**, **alacritty** are to be used with GNU STOW.

> [!NOTE]
> [brave-maps](brave-maps) - For now only for [`Chromium`](https://alternativeto.net/category/browsers/chromium-based/) browsers

Personal configuration files for:
- 😺 | `kitty` (Mocha Green, Mocha Purple, Tokyo Night)
- ⚡ | `zed`
- 🐚 | `zsh`
- 🖼️ | `fastfetch`
- 🌴 | `alacritty`

Manual setup:
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
stow kitty-cat-green zed zsh fastfetch alacritty
```

## 🪐 Other

- 😺 | [Catppuccin](https://github.com/catppuccin)
- 🗼 | [Tokyo Night](https://github.com/tokyo-night)
- 🗺️ | [Brave Maps](https://github.com/stignarnia/add-maps-links-brave-search)
- 🐇 | [MangaDex](https://github.com/crnobog69/mangadex)
- 🎵 | [Spicetify](https://github.com/spicetify/cli)
- ⚛️ | [Cobaltium](https://github.com/crnobog69/cobaltium)
- 🐒 | [Violentmonkey](https://github.com/crnobog69/violentmonkey-mocha)
- 🦊 | [Crnobog - Creator/Me](https://github.com/crnobog69)

<br>

---