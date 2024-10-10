# Основне команде за Arch Linux

---

  [Српски (🇷🇸)](cmd.md) | [English (🇬🇧)](cmd-en.md)

---

## Команде за навигацију
- **`cd ime_direktorijuma`** - Прелазак у директоријум.
- **`cd ..`** - Враћање у родитељски директоријум.
- **`cd ~`** - Прелазак у кућни директоријум.
- **`pwd`** - Приказује путању тренутног директоријума.

## Управљање датотекама и директоријумимаса `yay`
- **`mkdir ime_direktorijuma`** - Креира нови директоријум.
- **`touch ime_datoteke`** - Креира празну датотеку.
- **`rm ime_datoteke`** - Уклања датотеку.
- **`rmdir ime_direktorijuma`** - Уклања празан директоријум.
- **`rm -r ime_direktorijuma`** - Уклања директоријум и све његове садржаје.
- **`cp izvor-datoteka odredište`** - Копира датотеку.
- **`mv izvor-datoteka odredište`** - Премешта или преименује датотеку.

## Ажурирање система

### pacman

- **`sudo pacman -Syu`** - Ажурирање система.
- **`sudo pacman -S ime_paketa`** - Инсталирање пакета.
- **`sudo pacman -Rns ime_paketa`** - Уклањање пакета.
- **`pacman -Ss ime_paketa`** - Претрага пакета.
### yay

- **`yay -Syu`**/**`yay`** - Ажурирање система са `yay`.
- **`yay -S ime_paketa`** - Инсталирање пакета са `yay`.
- **`yay -Rns ime_paketa`** - Уклањање пакета са `yay`.
- **`yay -Ss ime_paketa`** - Претрага пакета са `yay`.

## Управљање услугама
- **`sudo systemctl start ime_usluge`** - Покретање услуге.
- **`sudo systemctl stop ime_usluge`** - Заустављање услуге.
- **`systemctl status ime_usluge`** - Провера статуса услуге.
- **`sudo systemctl enable ime_usluge`** - Додавање услуге у аутоматско покретање.

## Управљање Bluetooth-ом
- **`sudo systemctl start bluetooth.service`** - Покретање Bluetooth услуге.
- **`sudo systemctl stop bluetooth.service`** - Заустављање Bluetooth услуге.
- **`sudo systemctl enable bluetooth.service`** - Додавање Bluetooth услуге у аутоматско покретање.
- **`bluetoothctl`** - Отвара Bluetooth контролу за управљање уређајима. Унутар `bluetoothctl`:
  - **`power on`** - Укључите Bluetooth.
  - **`power off`** - Искључите Bluetooth.
  - **`scan on`** - Појављивање уређаја у близини.
  - **`pair [MAC адреса]`** - Постављање везе са уређајем.

## Остале команде
- **`ncdu`** - Приказује корисност дисковног простора (инсталирајте га са `sudo pacman -S ncdu`).
- **`df -h`** - Провера дисковног простора.
- **`free -h`** - Провера меморије.
- **`top`** - Преглед активних процеса.
- **`htop`** - Напредни преглед активних процеса (инсталирајте га са `sudo pacman -S htop`).
- **`ip a`** - Приказује информације о мрежним интерфејсима.
- **`btm`** - Вишеплатфорски графички монитор процеса/система. (инсталирајте га са `sudo pacman -S bottom`)
- **`fzf`** - Претраживач за командну линију
  - **`CTRL + T`** - Активирање `fzf`-а за било коју команду
  /
  - **`any_command ** + **`TAB`** - Напишите `**` (две звездице) и притисните `TAB`, и активираће се `fzf`.

## Прилагођене команде
- **`ftn`** - Прилагођена скрипта која приказује да ли је недеља парна или непарна
- **`azu`** - Скраћеница за `eos-update --aur`
- **`linutil`** - Алчатка за Linux системе од Крис Тајтуса Github - [`ChrisTitusTech/linutil`](https://github.com/ChrisTitusTech/linutil).
