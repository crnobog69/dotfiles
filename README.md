### README на српском 🇷🇸

# 🏠 Dotfiles (GNU STOW)

> [Read in English 🇬🇧](#readme-in-english-)

> [!NOTE]
> Само **kitty**, **zed**, **zsh**, **fastfetch**, **alacritty** су за коришћење уз помоћ GNU STOW.

> [!NOTE]
> [brave-maps](brave-maps) - За сада само за Chromium претраживаче

Личне конфигурацијске датотеке за:
- 😺 | kitty (Mocha Green, Mocha Purple, Tokyo Night)
- ⚡ | zed
- 🐚 | zsh
- 🖼️ | fastfetch
- 🌴 | alacritty

Ручно:
- 🖥️ | [konsole](konsole/README.md) <= водич
- 🌐 | [tabliss](tabliss/README.md) <= водич
- 💬 | [vencord](vencord/README.md) <= водич
- 🎵 | [spicetify](spicetify/README.md) <= водич
- 🦊 | [firefox](firefox/README.md) <= водич
- ⚛️ | [cobaltium](https://github.com/crnobog69/cobaltium) <= водич
- 🦁 | [brave/chrome](brave/README.md) <= водич
- 🗺️ | [brave/maps](https://github.com/crnobog69/cobaltium) <= водич (иско као [cobaltium](https://github.com/crnobog69/cobaltium))
- 🧰 | assets - само слике и иконице

## 🛠️ Постављање

1. Преузмите GNU Stow (Arch Linux):
   ```
   sudo pacman -S stow
   ```

2. Клонирање:
   ```
   git clone https://github.com/crnobog69/dotfiles.git
   ```

3. Примена конфигурација:
   ```
   cd ~/.dotfiles
   stow kitty-cat-green zed zsh fastfetch alacritty
   ```

## 🔄 Ажурирање

```
cd ~/.dotfiles
git pull
stow kitty-cat-green zed zsh fastfetch alacritty
```

---

### README in English 🇬🇧

# 🏠 Dotfiles (GNU STOW)

> [Читај на српском 🇷🇸](#readme-на-српском-)

> [!NOTE]
> Only **kitty**, **zed**, **zsh**, **fastfetch**, **alacritty** are to be used with GNU STOW.

> [!NOTE]
> [brave-maps](brave-maps) - For now only for Chromium browsers

Personal configuration files for:
- 😺 | kitty (Mocha Green, Mocha Purple, Tokyo Night)
- ⚡ | zed
- 🐚 | zsh
- 🖼️ | fastfetch
- 🌴 | alacritty

Manual setup:
- 🖥️ | [konsole](konsole/README.md) <= guide
- 🌐 | [tabliss](tabliss/README.md) <= guide
- 💬 | [vencord](vencord/README.md) <= guide
- 🎵 | [spicetify](spicetify/README.md) <= guide
- 🦊 | [firefox](firefox/README.md) <= guide
- ⚛️ | [cobaltium](https://github.com/crnobog69/cobaltium) <= guide
- 🦁 | [brave/chrome](brave/README.md) <= guide
- 🗺️ | [brave/maps](https://github.com/crnobog69/cobaltium) <= guide (same as [cobaltium](https://github.com/crnobog69/cobaltium))
- 🧰 | assets - only images and icons

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

## 🔄 Updating

```
cd ~/.dotfiles
git pull
stow kitty-cat-green zed zsh fastfetch alacritty
```
