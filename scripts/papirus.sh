#!/bin/bash

# Провера да ли се скрипта покреће са sudo привилегијама
if [ "$EUID" -ne 0 ]; then 
    echo "Покрените скрипту са sudo привилегијама"
    exit 1
fi

# Функција за инсталирање и конфигурисање Catppuccin фасцикли
install_catppuccin_folders() {
    echo "Инсталирање Catppuccin фасцикли..."
    
    # Креирање привременог директоријума
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit 1
    
    # Клонирање репозиторијума
    if ! git clone https://github.com/catppuccin/papirus-folders.git; then
        echo "Грешка при клонирању репозиторијума"
        exit 1
    fi
    
    cd papirus-folders || exit 1
    
    # Копирање садржаја у Papirus тему
    if ! sudo cp -r src/* /usr/share/icons/Papirus/; then
        echo "Грешка при копирању Catppuccin датотека"
        exit 1
    fi
    
    # Преузимање и подешавање papirus-folders скрипте
    if ! curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders; then
        echo "Грешка при преузимању papirus-folders скрипте"
        exit 1
    fi
    
    chmod +x ./papirus-folders
    
    # Примена Catppuccin теме
    if ! ./papirus-folders -C cat-mocha-blue --theme Papirus-Dark; then
        echo "Грешка при примени Catppuccin теме"
        exit 1
    fi
    
    # Чишћење
    cd || exit 1
    rm -rf "$TEMP_DIR"
    
    echo "Catppuccin фасцикле су успешно инсталиране"
}

# Питање да ли корисник жели да инсталира Catppuccin фасцикле
read -p "Да ли желите да инсталирате Catppuccin фолдере? (y/n) " install_catppuccin

if [[ $install_catppuccin =~ ^[Yy]$ ]]; then
    # Провера да ли је Papirus тема инсталирана
    if [ ! -d "/usr/share/icons/Papirus" ]; then
        echo "Папирус тема није инсталирана. Молимо вас да прво инсталирате Папирус тему."
        exit 1
    fi
    install_catppuccin_folders
fi

# Дефинисање путања до икона које желите да копирате
ICON_PATHS=(
    "/home/lain/dotfiles/assets/vesktop.svg"
    "/home/lain/dotfiles/assets/preferences-system.svg"
    "/home/lain/dotfiles/assets/org.kde.dolphin.svg"
)

# Дефинисање циљног основног директоријума где ће се копирати иконе
TARGET_BASE_DIR="/usr/share/icons/Papirus-Dark"

# Дефинисање величина икона
SIZES=("16x16" "22x22" "24x24" "32x32" "48x48" "64x64" "96x96" "128x128")

# Провера да ли изворне датотеке постоје и да ли су SVG датотеке
for icon_path in "${ICON_PATHS[@]}"; do
    if [ ! -f "$icon_path" ]; then
        echo "Икона не постоји: $icon_path"
        exit 1
    fi
    
    # Провера да ли је датотека SVG
    if [[ ! "$icon_path" =~ \.svg$ ]]; then
        echo "Датотека није SVG: $icon_path"
        exit 1
    fi
done

# Провера да ли циљни основни директоријум постоји
if [ ! -d "$TARGET_BASE_DIR" ]; then
    echo "Циљни директоријум не постоји: $TARGET_BASE_DIR"
    exit 1
fi

# Пролазак кроз величине и копирање икона у сваки директоријум величине
for SIZE in "${SIZES[@]}"; do
    TARGET_DIR="$TARGET_BASE_DIR/$SIZE/apps"

    # Провера да ли директоријум величине постоји
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Креирање директоријума: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
    fi

    echo "Копирање икона у $SIZE директоријум..."
    for icon_path in "${ICON_PATHS[@]}"; do
        icon_name=$(basename "$icon_path")
        target_path="$TARGET_DIR/$icon_name"
        
        # Копирање SVG датотеке
        if ! cp "$icon_path" "$target_path"; then
            echo "Грешка при копирању $icon_path у $TARGET_DIR"
            exit 1
        fi
        
        # Постављање одговарајућих дозвола
        chmod 644 "$target_path"
    done
done

echo "Иконе су успешно инсталиране у $TARGET_BASE_DIR"

# Ажурирање кеша икона
gtk-update-icon-cache -f "$TARGET_BASE_DIR"
