#!/bin/bash

# Скрипта за чишћење смећа | Script for trash

# Функција за боје
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
LAVANDER="\033[38;2;180;191;254m"
NC="\e[0m" # Без боје

# ASCII банер
echo -e "${RED}"
echo =============================================
echo "[  _  _  ____  _  _   __  ____   __   ____  ]"
echo "[ / \( \(  _ \/ )( \ /  \(  __) /  \ /  __) ]"
echo "[ ) (/ ( ) __/) __ ((  O )) _ \(  O )) (    ]"
echo "[ \___\/(__)  \_)(_/ \__/(____/ \__/ \_/    ]"
echo =============================================
echo -e "${RED}[${NC}===${LAVANDER} 󰻀 | Скрипта за чишћење канте ${NC}==========${RED}]${NC}"
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

echo -e "=== ${RED} | Канта${NC} ============================================================="

echo 

echo -e "${YELLOW}Величина канте пре чишћења:${NC}"
du -sh ~/.local/share/Trash/files/ | awk '{print "\033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

rm -rf ~/.local/share/Trash/files/*

echo

echo -e "${YELLOW}Величина канте након чишћења:${NC}"
du -sh ~/.local/share/Trash/files/ | awk '{print "\033[31m"$1"\033[0m \033[38;2;180;191;254m"$2"\033[0m"}'

echo

echo -e "==========================================================================="