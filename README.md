# 🪐 Dotfiles (GNU STOW)

---

  [Српски (🇷🇸)](README.md) | [English (🇬🇧)](README-en.md)

---

# 🐧

| Категорија         | Детаљи                                   | Друго                              |
|--------------------|------------------------------------------|------------------------------------------|
| **ОС**             | Arch Linux (EndeavourOS)                 | -                                        |
| **РО**             | KDE Plasma 6.1                           | -                                        |
| **Иконице**        | Papirus-Dark (Catppuccin Folders)        | -                                        |
| **Композитор**     | Wayland                                  | -                                        |
| **Шкољка**         | zsh (oh-my-zsh, Powerlevel10k тема)      | bash                                     |
| **Терминал**       | Kitty                                    | Alacritty , Konsole                      |
| **ИРО**            | VS Code                                  | Zed                                      |
| **Менаџер датотека** | Dolphin                                | Thunar                                   |
| **Прегледач**      | Brave                                    | Firefox Developer Edition                |



---

<br>

> [!IMPORTANT]
> За `zsh` прво пратите овај [**туторијал**](https://www.youtube.com/watch?v=ud7YxC33Z3w).

> [!NOTE]
> Само **kitty**, **zed**, **zsh**, **fastfetch**, **alacritty** су за коришћење уз помоћ GNU STOW.

> [!NOTE]
> [brave-maps](brave-maps) - За сада само за [`Chromium`](https://alternativeto.net/category/browsers/chromium-based/) претраживаче

# Скрипте:

## 📦 | Пакети

- 🇷🇸 | `pkg-rs.sh` - листа пакета/програма које користим
- 🇬🇧 | `pkg-en-sh` - list of packages/programs I use

```
Нема разлике измежу ове две скрипте само је једна на српском језику а друга на енглском.

Ако желите да додате/уклоните неки пакет/програм само ужите у скрипту са језиком по важем избоу и и змените је.
```

## 🔄 | Git

- `push.sh` - прилагођена `push` скрипта за моје `dotfiles`
- `pull.sh` - прилагођена `pull` скрипта за моје `dotfiles`

# GNU Stow | Личне конфигурацијске датотеке за:
- 😺 | `kitty` (Mocha Green, Mocha Purple, Tokyo Night)
- ⚡ | `zed`
- 🐚 | `zsh`
- 🖼️ | `fastfetch`
- 🌴 | `alacritty`

# Ручно:
- 🖥️ | [`kde`](kde/README.md) <= упутство
- 🌐 | [`tabliss`](tabliss/README.md) <= упутство
- 💬 | [`vencord`](vencord/README.md) <= упутство
- 🎵 | [`spicetify`](spicetify/README.md) <= упутство
- 🐇 | [`mangadex`](mangadex/README.md) <= упутство
- 🐈 | [`miruro`](miruro/README.md) <= упутство
- 🐒 | [`violentmonkey`](violentmonkey/README.md) <= упутство
- 🦊 | [`firefox`](firefox/README.md) <= упутство
- ⚛️ | [`cobaltium`](https://github.com/crnobog69/cobaltium) <= упутство
- 🦁 | [`brave`](brave/README.md) <= упутство
- 🗺️ | [`brave-maps`](brave-maps) <= упутство (исто као [`cobaltium`](https://github.com/crnobog69/cobaltium))
- 🧰 | [`assets`](assets/) - слике и иконице и остало

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

   или (једно)

   ```
   cd ~/.dofiles
   stow zed
   ```

## 🔄 Ажурирање

```
cd ~/.dotfiles
git pull
```

## 🪐 Остало

- 😺 | [Catppuccin](https://github.com/catppuccin)
- 🗼 | [Tokyo Night](https://github.com/tokyo-night)
- 🗺️ | [Brave Maps](https://github.com/stignarnia/add-maps-links-brave-search)
- 🐇 | [MangaDex](https://github.com/crnobog69/mangadex)
- 🐈 | [Miruro](https://github.com/crnobog69/miruro-catppuccin)
- 🎵 | [Spicetify](https://github.com/spicetify/cli)
- ⚛️ | [Cobaltium](https://github.com/crnobog69/cobaltium)
- 🐒 | [Violentmonkey](https://github.com/crnobog69/violentmonkey-mocha)
- 🦊 | [Crnobog - Творац/Ја](https://github.com/crnobog69)

<br>

---