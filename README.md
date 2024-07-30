# 🏠 Dotfiles (GNU STOW)

> [!NOTE]
> Само **kitty**, **zed**, **zsh**, **fastfetch** су за коришћење уз помоћ GNU STOW.

Личне конфигурацијске датотеке за:
- 😺 kitty
- ⚡ zed
- 🐚 zsh
- 🖼️ fastfetch

Ручно:
- 🖥️ [konsole](konsole/README.md) - водич
- 🌐 [tabliss](tabliss/README.md) - воидч
- 💬 [vencord](vencord.README.md) - водич
- 🎵 [spicetify](spicetify/README.md) - водич

## 🛠️ Постављање

1. Преузмите GNU Stow (Arch Linux):
   ```
   sudo pacman -S stow
   ```

3. Клонирање:
   ```
   git clone https://github.com/crnobog69/dotfiles.git
   ```

4. Примена конфигурација:
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
