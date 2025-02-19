#!/bin/bash

# Функција за боје
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
LAVANDER="\033[38;2;180;191;254m"
NC="\e[0m" # Без боје

# Check if Gum is installed
if ! command -v gum &> /dev/null; then
    echo "Gum is not installed. Please install it first."
    exit 1
fi

# ASCII банер
echo -e "${RED}"
echo =============================================
echo "[  _  _  ____  _  _   __  ____   __   ____  ]"
echo "[ / \( \(  _ \/ )( \ /  \(  __) /  \ /  __) ]"
echo "[ ) (/ ( ) __/) __ ((  O )) _ \(  O )) (    ]"
echo "[ \___\/(__)  \_)(_/ \__/(____/ \__/ \_/    ]"
echo =============================================
echo -e "${RED}[${NC}===${LAVANDER} 󰻀 | Скрипта за чишћење система ${NC}========${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${NC}"

# Функција за проверу грешака
check_error() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Грешка: $1${NC}"
        return 1
    fi
    return 0
}

if ! gum confirm --prompt.foreground="#f9e2af" --selected.background="#e78284" --unselected.background="#b4befe" "Да ли желите да покренете чишћење система?"; then
    echo -e "${RED}Чишћење је отказано.${NC}"
    exit 1
fi
echo -e "${GREEN} Чишћење система је покренуто...${NC}"

echo

# Избор опције за чишћење
choice=$(gum choose\
    --header=" Избор:" \
    --item.foreground="#b4befe" \
    --cursor.foreground="#e78284" \
    --header.foreground="#f9e2af" \
    --selected.foreground="#b4befe" \
    " Менаџери пакета + Програми" \
    " Само Менаџери пакета" \
    "󰻀 Само Програми" \
    "󰈆 Излаз")
echo "$(gum style --foreground "#f9e2af" "Изабрана опција: $choice")"

echo

if [ "$choice" == "󰈆 Излаз" ]; then
    exit 1;
fi

if [ "$choice" != "󰻀 Само Програми" ]; then
    echo ===========================================================================
    echo -e "${RED}  ${NC}${GREEN}Чишћење система...${NC}"
    echo ===========================================================================

    echo

    echo -e "=== ${RED}󰏖 | Менаџери пакета ${NC} =================================================="

    echo

    echo -e "${GREEN} Чишћење кеша Pacman...${NC}"
    sudo pacman -Sc --noconfirm

    echo -e "${GREEN} Чишћење кеша yay...${NC}"
    yay -Sc --noconfirm

    echo -e "${GREEN} Уклањање неупотребљених зависности yay...${NC}"
    yay -Yc --noconfirm

    echo
fi

echo

if [ "$choice" != " Само Менаџери пакета" ]; then
    echo -e "=== ${RED}󰂺 | Дневник${NC} ==========================================================="  

    echo

    echo -e "${YELLOW} Величина /var/log/journal директоријума пре чишћења:${NC}"
    du -sh /var/log/journal | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "${GREEN} Чишћење journal логова старијих од 2 недеље...${NC}"
    sudo journalctl --vacuum-time=2weeks

    echo 

    echo -e "${YELLOW} Величина /var/log/journal директоријума:${NC}"
    du -sh /var/log/journal | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "=== ${RED}󰃨 | Кеш${NC} ==============================================================="

    echo

    echo -e "${YELLOW} Величина ~/.cache директоријума пре чишћења:${NC}"
    du -sh ~/.cache | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "${GREEN} Брисање корисничког кеша...${NC}"
    rm -rf ~/.cache/*

    echo

    echo -e "${YELLOW} Величина ~/.cache директоријума:${NC}"
    du -sh ~/.cache | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "=== ${RED} | Brave${NC} ============================================================="

    echo

    if [ -d ~/.config/BraveSoftware/Brave-Browser/Default/Service\ Worker/CacheStorage/ ]; then
        echo -e "${YELLOW} Величина кеша Brave:${NC}"
        du -sh ~/.config/BraveSoftware/Brave-Browser/Default/Service\ Worker/CacheStorage/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        echo
        echo -e "${GREEN} Брисање кеша Brave...${NC}"
        rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/Service\ Worker/CacheStorage/*
        echo
        echo -e "${YELLOW} Величина кеша Brave:${NC}"
        du -sh ~/.config/BraveSoftware/Brave-Browser/Default/Service\ Worker/CacheStorage/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
    else
        echo -e "${RED}Brave није инсталиран${NC}"
    fi

    echo

    echo -e "=== ${RED} | Vesktop${NC} ==========================================================="

    echo

    if [ -d ~/.config/vesktop/sessionData/ ]; then
        echo -e "${YELLOW} Величина кеша Vesktop:${NC}"
        du -sh ~/.config/vesktop/sessionData/Cache/Cache_Data/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        du -sh ~/.config/vesktop/sessionData/Code\ Cache/js/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        echo
        echo -e "${GREEN} Брисање кеша Vesktop...${NC}"
        rm -rf ~/.config/vesktop/sessionData/Cache/Cache_Data/*
        rm -rf ~/.config/vesktop/sessionData/Code\ Cache/js/*
        echo
        echo -e "${YELLOW} Величина кеша Vesktop:${NC}"
        du -sh ~/.config/vesktop/sessionData/Cache/Cache_Data/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        du -sh ~/.config/vesktop/sessionData/Code\ Cache/js/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
    else
        echo -e "${RED} Vesktop није инсталиран${NC}"
    fi

    echo

    echo -e "=== ${RED}󰨞 | VS Code${NC} ==========================================================="

    echo

    if [ -d ~/.config/Code/CachedData/ ]; then
        echo -e "${YELLOW} Величина кеша VS Code:${NC}"
        du -sh ~/.config/Code/CachedData/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        echo
        echo -e "${GREEN} Брисање кеша VS Code...${NC}"
        rm -rf ~/.config/Code/CachedData/*
        echo
        echo -e "${YELLOW} Величина кеша VS Code:${NC}"
        du -sh ~/.config/Code/CachedData/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
    else
        echo -e "${RED} VS Code није инсталиран${NC}"
    fi

    echo

    echo -e "=== ${RED}󰇀 | Cursor${NC} ============================================================"

    echo

    if [ -d ~/.config/Cursor/CachedData/ ]; then
        echo -e "${YELLOW} Величина кеша Cursor:${NC}"
        du -sh ~/.config/Cursor/CachedData/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        echo
        echo -e "${GREEN} Брисање кеша Cursor...${NC}"
        rm -rf ~/.config/Cursor/CachedData/*
        echo
        echo -e "${YELLOW} Величина кеша Cursor:${NC}"
        du -sh ~/.config/Cursor/CachedData/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
    else
        echo -e "${RED} Cursor није инсталиран${NC}"
    fi

    echo

    echo -e "=== ${RED} | Bun${NC} ==============================================================="

    echo

    if [ -d ~/.bun/install/cache ]; then
        echo -e "${YELLOW} Величина кеша Bun:${NC}"
        du -sh ~/.bun/install/cache/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        echo
        echo -e "${GREEN} Брисање кеша Bun...${NC}"
        rm -rf ~/.bun/install/cache/*
        echo
        echo -e "${YELLOW} Величина кеша Bun:${NC}"
        du -sh ~/.bun/install/cache/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
    else
        echo -e "${RED} Bun није инсталиран${NC}"
    fi
    echo

    echo -e "=== ${RED} | Gradle${NC} ============================================================"

    echo

    if [ -d ~/.gradle/ ]; then
        echo -e "${YELLOW} Величина кеша и врапера Gradle:${NC}"
        du -sh ~/.gradle/caches/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        du -sh ~/.gradle/wrapper/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        echo
        echo -e "${GREEN} Брисање кеша и врапера Gradle...${NC}"
        rm -rf ~/.gradle/caches/*
        rm -rf ~/.gradle/wrapper/*
        echo
        echo -e "${YELLOW} Величина кеша и врапера Gradle:${NC}"
        du -sh ~/.gradle/caches/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
        du -sh ~/.gradle/wrapper/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'
    else
        echo -e "${RED}Gradle није инсталиран${NC}"
    fi

    echo

    echo -e "=== ${RED} | Канта${NC} ============================================================="

    echo 

    echo -e "${YELLOW} Величина канте пре чишћења:${NC}"
    du -sh ~/.local/share/Trash/files/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    rm -rf ~/.local/share/Trash/files/*

    echo

    echo -e "${YELLOW} Величина канте након чишћења:${NC}"
    du -sh ~/.local/share/Trash/files/ | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "=== ${RED} | Остало${NC} ============================================================"


    echo

    echo -e "${YELLOW} Величина ~/.config директоријума:${NC}"
    du -sh ~/.config | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "${YELLOW} Величина ~/.local директоријума:${NC}"
    du -sh ~/.local | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo

    echo -e "${YELLOW} Величина ~/.cargo директоријума:${NC}"
    du -sh ~/.cargo | awk '{print " \033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

    echo
fi

echo

echo ===========================================================================
echo -e "${RED}  ${NC}${GREEN}Чишћење је завршено!${NC}"
echo ===========================================================================