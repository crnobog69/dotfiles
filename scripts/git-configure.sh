#!/bin/bash

# Провера захтева
check_requirements() {
    local required_commands=("git" "stow" "curl" "wl-copy")
    
    # Провера sudo привилегија
    if ! sudo -v &>/dev/null; then
        echo -e "${RED}Грешка: Ова скрипта захтева sudo привилегије${NC}"
        exit 1
    fi

    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo -e "${RED}Инсталирање ${cmd}...${NC}"
            if [ "$cmd" = "wl-copy" ]; then
                if ! sudo pacman -S --noconfirm wl-clipboard; then
                    echo -e "${RED}Неуспешна инсталација wl-clipboard${NC}"
                    exit 1
                fi
            else
                if ! sudo pacman -S --noconfirm "$cmd"; then
                    echo -e "${RED}Неуспешна инсталација ${cmd}${NC}"
                    exit 1
                fi
            fi
            echo -e "${GREEN}Успешно инсталиран ${cmd}${NC}"
        fi
    done
}

# Главно
check_requirements

# Постављање корисничког имена и email-а за Git
git config --global user.name "crnobog"
git config --global user.email "carskalavra@proton.me"

# Потврда конфигурације
echo "Git конфигурација је завршена."
git config --list

## SSH кључ

echo -e "SSH кључ"

ssh-keygen -t rsa -b 4096 -C "carskalavra@proton.me"

cat ~/.ssh/id_rsa.pub