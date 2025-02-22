#!/bin/bash

# Функција за боје
PEACH='\033[38;2;250;183;135m'
YELLOW="\e[33m"
RED="\e[31m"
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
echo -e "${RED}[${NC}===${LAVANDER}  | Скрипта за git ${NC}====================${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${RED}[${NC}=== ${LAVANDER}--help | за помоћ${NC} =====================${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${NC}"

# Путања до репозиторијума
DOTFILES_REPO="${HOME}/dotfiles"
EXTRA_REPO="${HOME}/extra"
SCRIPTS_REPO="${HOME}/scripts"
WEBSITE_REPO="${HOME}/crnobog69.github.io"
CBPASTE_REPO="${HOME}/cbpaste"
CBRSS_REPO="${HOME}/cbrss"
PROTO_ORBITA_REPO="${HOME}/proto-orbita"
GALERIJA_REPO="${HOME}/galerija"
BITARCTIC_REPO="${HOME}/bitarctic"

# Функција за гурање на све remote-ове
push_to_all_remotes() {
    local repo=$1
    echo "==================================================================="
    echo
    echo -e "${LAVANDER}Гурам репозиторијум:${NC} ${PEACH}$repo${NC} ${LAVANDER}на све удаљене репозиторијуме${NC}"
    cd "$repo" || exit
    
    for remote in github gitlab codeberg; do
        echo -e "${YELLOW}Гурам на $remote...${NC}"
        git add .
        git commit -m "❄️"
        git push "$remote" || echo -e "${RED}Неуспешно гурање на $remote${NC}"
    done
    echo -e "${PEACH}----------------${NC}"
}

# Функција за гурање само на GitHub
push_to_github() {
    local repo=$1
    echo -e "${LAVANDER}Гурам репозиторијум:${NC} ${PEACH}$repo${NC} ${LAVANDER}на GitHub${NC}"
    cd "$repo" || exit
    
    echo -e "${YELLOW}Гурам на github...${NC}"
    git add .
    git commit -m "❄️"
    git push github || echo -е "${RED}Неуспешно гурање на github${NC}"
    echo -e "${PEACH}----------------${NC}"
}

# Функција за повлачење са свих remote-ова
pull_from_all_remotes() {
    local repo=$1
    echo "==================================================================="
    echo
    echo -e "${LAVANDER}Повлачим репозиторијум:${NC} ${PEACH}$repo${NC} ${LAVANDER}са свих удаљених репозиторијума${NC}"
    cd "$repo" || exit
    
    for remote in github gitlab codeberg; do
        echo -e "${YELLOW}Повлачим са $remote...${NC}"
        git pull "$remote" || echo -e "${RED}Неуспешно повлачење са $remote${NC}"
    done
}

# Функција за приказ помоћи
show_help() {
    echo "==================================================================="
    echo
    echo -e "${RED}     цгит | cgit / црнигит | crnigit | blackgit - скрипта за git${NC}"
    echo
    echo -e "${LAVANDER}Употреба:${NC} $0 [опција]"
    echo -e "${LAVANDER}Опције:${NC}"
    echo
    echo -e "  ${PEACH}-a${NC}, ${PEACH}--all${NC}       Гурај све репозиторијуме"
    echo -e "  ${PEACH}-d${NC}, ${PEACH}--dotfiles${NC}  Гурај само dotfiles"
    echo -e "  ${PEACH}-e${NC}, ${PEACH}--extra${NC}     Гурај само extra"
    echo -e "  ${PEACH}-s${NC}, ${PEACH}--scripts${NC}   Гурај само scripts"
    echo -e "  ${PEACH}-w${NC}, ${PEACH}--website${NC}   Гурај само website (crnobog69.github.io)"
    echo -e "  ${PEACH}-c${NC}, ${PEACH}--cbpaste${NC}   Гурај само cbpaste"
    echo -e "  ${PEACH}-r${NC}, ${PEACH}--cbrss${NC}     Гурај само cbrss"
    echo -e "  ${PEACH}-p${NC}, ${PEACH}--proto-orbita${NC} Гурај само proto-orbita"
    echo -e "  ${PEACH}-g${NC}, ${PEACH}--galerija${NC}   Гурај само galerija"
    echo -e "  ${PEACH}-b${NC}, ${PEACH}--bitarctic${NC}  Гурај само bitarctic"
    echo -e "  ${PEACH}-h${NC}, ${PEACH}--help${NC}      Прикажи ову помоћ"
    echo -e "  ${PEACH}--pull-all${NC}   Повлачи све репозиторијуме"
    echo
    echo "==================================================================="
    exit 0
}

# Провера аргумената
if [ $# -eq 0 ]; then
    show_help
fi

# Обрада аргумената
case "$1" in
    -a|--all)
        push_to_all_remotes "$DOTFILES_REPO"
        push_to_all_remotes "$EXTRA_REPO"
        push_to_github "$SCRIPTS_REPO"
        push_to_github "$WEBSITE_REPO"
        push_to_github "$CBPASTE_REPO"
        push_to_github "$CBRSS_REPO"
        push_to_github "$PROTO_ORBITA_REPO"
        push_to_github "$GALERIJA_REPO"
        push_to_github "$BITARCTIC_REPO"
        ;;
    -d|--dotfiles)
        push_to_all_remotes "$DOTFILES_REPO"
        ;;
    -e|--extra)
        push_to_all_remotes "$EXTRA_REPO"
        ;;
    -s|--scripts)
        push_to_github "$SCRIPTS_REPO"
        ;;
    -w|--website)
        push_to_github "$WEBSITE_REPO"
        ;;
    -c|--cbpaste)
        push_to_github "$CBPASTE_REPO"
        ;;
    -r|--cbrss)
        push_to_github "$CBRSS_REPO"
        ;;
    -p|--proto-orbita)
        push_to_github "$PROTO_ORBITA_REPO"
        ;;
    -h|--help)
        show_help
        ;;
    -g|--galerija)
        push_to_github "$GALERIJA_REPO"
        ;;
    -b|--bitarctic)
        push_to_github "$BITARCTIC_REPO"
        ;;
    --pull-all)
        pull_from_all_remotes "$DOTFILES_REPO"
        pull_from_all_remotes "$EXTRA_REPO"
        pull_from_all_remotes "$SCRIPTS_REPO"
        pull_from_all_remotes "$WEBSITE_REPO"
        pull_from_all_remotes "$CBPASTE_REPO"
        pull_from_all_remotes "$CBRSS_REPO"
        pull_from_all_remotes "$PROTO_ORBITA_REPO"
        pull_from_all_remotes "$GALERIJA_REPO"
        ;;
    *)
        echo -e "${RED}Непозната опција: $1${NC}"
        show_help
        ;;
esac

echo "==================================================================="
echo
echo -e "${LAVANDER}Завршено гурање!${NC}"
echo
echo "==================================================================="
