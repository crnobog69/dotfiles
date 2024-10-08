# Basic Commands for Arch Linux

---

  [Српски (🇷🇸)](cmd.md) | [English (🇬🇧)](cmd-en.md)

---

## Navigation Commands
- **`cd directory_name`** - Change to a directory.
- **`cd ..`** - Go back to the parent directory.
- **`cd ~`** - Change to the home directory.
- **`pwd`** - Displays the current directory path.

## File and Directory Management
- **`mkdir directory_name`** - Create a new directory.
- **`touch file_name`** - Create an empty file.
- **`rm file_name`** - Remove a file.
- **`rmdir directory_name`** - Remove an empty directory.
- **`rm -r directory_name`** - Remove a directory and all its contents.
- **`cp source_file destination`** - Copy a file.
- **`mv source_file destination`** - Move or rename a file.

## System Updating
- **`sudo pacman -Syu`** - Update the system.
- **`sudo pacman -S package_name`** - Install a package.
- **`sudo pacman -Rns package_name`** - Remove a package.
- **`pacman -Ss package_name`** - Search for a package.
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
- **`ncdu`** - Displays disk usage (install it with `sudo pacman -S ncdu`).
- **`df -h`** - Check disk space.
- **`free -h`** - Check memory.
- **`top`** - View active processes.
- **`htop`** - Advanced view of active processes (install it with `sudo pacman -S htop`).
- **`ip a`** - Displays information about network interfaces.

## Custom Commands
- **`ftn`** - Custom script that shows whether the week is even or odd.
- **`azu`** - Shortcut for `eos-update --aur`.
- **`linutil`** - Utility for Linux systems by Chris Titus from GitHub - [`ChrisTitusTech/linutil`](https://github.com/ChrisTitusTech/linutil).
