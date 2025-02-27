#!/bin/bash

# Дефинисање боја
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m' 
NC='\033[0m' # Без боје

USER=$(whoami)
SETTINGS_FILE="/home/$USER/dotfiles/vs-code/.config/Code/User/settings.json"

# Функција за проверу статуса
check_status() {
    if [ ! -f "$SETTINGS_FILE" ]; then
        echo -e "${RED}Фајл подешавања VS Code-а није пронађен на $SETTINGS_FILE${NC}"
        return 1
    fi

    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Грешка: jq је потребан али није инсталиран.${NC}"
        return 1
    fi

    CURRENT_VALUE=$(jq -r '.["github.copilot.editor.enableAutoCompletions"] // false' "$SETTINGS_FILE")
    
    if [ "$CURRENT_VALUE" = "true" ]; then
        echo
        echo -e "${YELLOW}GitHub Copilot аутоматско довршавање${NC} је тренутно: ${GREEN}укључено${NC}"
    else
        echo
        echo -e "${YELLOW}GitHub Copilot аутоматско довршавање${NC} је тренутно: ${RED}искључено${NC}"
    fi
}

# Провери аргументе
if [ "$1" = "--status" ]; then
    check_status
    exit 0
fi

# Провери да ли постоји фајл подешавања
if [ ! -f "$SETTINGS_FILE" ]; then
    echo -e "${RED}Фајл подешавања VS Code-а није пронађен на $SETTINGS_FILE${NC}"
    exit 1
fi

# Провери да ли је jq инсталиран
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Грешка: jq је потребан али није инсталиран. Прво инсталирајте jq.${NC}"
    exit 1
fi

# Прочитај тренутну вредност подешавања
CURRENT_VALUE=$(jq -r '.["github.copilot.editor.enableAutoCompletions"] // false' "$SETTINGS_FILE")

# Одреди нову вредност (пребаци)
if [ "$CURRENT_VALUE" = "true" ]; then
    NEW_VALUE=false
    STATUS_MSG="искључено"
    COLOR=$RED
else
    NEW_VALUE=true
    STATUS_MSG="укључено"
    COLOR=$GREEN
fi

# Ажурирај подешавање
jq --indent 4 ".\"github.copilot.editor.enableAutoCompletions\" = $NEW_VALUE" "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp"
mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

echo
echo -e "${YELLOW}GitHub Copilot аутоматско довршавање${NC} пребачено на: ${COLOR}$STATUS_MSG${NC}"
