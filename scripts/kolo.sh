#!/bin/bash

# Функција за проналажење доступног AUR хелпера
find_aur_helper() {
    if command -v yay &> /dev/null; then
        echo "yay"
    elif command -v paru &> /dev/null; then
        echo "paru"
    elif command -v pikaur &> /dev/null; then
        echo "pikaur"
    elif command -v trizen &> /dev/null; then
        echo "trizen"
    elif command -v aura &> /dev/null; then
        echo "aura"
    else
        echo ""
    fi
}

# Подеси да ли користимо AUR на основу аргумената
USE_AUR=false
if [[ "$1" == "--aur" ]]; then
    USE_AUR=true
fi

# Подешавање менаџера пакета
if $USE_AUR; then
    PACKAGE_MANAGER=$(find_aur_helper)
    if [[ -z "$PACKAGE_MANAGER" ]]; then
        echo "Није пронађен ниједан AUR хелпер."
        exit 1
    fi
else
    PACKAGE_MANAGER="pacman"
fi

# Претражи пакете у зависности од менаџера пакета
if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
    selected_package=$(pacman -Sl | fzf --prompt="Претрага пакета: " --preview="pacman -Si {2}" --preview-window=right:50% | awk '{print $2}')
else
    selected_package=$($PACKAGE_MANAGER -Sl | fzf --prompt="Претрага пакета (AUR укључен): " --preview="$PACKAGE_MANAGER -Si {2}" --preview-window=right:50% | awk '{print $2}')
fi

# Ако је пакет изабран, пита корисника да ли жели да га инсталира
if [[ -n "$selected_package" ]]; then
    read -p "Желите ли да инсталирате пакет '$selected_package'? (Y/n): " choice
    choice=${choice:-y}  # Ако је унос празан, подразумевано је "y"
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        sudo $PACKAGE_MANAGER -S "$selected_package"
    else
        echo "Инсталација отказана."
    fi
else
    echo "Није изабран ниједан пакет."
fi
