# Basic Commands for Arch Linux

---

[Српски (🇷🇸)](cmd.md) | [English (🇬🇧)](cmd-en.md)

---

## Navigation Commands

- **`cd directory_name`** - Change to a directory.
- **`cd ..`** - Go back to the parent directory.
- **`cd ~`** - Change to the home directory.
- **`pwd`** - Displays the current directory path.

## Kitty Terminal (Horizontal Division)

- **`Ctrl + Shift + e`** - Horizontal Division
- **`Ctrl + Shift + Enter`** - Horizontal Division
- **`Ctrl + Shift + s`** - Rotate the window
- **`Ctrl + Shift + left_arrow`** - Previous window
- **`Ctrl + Shift + right_arrow`** - Next window
- **`Ctrl + Shift + up_arrow`** - Top window
- **`Ctrl + Shift + down_arrow`** - Bottom window

## File and Directory Management

- **`mkdir directory_name`** - Create a new directory.
- **`touch file_name`** - Create an empty file.
- **`rm file_name`** - Remove a file.
- **`rmdir directory_name`** - Remove an empty directory.
- **`rm -r directory_name`** - Remove a directory and all its contents.
- **`cp source_file destination`** - Copy a file.
- **`mv source_file destination`** - Move or rename a file.

## System Updating

### pacman

- **`sudo pacman -Syu`** - Update the system.
- **`sudo pacman -S package_name`** - Install a package.
- **`sudo pacman -Rns package_name`** - Remove a package.
- **`pacman -Ss package_name`** - Search for a package.

### yay

- **`yay -Syu`** / **`yay`** - Update the system with `yay`.
- **`yay -S package_name`** - Install a package with `yay`.
- **`yay -Rns package_name`** - Remove a package with `yay`.
- **`yay -Ss package_name`** - Search for a packagewith `yay` .

## Service Management

- **`sudo systemctl start service_name`** - Start a service.
- **`sudo systemctl stop service_name`** - Stop a service.
- **`systemctl status service_name`** - Check the status of a service.
- **`sudo systemctl enable service_name`** - Enable a service to start automatically.

## Bluetooth Management

- **`sudo systemctl start bluetooth.service`** - Start the Bluetooth service.
- **`sudo systemctl stop bluetooth.service`** - Stop the Bluetooth service.
- **`sudo systemctl enable bluetooth.service`** - Enable the Bluetooth service to start automatically.
- **`bluetoothctl`** - Open Bluetooth control to manage devices. Within `bluetoothctl`:
  - **`power on`** - Turn on Bluetooth.
  - **`power off`** - Turn off Bluetooth.
  - **`scan on`** - Discover nearby devices.
  - **`pair [MAC address]`** - Pair with a device.

## Other Commands

- **`ls`** - Displays the content of directories with grouping of directories first, using `lsd --group-directories-first`.
- **`ls`** - Displays the content of directories with colors using `ls --color`.
- **`ncdu`** - Displays disk usage (install it with `sudo pacman -S ncdu`).
- **`df -h`** - Check disk space.
- **`free -h`** - Check memory.
- **`top`** - View active processes.
- **`htop`** - Advanced view of active processes (install it with `sudo pacman -S htop`).
- **`ip a`** - Displays information about network interfaces.
- **`btm`** - Cross-platform graphical process/system monitor. (install it with `sudo pacman -S bottom`)
- **`fzf`** A command-line fuzzy finder (install it with `sudo pacman -S fzf`)
  - **`CTRL + T`** - Activates `fzf` for any commands
    /
  - **`CTRL + R`** - `fzf` history
- **`bat`** - `cat` цлоне with syntax highlighting - a terminal file viewer (install it with `sudo pacman -S bat`)
- **`fuck`** - if a command is misstyped, by typing the `fuck` command, the command will be correctly written
- **`linutil`** - Utility for Linux systems by Chris Titus from GitHub - [`ChrisTitusTech/linutil`](https://github.com/ChrisTitusTech/linutil)
- **`ftn`** - Custom script that shows whether the week is even or odd
- **`cmd`** - Opens the `cmd.md` file in `bat` viewer with syntax highlighting
- **`catgit`** - Opens the Catppuccin GitHub page in Brave browser
- **`pasters`** - Script that uses the API of [paste.rs](https://paste.rs/)
- **`neovim`** / **`vim`** - Launches `nvim`, an alternative to Vim
- **`kolo`** - Script for searching Arch Linux depositories (AUR included)
- **`zed`** - Launches Zed Exitor
- **`crc`** - Custom script for compiling programs written in the `C` programming language using `gcc`
- **`entropy`** - Custom script for system cleanup
- **`gzdoom`** - Launches GZDoom
  - **`gzdoom name_of_wad`** - Launches GZDoom with WAD from `name_of_wad`
  - **`gzdoom name_of_pk3`** - Launches GZDoom with PK3 from `name_of_pk3`
- **`catbox`** - ./catbox.sh --help
- **`litterbox`** - ./litterbox.sh --help
- **`lama`** - ./lama.sh --help

## Commands for updating

- **`azu-eos`** - Update EndeavourOS with AUR

### Garuda Linux

- **`azu-gar`** - Update Garuda Linux

### Universal update

- **`zap`** - Custom script for updating the system with support for multiple operating systems

## DOOM / Eternal

- **`corrax`** - Mysterious program
- **`doom`** - Launches the program that displays DOOM Ghost
