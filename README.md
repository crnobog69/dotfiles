# 🏠 Dotfiles (GNU STOW)

> [!NOTE]
> Само **kitty**, **zed**, **zsh**, **fastfetch** су за коришћење уз помоћ GNU STOW.

Личне конфигурацијске датотеке за:
- 😺 kitty
- ⚡ zed
- 🐚 zsh
- 🖼️ fastfetch

Ручно:
- 🖥️ [konsole](konsole/README.md)
- 🌐 [tabliss](tabliss/README.md)
- 💬 [vencord](vencord.README.md)
- 🎵 [spicetify](spicetify/README.md)

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
