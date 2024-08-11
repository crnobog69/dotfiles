[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P311PGR8)
### README на српском 🇷🇸

# 🏠 Dotfiles (GNU STOW)

> [Read in English 🇬🇧](#readme-in-english-)

> [!NOTE]
> Само **kitty**, **zed**, **zsh**, **fastfetch** су за коришћење уз помоћ GNU STOW.

Личне конфигурацијске датотеке за:
- 😺 kitty
- ⚡ zed
- 🐚 zsh
- 🖼️ fastfetch

Ручно:
- 🖥️ [konsole](konsole/README.md) <= водич
- 🌐 [tabliss](tabliss/README.md) <= водич
- 💬 [vencord](vencord/README.md) <= водич
- 🎵 [spicetify](spicetify/README.md) <= водич

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
   stow kitty zed zsh fastfetch
   ```

## 🔄 Ажурирање

```
cd ~/.dotfiles
git pull
stow kitty zed zsh fastfetch
```

---

### README in English 🇬🇧

# 🏠 Dotfiles (GNU STOW)

> [Читај на српском 🇷🇸](#readme-на-српском-)

> [!NOTE]
> Only **kitty**, **zed**, **zsh**, **fastfetch** are to be used with GNU STOW.

Personal configuration files for:
- 😺 kitty
- ⚡ zed
- 🐚 zsh
- 🖼️ fastfetch

Manual setup:
- 🖥️ [konsole](konsole/README.md) <= guide
- 🌐 [tabliss](tabliss/README.md) <= guide
- 💬 [vencord](vencord/README.md) <= guide
- 🎵 [spicetify](spicetify/README.md) <= guide

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
   stow kitty zed zsh fastfetch
   ```

## 🔄 Updating

```
cd ~/.dotfiles
git pull
stow kitty zed zsh fastfetch
```
