# 🪐 Dotfiles (GNU STOW)

---

  [Српски (🇷🇸)](README.md) | [English (🇬🇧)](README-en.md)

---

# Табела садржаја:

- ## 📜 | [Скрипте](#скрипте)
- ## 🗼 | [Личне конфигурацијске датотеке | GNU Stow](#личне-конфигурацијске-датотеке)
- ## 🪐 | [Остало](#остало)

---

# 🐧

| Категорија         | Детаљи                                   | Друго                              |
|--------------------|------------------------------------------|------------------------------------------|
| **ОС**             | Arch Linux (EndeavourOS)                 | Windows 11                               |
| **РО**             | KDE Plasma 6.2                           | -                                        |
| **Иконице**        | Прилагођене Papirus-Dark - [Catppuccin Latte Lavender Folders](https://github.com/catppuccin/papirus-folders)        | -                                        |
| **Композитор**     | Wayland                                  | -                                        |
| **Шкољка**         | zsh (oh-my-zsh, Starship, Powerlevel10k тема*)| fish, bash                                     |
| **Промт**          | Starship                                 |                                          |
| **Терминал**       | Kitty                                    | Alacritty, Konsole                      |
| **ИРО**            | VS Codium, VS Code, micro                | Zed                                      |
| **Менаџер датотека** | Dolphin                                | Thunar                                   |
| **Прегледач**      | Brave                                    | Firefox Developer Edition                |



---

<br>

> [!IMPORTANT]
> За `zsh` прво пратите овај [**туторијал**](https://www.youtube.com/watch?v=ud7YxC33Z3w).

> [!NOTE]
> Само **kitty**, **micro**, **zed**, **zsh**, **fastfetch**, **alacritty**, **transparency.toggle**, **plasmusic-toolbar**, **zayron.simple.separator**, **apdatifier**,**bottom**, **fish**, **cava**, **bat** и **starship** су за коришћење уз помоћ GNU STOW.

> [!NOTE]
> [brave-maps](brave-maps) - За сада само за [`Chromium`](https://alternativeto.net/category/browsers/chromium-based/) претраживаче

---

# Скрипте:

## Linux

Прво морате да дате дозволу скрипти/ама:

```
chmod +x scripts/pkg-rs.sh
```

```
chmod +x scripts/pkg-en.sh
```

```
chmod +x scripts/ftn.sh
```

```
chmod +x push.sh
```

```
chmod +x pull.sh
```

## Windows

### Power Shell

```
Set-ExecutionPolicy RemoteSigned
```

### CMD (Админинстратор)

```
powershell -Command "Set-ExecutionPolicy RemoteSigned"
```

## 📦 | Пакети

У [`scripts`](scripts).

- 🇷🇸 | `pkg-rs.sh` - листа пакета/програма које користим
- 🇬🇧 | `pkg-en-sh` - list of packages/programs I use


> [!NOTE]
> Нема разлике између ове **две скрипте** само је једна на **српском** језику а друга на **енглском** језику.
> <br>
> Ако желите да **додате/уклоните** неки **пакет/програм** само **уђите** у скрипту (у скрипту са **језиком** којим сте изабрали) са **уређивачем текста** по вашем избору и **измените је**.

## 🔄 | Git

- `push.sh` - прилагођена `pull`/`push` скрипта за моје `dotfiles`
- `pull.sh` - прилагођена `pull` скрипта за моје `dotfiles`
- `push.ps1` - прилагођена `pull`/`push` скрипта (Windows)
- `pull.ps1` - прилагођена `pull` скрипта (Windows)

## 🐧 | Остало

> [!NOTE]  
> `ftn` - означава ***Факултет Техничких Наука***.

- `ftn.sh` - прилагођена скрипта која приказује да ли је недеља парна или непарна
- `ftn.ps1` - прилагођена скрипта која приказује да ли је недеља парна или непарна (Windows)
- [`vhs.sh`](scripts/vhs/README.md) - Скрипта за обраду видеа (у `scripts/vhs`)
- `pasters` - скрипта која користи API од [paste.rs](https://paste.rs/)

---

# Личне конфигурацијске датотеке:

`GNU Stow`

- 😺 | `kitty` (Mocha Green, Mocha Purple, Tokyo Night)
- 🖋️ | `micro` (Mocha Transparent, Mocha)
- ⚡ | `zed`
- 🐚 | `zsh`
- 🖼️ | `fastfetch`
- 🌴 | `alacritty`
- 🚀 | `starship`
- 🐟 | `fish`
- 🥺 | `bottom`
- 📢 | `cava`
- 🦇️ | `bat`
- 🐧 | `transparency.toggle`, `plasmusic-toolbar`, `zayron.simple.separator`, `apdatifier`


## Ручно:
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
- 📝 | [`notesnook`](notesnook/README.md)
- 🧰 | [`assets`](assets/) - слике и иконице и остало

## Остало
- 📰 | [`cmd`](cmd/cmd.md) - Основне команде за Arch Linux

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
   stow kitty-cat-green zed zsh fastfetch micro starship fish bottom cava bat
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

---

# Остало

- 😺 | [Catppuccin](https://github.com/catppuccin)
- 🗼 | [Tokyo Night](https://github.com/tokyo-night)
- 🗺️ | [Brave Maps](https://github.com/stignarnia/add-maps-links-brave-search)
- 🐇 | [MangaDex](https://github.com/crnobog69/mangadex)
- 🐈 | [Miruro](https://github.com/crnobog69/miruro-catppuccin)
- 🎵 | [Spicetify](https://github.com/spicetify/cli)
- ⚛️ | [Cobaltium](https://github.com/crnobog69/cobaltium)
- 📝 | [Notesnook](https://github.com/crnobog69/notesnook)
- 🦀 | [pasters](https://github.com/crnobog69/pasters-terminal)
- 🐒 | [Violentmonkey](https://github.com/crnobog69/violentmonkey-mocha)
- 🦊 | [Crnobog - Творац/Ја](https://github.com/crnobog69)


<br>

Репозиторијуми:

🐙 | [`Github | Репозиторијум`](https://github.com/crnobog69/dotfiles)

🏔️ | [`Codeberg | Репозиторијум`](https://codeberg.org/crnobog/dotfiles)

🦊 | [`GitLab | Репозиторијум`](https://gitlab.com/crnobog/dotfiles)

<br>

---
