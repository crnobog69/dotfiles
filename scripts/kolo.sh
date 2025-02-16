#!/bin/bash

# Функција за проналажење доступног AUR помоћника
find_aur_helper() {
    local helpers=("yay" "paru" "pikaur" "trizen" "aura")
    for helper in "${helpers[@]}"; do
        if command -v "$helper" &> /dev/null; then
            echo "$helper"
            return 0
        fi
    done
    return 1
}

# Постављање хвата за CTRL+C (SIGINT)
trap 'echo -e "\nСкрипта прекинута коришћењем CTRL+C."; exit 1' SIGINT

# Парсирање аргумената командне линије
USE_AUR=false
SYNC_DB=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --aur) USE_AUR=true ;;
        --sync) SYNC_DB=true ;;
        *) echo "Непознат параметар: $1"; exit 1 ;;
    esac
    shift
done

# Постављање менаџера пакета
if $USE_AUR; then
    PACKAGE_MANAGER=$(find_aur_helper)
    if [[ -z "$PACKAGE_MANAGER" ]]; then
        echo "Није пронађен AUR помоћник. Молимо инсталирајте један (нпр. yay, paru) да бисте користили AUR."
        exit 1
    fi
else
    PACKAGE_MANAGER="pacman"
fi

# Синхронизација базе пакета ако је затражено
if $SYNC_DB; then
    echo "Синхронизовање базе пакета..."
    if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
        sudo $PACKAGE_MANAGER -Sy --noconfirm
    else
        $PACKAGE_MANAGER -Sy --noconfirm
    fi
fi

# Претраживање пакета
if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
    selected_package=$(pacman -Sl | \
        fzf --prompt="Претрага пакета: " \
            --preview="pacman -Si {2}" \
            --preview-window="right:50%:wrap" | \
        awk '{print $2}')
else
    selected_package=$($PACKAGE_MANAGER -Sl | \
        fzf --prompt="Претрага пакета (укључујући AUR): " \
            --preview="$PACKAGE_MANAGER -Si {2}" \
            --preview-window="right:50%:wrap" | \
        awk '{print $2}')
fi

# Ако је пакет изабран, провери да ли је већ инсталиран
if [[ -n "$selected_package" ]]; then
    if pacman -Qi "$selected_package" &> /dev/null; then
        # Пакет је инсталиран, понуди деинсталацију
        read -p "Пакет '$selected_package' је већ инсталиран. Да ли желите да га деинсталирате? (Y/n): " choice
        choice=${choice:-Y}
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
                sudo $PACKAGE_MANAGER -Rns "$selected_package"
            else
                $PACKAGE_MANAGER -Rns "$selected_package"
            fi
        else
            echo "Деинсталација отказана."
        fi
    else
        # Пакет није инсталиран, понуди инсталацију
        read -p "Пакет '$selected_package' није инсталиран. Да ли желите да га инсталирате? (Y/n): " choice
        choice=${choice:-Y}
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            if [[ "$PACKAGE_MANAGER" == "pacman" ]]; then
                sudo $PACKAGE_MANAGER -S "$selected_package"
            else
                $PACKAGE_MANAGER -S "$selected_package"
            fi
        else
            echo "Инсталација отказана."
        fi
    fi
else
    echo "Није изабран ниједан пакет."
fi

# Прикажи резултат извршавања скрипте
if [[ $? -eq 0 ]]; then
    echo "Операција успешно завршена."
else
    echo "Дошло је до грешке током операције."
fi