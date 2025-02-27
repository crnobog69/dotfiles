#!/bin/bash

# Дефинисање боја у хекс формату (као у cgit.sh)
RED="#f38ba8"
YELLOW="#f9e2af"
GREEN="#a6e3a1"
LAVENDER="#cdd6f4"
DARK_RED="#e78284"
DARK_LAVENDER="#babbf1"

# ANSI боје за терминал
RED_ANSI='\033[0;31m'
GREEN_ANSI='\033[0;32m'
YELLOW_ANSI='\033[0;33m'
BLUE_ANSI='\033[0;34m'
NC='\033[0m' # Без боје

USER=$(whoami)
SETTINGS_FILE="/home/$USER/dotfiles/vs-code/.config/Code/User/settings.json"

# Функција за проверу статуса
check_status() {
    if [ ! -f "$SETTINGS_FILE" ]; then
        echo -e "${RED_ANSI}Фајл подешавања VS Code-а није пронађен на $SETTINGS_FILE${NC}"
        return 1
    fi

    if ! command -v jq &> /dev/null; then
        echo -e "${RED_ANSI}Грешка: jq је потребан али није инсталиран.${NC}"
        return 1
    fi

    CURRENT_VALUE=$(jq -r '.["github.copilot.editor.enableAutoCompletions"] // false' "$SETTINGS_FILE")
    
    if [ "$CURRENT_VALUE" = "true" ]; then
        echo
        echo -e "${YELLOW_ANSI}GitHub Copilot аутоматско довршавање${NC} је тренутно: ${GREEN_ANSI}укључен${NC}"
    else
        echo
        echo -e "${YELLOW_ANSI}GitHub Copilot аутоматско довршавање${NC} је тренутно: ${RED_ANSI}искључен${NC}"
    fi
}

# Функција за промену статуса
toggle_copilot() {
    local new_state=$1
    
    # Провери да ли постоји фајл подешавања
    if [ ! -f "$SETTINGS_FILE" ]; then
        echo -e "${RED_ANSI}Фајл подешавања VS Code-а није пронађен на $SETTINGS_FILE${NC}"
        exit 1
    fi

    # Ажурирај подешавање
    jq --indent 4 ".\"github.copilot.editor.enableAutoCompletions\" = $new_state" "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp"
    mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

    if [ "$new_state" = "true" ]; then
        echo -e "${YELLOW_ANSI}GitHub Copilot аутоматско довршавање${NC} пребачено на: ${GREEN_ANSI}укључен${NC}"
    else
        echo -e "${YELLOW_ANSI}GitHub Copilot аутоматско довршавање${NC} пребачено на: ${RED_ANSI}искључен${NC}"
    fi
}

# Провери да ли је jq инсталиран
if ! command -v jq &> /dev/null; then
    echo -e "${RED_ANSI}Грешка: jq је потребан али није инсталиран. Прво инсталирајте jq.${NC}"
    exit 1
fi

# Провери да ли је gum инсталиран
if ! command -v gum &> /dev/null; then
    echo -e "${RED_ANSI}Грешка: gum је потребан али није инсталиран. Прво инсталирајте gum.${NC}"
    echo -e "${YELLOW_ANSI}Инсталација: ${BLUE}https://github.com/charmbracelet/gum#installation${NC}"
    exit 1
fi

# Прво прикажи тренутни статус
check_status

# Користи gum за избор опције (користећи стилизацију као у cgit.sh)
echo
echo -e "${RED_ANSI}Изаберите опцију:${NC}"

CHOICE=$(gum choose \
    --header=" GitHub Copilot " \
    --header.foreground="$YELLOW" \
    --cursor.foreground="$RED" \
    --item.foreground="$LAVENDER" \
    --selected.foreground="$RED" \
    "  |  Укључи" \
    "  |  Искључи" \
    "󰈆 Излаз")

case "$CHOICE" in
    "  |  Укључи")
        toggle_copilot true
        ;;
    "  |  Искључи")
        toggle_copilot false
        ;;
    "󰈆 Излаз")
        echo -e "${YELLOW_ANSI}Операција отказана.${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED_ANSI}Непозната опција.${NC}"
        exit 1
        ;;
esac
