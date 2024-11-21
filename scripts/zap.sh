#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
LAVANDER="\033[38;2;180;191;254m"
CYAN="\e[36m"
PEACH='\033[38;2;250;183;135m'
PURPLE='\033[38;2;150;50;200m'
NC="\e[0m" # Без боје

echo -e "${RED}"
echo =============================================
echo "[  _  _  ____  _  _   __  ____   __   ____  ]"
echo "[ / \( \(  _ \/ )( \ /  \(  __) /  \ /  __) ]"
echo "[ ) (/ ( ) __/) __ ((  O )) _ \(  O )) (    ]"
echo "[ \___\/(__)  \_)(_/ \__/(____/ \__/ \_/    ]"
echo =============================================
echo -e "${RED}[${NC}${LAVANDER}=== 󰻀 | Скрипта за ажурирање система ${NC}======${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${RED}[${NC}=== ${LAVANDER}--help | за помоћ${NC} =====================${RED}]${NC}"
echo -e "${RED}============================================="
echo -e "${NC}"

if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo "Нема интернет конекције"
    exit 1
fi

# Функција за проверу грешака
check_error() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Грешка: $1${NC}"
        return 1
    fi
    return 0
}

# Проверите ако је скрипта позвана са --help аргументом
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo -e "${GREEN}  Коришћење${NC}: ${RED}./zap.sh${NC} ${GREEN}[опције]${NC}"
    echo
    echo -e "${RED} Доступне опције:${NC}"
    echo -e "  --help, -h      Прикажи ову помоћ"
    echo
    echo -e "${RED} Ова скрипта служи за ажурирање система.${NC}" 
    echo
    echo === Подржани системи ====================
    echo
    echo -e "=== ${CYAN}Arch Linux${NC} породица:"
    echo -e "${CYAN}󰣇 ${NC}Arch Linux"
    echo -e "${CYAN}󰣇 ${NC}Arch Linux ARM"
    echo -e "${CYAN} ${NC}Garuda Linux"
    echo -e "${CYAN} ${NC}Garuda Linux Arm"
    echo -e "${CYAN} ${NC}EndeavourOS"
    echo -e "${CYAN} ${NC}EndeavourOS Arm"
    echo -e "${CYAN} ${NC}Archcraft Linux"
    echo -e "${CYAN}󰣇 ${NC}BlackArch Linux"
    echo -e "${CYAN}󰣇 ${NC}BlackArch Linux ARM"
    echo
    echo -e "=== ${RED}Debian${NC} породица:"
    echo -e "${RED} ${NC}Debian"
    echo -e "${RED} ${NC}Kali Linux"
    echo -e "${RED} ${NC}Ubuntu"
    echo -e "${RED}󰣭 ${NC}Linux Mint"
    echo -e "${RED} ${NC}Pop!_OS"
    echo -e "${RED} ${NC}elementary OS"
    echo -e "${RED} ${NC}deepin"
    echo -e "${RED} ${NC}Parrot Security OS"
    echo -e "${RED} ${NC}BackBox Linux"
    echo
    echo -e "=== ${PEACH}Red Hat${NC} породица:"
    echo -e "${PEACH} ${NC}Fedora"
    echo -e "${PEACH} ${NC}Fedora Workstation"
    echo -e "${PEACH} ${NC}Fedora Silverblue"
    echo -e "${PEACH} ${NC}CentOS Linux"
    echo -e "${PEACH} ${NC}CentOS Stream"
    echo -e "${PEACH} ${NC}Rocky Linux"
    echo -e "${PEACH} ${NC}AlmaLinux"
    echo -e "${PEACH} ${NC}Oracle Linux"
    echo -e "${PEACH} ${NC}Red Hat Enterprise Linux (RHEL)"
    echo
    echo -e "=== ${GREEN}openSUSE / SUSE${NC} породица:"
    echo -e "${GREEN} ${NC}openSUSE Leap"
    echo -e "${GREEN} ${NC}SUSE Linux Enterprise Server (SLES)"
    echo
    echo -e "=== ${PURPLE}Самосталне дистрибуције${NC}:" 
    echo -e "${PURPLE} ${NC}Alpine Linux"
    echo -e "${PURPLE}󱄅 ${NC}NixOS"
    echo -e "${PURPLE} ${NC}Void Linux"
    echo -e "${PURPLE} ${NC}Gentoo Linux"

    echo
    echo "========================================="
    exit 0
fi

# Питање за ажурирање система
read -p "Да ли желите да ажурирате систем? (y/n): " update_answer

# Ако је одговор y/Y, покрените одговарајући алат за ажурирање
if [[ -z "$update_answer" || "$update_answer" =~ ^[Yy]$ ]]; then
    # Проверите који је оперативни систем
    if [ -f /etc/os-release ]; then
        DISTRO_NAME=$(grep ^NAME= /etc/os-release | cut -d= -f2 | tr -d '"')
        
        # Проверите ако је Garuda Linux
        if [[ "$DISTRO_NAME" == "Garuda Linux" ]]; then
            echo -e "\033[32mПокрећем Garuda Update...\033[0m"
            sudo garuda-update
        elif [[ "$DISTRO_NAME" == "Garuda Linux Arm" ]]; then
            echo -e "\033[32mПокрећем Garuda Update...\033[0m"
            sudo garuda-update
        elif [[ "$DISTRO_NAME" == "EndeavourOS" ]]; then
            echo -e "\033[32mПокрећем EOS Update...\033[0m"
            sudo eos-update
        elif [[ "$DISTRO_NAME" == "EndeavourOS Arm" ]]; then
            echo -e "\033[32mПокрећем EOS Update...\033[0m"
            sudo eos-update
        elif [[ "$DISTRO_NAME" == "Arch Linux" ]]; then
            echo -e "\033[32mПокрећем Arch Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "Arch Linux ARM" ]]; then
            echo -e "\033[32mПокрећем Arch Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "Archcraft Linux" ]]; then
            echo -e "\033[32mПокрећем Arch Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "Kali Linux" ]]; then
            echo -e "\033[32mПокрећем Kali Update...\033[0m"
            sudo apt update && apt full-upgrade -y
        elif [[ "$DISTRO_NAME" == "Void Linux" ]]; then
            echo -e "\033[32mПокрећем Void Update...\033[0m"
            sudo xbps-install -Suy
        elif [[ "$DISTRO_NAME" == "Gentoo Linux" ]]; then
            echo -e "\033[32mПокрећем Gentoo Update...\033[0m"
            sudo emerge --sync && sudo emerge -uDU @world && sudo emerge --depclean && sudo etc-update && sudo revdep-rebuild
        elif [[ "$DISTRO_NAME" == "Parrot Security OS" ]]; then
            echo -e "\033[32mПокрећем Parrot Update...\033[0m"
            sudo apt update && apt full-upgrade -y
        elif [[ "$DISTRO_NAME" == "BlackArch Linux" ]]; then
            echo -e "\033[32mПокрећем BlackArch Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "BlackArch Linux ARM" ]]; then
            echo -e "\033[32mПокрећем BlackArch Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "Parrot OS" ]]; then
            echo -e "\033[32mПокрећем Parrot Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "BackBox Linux" ]]; then
            echo -e "\033[32mПокрећем BackBox Update...\033[0m"
            sudo pacman -Syu
        elif [[ "$DISTRO_NAME" == "Fedora" ]]; then
            echo -e "\033[32mПокрећем Fedora Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "Fedora Workstation" ]]; then
            echo -e "\033[32mПокрећем Fedora Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "Fedora Silverblue" ]]; then
            echo -e "\033[32mПокрећем Fedora Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "Manjaro Linux" ]]; then
            echo -e "\033[32mПокрећем Manjaro Update...\033[0m"
            sudo pacman -Syyu
        elif [[ "$DISTRO_NAME" == "CentOS Linux" ]]; then
            echo -e "\033[32mПокрећем CentOS Update...\033[0m"
            sudo yum update -y
        elif [[ "$DISTRO_NAME" == "CentOS Stream" ]]; then
            echo -e "\033[32mПокрећем CentOS Update...\033[0m"
            sudo yum update -y
        elif [[ "$DISTRO_NAME" == "Rocky Linux" ]]; then
            echo -e "\033[32mПокрећем Rocky Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "AlmaLinux" ]]; then
            echo -e "\033[32mПокрећем AlmaLinux Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "Oracle Linux" ]]; then
            echo -e "\033[32mПокрећем Oracle Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "Red Hat Enterprise Linux" ]]; then
            echo -e "\033[32mПокрећем RHEL Update...\033[0m"
            sudo dnf update -y
        elif [[ "$DISTRO_NAME" == "Linux Mint" ]]; then
            echo -e "\033[32mПокрећем LMDE Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        elif [[ "$DISTRO_NAME" == "nixOS" ]]; then
            echo -e "\033[32mПокрећем NixOS Update...\033[0m"
            sudo nixos-rebuild switch
        elif [[ "$DISTRO_NAME" == "NixOS" ]]; then
            echo -e "\033[32mПокрећем NixOS Update...\033[0m"
            sudo nixos-rebuild switch
        elif [[ "$DISTRO_NAME" == "deepin" ]]; then
            echo -e "\033[32mПокрећем Deepin Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        elif [[ "$DISTRO_NAME" == "Deepin GNU/Linux" ]]; then
            echo -e "\033[32mПокрећем Deepin Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        elif [[ "$DISTRO_NAME" == "elementary OS" ]]; then
            echo -e "\033[32mПокрећем elementary OS Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        elif [[ "$DISTRO_NAME" == "Debian GNU/Linux" ]]; then
            echo -e "\033[32mПокрећем Debian Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        elif [[ "$DISTRO_NAME" == "Pop!_OS" ]]; then
            echo -e "\033[32mПокрећем Pop!_OS Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        elif [[ "$DISTRO_NAME" == "openSUSE Leap" ]]; then
            echo -e "\033[32mПокрећем openSUSE Update...\033[0m"
            sudo zypper update -y
        elif [[ "$DISTRO_NAME" == "SUSE Linux Enterprise Server" ]]; then
            echo -e "\033[32mПокрећем SLES Update...\033[0m"
            sudo zypper update -y
        elif [[ "$DISTRO_NAME" == "Alpine Linux" ]]; then
            echo -e "\033[32mПокрећем Alpine Update...\033[0m"
            sudo apk update && sudo apk upgrade
        elif [[ "$DISTRO_NAME" == "Ubuntu" || "$DISTRO_NAME" == "Debian" ]]; then
            echo -e "\033[32mПокрећем APT Update...\033[0m"
            sudo apt update && sudo apt upgrade -y
        else
            echo -e "\033[31mОперативни систем није препознат. Ажурирање није покренуто.\033[0m"
        fi
    else
        echo -e "\033[31mНе може се пронаћи /etc/os-release. Ажурирање није покренуто.\033[0m"
    fi
else
    echo -e "\033[31mАжурирање је отказано.\033[0m"
fi
