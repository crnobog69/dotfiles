#!/bin/bash

# Боје за излаз
GREEN='\033[0;32m'
RED='\033[0;31m'
LAVANDER='\033[38;2;180;191;254m'
NC='\033[0m' # Без боје

# Провери да ли је инсталиран jq
if ! command -v jq &>/dev/null; then
    echo -e "${RED}jq није инсталиран. Молимо вас да га инсталирате помоћу: sudo pacman -S jq${NC}"
    exit 1
fi

# Функција за проверу да ли је пакет инсталиран (за pacman и chaotic-aur пакете)
is_installed() {
    pacman -Qi "$1" &>/dev/null
}

# Функција за проверу да ли је AUR пакет инсталиран (користи yay)
is_aur_installed() {
    yay -Qi "$1" &>/dev/null
}

# Функција за приказ пакета са статусом
show_packages_status() {
    local package_type="$1"
    local packages=("${!2}")

    if [ ${#packages[@]} -eq 0 ]; then
        echo -e "${RED}Нема пакета за проверу у категорији ${package_type}.${NC}"
        return
    fi

    echo -e "\n==> Провера ${package_type} пакета:"
    for package in "${packages[@]}"; do
        if is_installed "$package" || is_aur_installed "$package"; then
            echo -e "${GREEN}Пакет '$package' је већ инсталиран.${NC}"
        else
            echo -e "${RED}Пакет '$package' није инсталиран.${NC}"
        fi
    done
}

# Функција која проверава да ли има неинсталираних пакета у категорији
has_uninstalled_packages() {
    local packages=("${!1}")
    for package in "${packages[@]}"; do
        if ! is_installed "$package" && ! is_aur_installed "$package"; then
            return 0  # Постоји бар један неинсталиран пакет
        fi
    done
    return 1  # Сви пакети су инсталирани
}

# Функција која пита корисника да ли жели да инсталира пакете из одређене категорије
prompt_install_all() {
    local package_type="$1"
    read -rp "Да ли желите да инсталирате све пакете из категорије ${package_type}? [y/N]: " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Инсталирај пакете преко pacman-а
install_pacman() {
    show_packages_status "Pacman" pacman_packages[@]
    if has_uninstalled_packages pacman_packages[@]; then
        if prompt_install_all "Pacman"; then
            for package in "${pacman_packages[@]}"; do
                if ! is_installed "$package"; then
                    echo -e "\n==> Инсталирање пакета: $package"
                    sudo pacman -S --needed --noconfirm "$package"
                fi
            done
        else
            echo -e "${RED}Прескакање инсталације Pacman пакета.${NC}"
        fi
    else
        echo -e "${LAVANDER}Сви Pacman пакети су већ инсталирани.${NC}"
    fi
}

# Инсталирај пакете из chaotic-aur репозиторијума
install_chaoticaur() {
    show_packages_status "Chaotic AUR" chaoticaur_packages[@]
    if has_uninstalled_packages chaoticaur_packages[@]; then
        if prompt_install_all "Chaotic AUR"; then
            for package in "${chaoticaur_packages[@]}"; do
                if ! is_installed "$package"; then
                    echo -e "\n==> Инсталирање Chaotic AUR пакета: $package"
                    sudo pacman -S --needed --noconfirm chaotic-aur/"$package"
                fi
            done
        else
            echo -e "${RED}Прескакање инсталације Chaotic AUR пакета.${NC}"
        fi
    else
        echo -e "${LAVANDER}Сви Chaotic AUR пакети су већ инсталирани.${NC}"
    fi
}

# Инсталирај AUR пакете преко yay-а
install_yay() {
    show_packages_status "AUR" aur_packages[@]
    if has_uninstalled_packages aur_packages[@]; then
        if prompt_install_all "AUR"; then
            for package in "${aur_packages[@]}"; do
                if ! is_aur_installed "$package"; then
                    echo -e "\n==> Инсталирање AUR пакета: $package"
                    yay -S --needed --noconfirm "$package"
                fi
            done
        else
            echo -e "${RED}Прескакање инсталације AUR пакета.${NC}"
        fi
    else
        echo -e "${LAVANDER}Сви AUR пакети су већ инсталирани.${NC}"
    fi
}

# Учитај пакете из JSON датотеке користећи jq
load_packages() {
    if [ ! -f "$1" ]; then
        echo -e "${RED}Фајл '$1' није пронађен. Уверите се да се налази у истом директоријуму као и скрипта.${NC}"
        exit 1
    fi

    pacman_packages=($(jq -r '.pacman[]' "$1"))
    chaoticaur_packages=($(jq -r '.chaoticaur[]' "$1"))
    aur_packages=($(jq -r '.aur[]' "$1"))
}

# Мени за кориснички избор
show_menu() {
    echo "Изаберите метод инсталације:"
    echo "1) Само pacman"
    echo "2) pacman + chaotic-aur"
    echo "3) Само yay"
    echo "4) yay + pacman"
    echo "5) pacman + chaotic-aur + yay"
    read -rp "Ваш избор: " choice
}

# Провери да ли је yay инсталиран
check_yay() {
    if ! command -v yay &>/dev/null; then
        echo "yay није инсталиран."
        echo "Можете га инсталирати пратећи упутства на: https://github.com/Jguer/yay"
        exit 1
    fi
}

# Главна функција
main() {
    local json_file="packages.json"
    load_packages "$json_file"
    show_menu

    case $choice in
        1) install_pacman ;;
        2) install_pacman; install_chaoticaur ;;
        3) check_yay; install_yay ;;
        4) install_pacman; check_yay; install_yay ;;
        5) install_pacman; install_chaoticaur; check_yay; install_yay ;;
        *) echo -e "${RED}Погрешан избор.${NC}"; exit 1 ;;
    esac
}

main "$@"
