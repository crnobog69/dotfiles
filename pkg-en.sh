#!/bin/bash

# ANSI escape codes for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'     # Blue for yay
MAGENTA='\033[0;35m'  # Magenta for pacman
NC='\033[0m' # No color

# Distribution notice
echo -e "${RED}This script is intended for Arch Linux and derivatives (EndeavourOS, Manjaro, CachyOS, Artix Linux, RebornOS, Garuda Linux...).${NC}"

# Function to check if a package is installed
is_installed() {
    pacman -Q "$1" &> /dev/null || yay -Q "$1" &> /dev/null
}

# Function to install packages with pacman
install_pacman() {
    local packages=(
        audacious bitwarden bleachbit fastfetch firefox-developer-edition
        haruna kitty obsidian openrgb signal-desktop steam stow
        telegram-desktop zed zsh fzf spotify-launcher micro git starship
    )
    
    local to_install=()
    
    for pkg in "${packages[@]}"; do
        if ! is_installed "$pkg"; then
            to_install+=("$pkg")
        else
            echo -e "${GREEN}${pkg}${NC} is already installed."
        fi
    done

    if [ ${#to_install[@]} -eq 0 ]; then
        echo -e "${MAGENTA}All ${GREEN}PACMAN${NC} packages are already installed!${NC}"
        return
    fi

    echo -e "${MAGENTA}Installing packages with ${GREEN}PACMAN${NC}..."
    echo -e "${MAGENTA}Command: ${GREEN}sudo pacman -Syu --noconfirm ${to_install[*]}${NC}"
    sudo pacman -Syu --noconfirm "${to_install[@]}"
    echo -e "${MAGENTA}Installation of packages with ${GREEN}PACMAN${NC} completed!${NC}"
}

# Function to install packages with yay
install_yay() {
    local packages=(
        brave-bin coolercontrol element-desktop vscodium-bin ani-cli
        syncthingtray vesktop-bin portmaster-stub-bin spicetify-cli cava
    )

    local to_install=()
    
    for pkg in "${packages[@]}"; do
        if ! is_installed "$pkg"; then
            to_install+=("$pkg")
        else
            echo -e "${CYAN}${pkg}${NC} is already installed."
        fi
    done

    if [ ${#to_install[@]} -eq 0 ]; then
        echo -e "${CYAN}All ${CYAN}YAY${NC} packages are already installed!${NC}"
        return
    fi

    echo -e "${CYAN}Installing packages with ${CYAN}YAY${NC}..."
    echo -e "${CYAN}Command: ${CYAN}yay -S --noconfirm ${to_install[*]}${NC}"
    yay -S --noconfirm "${to_install[@]}"
    echo -e "${CYAN}Installation of packages with ${CYAN}YAY${NC} completed!${NC}"
}

# User prompt
echo -e "${YELLOW}What would you like to install?${NC}"
echo -e "1. Only ${MAGENTA}PACMAN${NC} packages"
echo -e "2. Only ${CYAN}YAY${NC} packages"
echo -e "3. Packages with ${MAGENTA}PACMAN${NC} and ${CYAN}YAY${NC}"
read -p "Choice (1/2/3): " choice

case $choice in
    1)
        install_pacman
        ;;
    2)
        install_yay
        ;;
    3)
        install_pacman
        install_yay
        ;;
    *)
        echo -e "${RED}Unknown choice. Please try again.${NC}"
        ;;
esac

echo -e "${GREEN}Installation complete!${NC}"
