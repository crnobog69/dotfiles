#!/bin/bash

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
echo -e "${NC}"

# Funkcija za prikaz pomoći
show_help() {
    echo "Креира .desktop фајл за AppImage апликацију"
    echo
    echo "Коришћење: $0 [ОПЦИЈЕ] /путања/до/AppImage Назив_апликације [путања/до/иконе.png]"
    echo
    echo "Опције:"
    echo "  -h, --help     Приказује ову помоћ"
    echo
    echo "Аргументи:"
    echo "  /путања/до/AppImage    Путања до AppImage фајла"
    echo "  Назив_апликације      Назив апликације који ће се приказати"
    echo "  путања/до/иконе.png   Опционална путања до иконе"
    exit 0
}

# Провера за --help опцију
for arg in "$@"; do
    case $arg in
        -h|--help)
            show_help
            ;;
    esac
done

# Проверa броја аргумената
if [ "$#" -lt 2 ]; then
    echo "Грешка: Недовољан број аргумената"
    echo "Коришћење: $0 /путања/до/AppImage Назив_апликације [путања/до/иконе.png]"
    echo "Користите '$0 --help' за више информација"
    exit 1
fi

# Променљиве
APPIMAGE_PATH="$1"
APP_NAME="$2"
ICON_PATH="${3:-}"

# Провера да ли AppImage фајл постоји
if [ ! -f "$APPIMAGE_PATH" ]; then
    echo "AppImage фајл не постоји: $APPIMAGE_PATH"
    exit 1
fi

# Локација за .desktop фајл
DESKTOP_FILE="$HOME/.local/share/applications/$APP_NAME.desktop"

# Генерисање .desktop фајла
echo "Креирам $DESKTOP_FILE ..."
cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=$APP_NAME
Exec=$APPIMAGE_PATH
Icon=$ICON_PATH
Type=Application
Categories=Utility;Development;
Terminal=false
EOL

# Ако је путања до иконе празна, изостави је из .desktop фајла
if [ -z "$ICON_PATH" ]; then
    sed -i '/^Icon=/d' "$DESKTOP_FILE"
fi

# Омогућавање извршавања
chmod +x "$DESKTOP_FILE"

# Информација кориснику
echo "Десктоп пречица је успешно креирана: $DESKTOP_FILE"
