#!/bin/bash

# ANSI escape кодови за боје
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'     # Плава за yay
MAGENTA='\033[0;35m'  # Љубичаста за pacman
NC='\033[0m' # Без боје

# Обавештење о дистрибуцији
echo -e "${RED}Ова скрипта је намењена за Arch Linux и деривативе (EndeavourOS, Manjaro, CachyOS, Artix Linux, RebornOS, Garuda Linux...).${NC}"

# Функција за провера да ли је пакет инсталиран
is_installed() {
    pacman -Q "$1" &> /dev/null || yay -Q "$1" &> /dev/null
}

# Функција за инсталацију пакета са pacman
install_pacman() {
    local packages=(
        audacious bitwarden bleachbit fastfetch firefox-developer-edition
        haruna kitty obsidian openrgb signal-desktop steam stow
        telegram-desktop zed zsh fzf spotify-launcher micro git starship fish
    )
    
    local to_install=()
    
    for pkg in "${packages[@]}"; do
        if ! is_installed "$pkg"; then
            to_install+=("$pkg")
        else
            echo -e "${GREEN}${pkg}${NC} је већ инсталиран."
        fi
    done

    if [ ${#to_install[@]} -eq 0 ]; then
        echo -e "${MAGENTA}Сви пакети са ${GREEN}PACMAN${NC} су већ инсталирани!${NC}"
        return
    fi

    echo -e "${MAGENTA}Инсталирање пакета са ${GREEN}PACMAN${NC}..."
    echo -e "${MAGENTA}Команда: ${GREEN}sudo pacman -Syu --noconfirm ${to_install[*]}${NC}"
    sudo pacman -Syu --noconfirm "${to_install[@]}"
    echo -e "${MAGENTA}Инсталација пакета са ${GREEN}PACMAN${NC} завршена!${NC}"
}

# Функција за инсталацију пакета са yay
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
            echo -e "${CYAN}${pkg}${NC} је већ инсталиран."
        fi
    done

    if [ ${#to_install[@]} -eq 0 ]; then
        echo -e "${CYAN}Сви пакети са ${CYAN}YAY${NC} су већ инсталирани!${NC}"
        return
    fi

    echo -e "${CYAN}Инсталирање пакета са ${CYAN}YAY${NC}..."
    echo -e "${CYAN}Команда: ${CYAN}yay -S --noconfirm ${to_install[*]}${NC}"
    yay -S --noconfirm "${to_install[@]}"
    echo -e "${CYAN}Инсталација пакета са ${CYAN}YAY${NC} завршена!${NC}"
}

# Питање корисника
echo -e "${YELLOW}Шта желите да инсталирате?${NC}"
echo -e "1. Само ${MAGENTA}PACMAN${NC} пакете"
echo -e "2. Само ${CYAN}YAY${NC} пакете"
echo -e "3. Пакете са ${MAGENTA}PACMAN${NC} и ${CYAN}YAY${NC}"
read -p "Избор (1/2/3): " izbor

case $izbor in
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
        echo -e "${RED}Непознати избор. Молим вас покушајте поново.${NC}"
        ;;
esac

echo -e "${GREEN}Инсталација завршена!${NC}"
