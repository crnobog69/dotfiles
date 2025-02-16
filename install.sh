#!/bin/bash

# Setup logging to both terminal and file
exec > >(tee -a ~/genesis.log) 2>&1

echo "=== Инсталација је почела: $(date) ==="

set -euo pipefail

sudo pacman -Syu

# Дефинисање боја
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Провера захтева
check_requirements() {
    local required_commands=("git" "stow" "curl" "wl-copy")
    
    # Провера sudo привилегија
    if ! sudo -v &>/dev/null; then
        echo -e "${RED}Грешка: Ова скрипта захтева sudo привилегије${NC}"
        exit 1
    }

    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo -e "${RED}Инсталирање ${cmd}...${NC}"
            if [ "$cmd" = "wl-copy" ]; then
                if ! sudo pacman -S --noconfirm wl-clipboard; then
                    echo -e "${RED}Неуспешна инсталација wl-clipboard${NC}"
                    exit 1
                fi
            else
                if ! sudo pacman -S --noconfirm "$cmd"; then
                    echo -e "${RED}Неуспешна инсталација ${cmd}${NC}"
                    exit 1
                fi
            fi
            echo -e "${GREEN}Успешно инсталиран ${cmd}${NC}"
        fi
    done
}

# Главно
check_requirements

echo -e "${RED}Користите: ${GREEN}./genesis.sh${NC}"
echo -e "${RED}Ако сте на Arch Linux, можда је потребно да извршите команду sudo pacman -Syu${NC}"
echo -e "${RED}Оперативни систем: ${NC}"
grep ^NAME= /etc/os-release | cut -d= -f2 | tr -d '"'

echo
#------------------------------------------------------------------------------#

echo -e "${RED}Да ли желите да покренете скрипту за постање? [y/N]${NC}"
read GENESIS

if [[ "$GENESIS" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Постање покренуто.${NC}"
    echo
else
    echo -e "${RED}Постање отказано.${NC}"
    exit 1
fi

echo
#------------------------------------------------------------------------------#

## Git

echo -e "${GREEN}Git${NC}"

cd ~

cd dotfiles/

cd scripts/

./git-configure.sh

echo -e "${GREEN}Git конфигурација завршена.${NC}"

echo

echo -e "${GREEN}ssh кључ${} је копиран у међускладиште" && wl-copy < ~/.ssh/id_rsa.pub
echo -e "${GREEN}GitHub${NC}: https://github.com/settings/keys"
echo -e "${GREEN}GitLab${NC}: https://gitlab.com/-/user_settings/ssh_keys"
echo -e "${GREEN}Gitea${NC}: https://gitea.com/user/settings/keys"
echo -e "${GREEN}Codeberg${NC}: https://codeberg.org/user/settings/keys"

echo

echo -e "${RED}Да ли сте поставили ssh кључ на Github, GitLab, Codeberg и Gitea-и? [y/N]${NC}"
read GIT

if [[ "$GIT" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Постање се наставља .${NC}"
else
    echo -e "${RED}Поставите ssh кључ на Github, GitLab, Codeberg и Gitea-и, па поново покрените скрипту.${NC}"
    echo -e "${GREEN}ssh кључ${} је копиран у међускладиште" && wl-copy < ~/.ssh/id_rsa.pub
    echo -e "${GREEN}GitHub${NC}: https://github.com/settings/keys"
    echo -e "${GREEN}GitLab${NC}: https://gitlab.com/-/user_settings/ssh_keys"
    echo -e "${GREEN}Gitea${NC}: https://gitea.com/user/settings/keys"
    echo -e "${GREEN}Codeberg${NC}: https://codeberg.org/user/settings/keys"
    exit 1
fi

echo
#------------------------------------------------------------------------------#

echo -e "${GREEN}Клонирање Dotfiles...${NC}"

cd ~

## Dotfiles
git clone git@github.com:crnobog69/dotfiles.git
cd dotfiles
git remote rename origin github
git remote add gitlab git@gitlab.com:crnobog/dotfiles.git
git remote add codeberg git@codeberg.org/crnobog/dotfiles.git
git remote add gitea git@gitea.com:crnobog/dotfiles.git
echo -e "${GREEN}Dotfiles клониран.${NC}"

cd dotfiles/scripts/

chmod +x *.sh

echo -e "${GREEN}Инсталација пакета...${NC}"

./pkg.sh

echo -e "${GREEN}Инсталација пакета завршено.${NC}"

echo
#------------------------------------------------------------------------------#

echo -e "${RED}CGIT${NC}"

cd ~

## CGIT

# Функција за избор протокола
select_protocol() {
    echo -e "${RED}Изаберите протокол за клонирање [1-2]:${NC}"
    echo "1) SSH"
    echo "2) HTTPS"
    read -r protocol_choice

    case $protocol_choice in
        1) echo "ssh" ;;
        2) echo "https" ;;
        *) echo "ssh" ;;
    esac
}

# Избор протокола
PROTOCOL=$(select_protocol)

# Функција за преузимање URL-а за репозиторијум на основу протокола
get_repo_url() {
    local repo=$1
    local host=$2
    if [ "$PROTOCOL" = "ssh" ]; then
        echo "git@$host:crnobog69/$repo.git"
    else
        case $host in
            "github.com") echo "https://github.com/crnobog69/$repo.git" ;;
            "gitlab.com") echo "https://gitlab.com/crnobog/$repo.git" ;;
            "codeberg.org") echo "https://codeberg.org/crnobog/$repo.git" ;;
            "gitea.com") echo "https://gitea.com/crnobog/$repo.git" ;;
        esac
    fi
}

### Extra
echo -e "${GREEN}Клонирање Extra...${NC}"
cd ~
REPO_URL=$(get_repo_url "extra" "github.com")
git clone "$REPO_URL"
cd extra
git remote rename origin github
if [ "$PROTOCOL" = "ssh" ]; then
    git remote add gitlab git@gitlab.com:crnobog/extra.git
    git remote add codeberg git@codeberg.org/crnobog/extra.git
    git remote add gitea git@gitea.com:crnobog/extra.git
else
    git remote add gitlab https://gitlab.com/crnobog/extra.git
    git remote add codeberg https://codeberg.org/crnobog/extra.git
    git remote add gitea https://gitea.com/crnobog/extra.git
fi
echo -e "${GREEN}Extra клониран.${NC}"

### Scripts
echo -e "${GREEN}Клонирање Scripts...${NC}"
cd ~
REPO_URL=$(get_repo_url "scripts" "github.com")
git clone "$REPO_URL"
cd scripts
git remote rename origin github
echo -e "${GREEN}Scripts клониран.${NC}"

### Website
echo -e "${GREEN}Клонирање Website...${NC}"
cd ~
REPO_URL=$(get_repo_url "crnogob69.github.io" "github.com")
git clone "$REPO_URL"
cd crnogob69.github.io
git remote rename origin github
echo -e "${GREEN}Website клониран.${NC}"

### CBPaste
echo -e "${GREEN}Клонирање CBPaste...${NC}"
cd ~
REPO_URL=$(get_repo_url "cbpaste" "github.com")
git clone "$REPO_URL"
cd cbpaste
git remote rename origin github
echo -e "${GREEN}CBPaste клониран.${NC}"

### CBRSS
echo -e "${GREEN}Клонирање CBRSS...${NC}"
cd ~
REPO_URL=$(get_repo_url "cbrss" "github.com")
git clone "$REPO_URL"
cd cbrss
git remote rename origin github
echo -e "${GREEN}CBRSS клониран.${NC}"

### Proto-Orbita
echo -e "${GREEN}Клонирање Proto-Orbita...${NC}"
cd ~
REPO_URL=$(get_repo_url "proto-orbita" "github.com")
git clone "$REPO_URL"
cd proto-orbita
git remote rename origin github
echo -e "${GREEN}Proto-Orbita клониран.${NC}"

### Galerija
echo -e "${GREEN}Клонирање Galerija...${NC}"
cd ~
REPO_URL=$(get_repo_url "galerija" "github.com")
git clone "$REPO_URL"
cd galerija
git remote rename origin github
echo -e "${GREEN}Galerija клониран.${NC}"

### Galerija-Media
echo -e "${GREEN}Клонирање Galerija-Media...${NC}"
cd ~
REPO_URL=$(get_repo_url "galerija-media" "github.com")
git clone "$REPO_URL"
cd galerija-media
git remote rename origin github
echo -e "${GREEN}Galerija-Media клониран.${NC}"

### Bitarctic
echo -e "${GREEN}Клонирање Bitarctic...${NC}"
cd ~
REPO_URL=$(get_repo_url "bitarctic-re" "github.com")
git clone "$REPO_URL"
cd bitarctic-re
git remote rename origin github
echo -e "${GREEN}Bitarctic клониран.${NC}"

### Py-Zadaci
echo -e "${GREEN}Клонирање Py-Zadaci...${NC}"
cd ~
REPO_URL=$(get_repo_url "py" "github.com")
git clone "$REPO_URL"
cd py
git remote rename origin github
echo -e "${GREEN}Py-Zadaci клониран.${NC}"

### C-Zadaci
echo -e "${GREEN}Клонирање C-Zadaci...${NC}"
cd ~
REPO_URL=$(get_repo_url "c" "github.com")
git clone "$REPO_URL"
cd c
git remote rename origin github
echo -e "${GREEN}C-Zadaci клониран.${NC}"

### DotDocs
echo -e "${GREEN}Клонирање DotDocs...${NC}"
cd ~
REPO_URL=$(get_repo_url "dotdocs" "github.com")
git clone "$REPO_URL"
cd dotdocs
git remote rename origin github
echo -e "${GREEN}DotDocs клониран.${NC}"

echo
#------------------------------------------------------------------------------#

## GNU Stow

echo -e "${GREEN}GNU Stow${NC}"

cd ~

cd dotfiles/

stow .

echo -e "${GREEN}Dotfiles успешно постављене.${NC}"

echo
#------------------------------------------------------------------------------#

## Atuin

echo -e "${GREEN}Atuin${NC}"

cd ~

curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

echo -е "${GREEN}Atuin успешно инсталиран.${NC}"

cd ~

cd dotfiles/

rm -f ~/.config/atuin/config.toml && stow atuin

echo -е "${GREEN}GNU Stow успешно постављен.${NC}"

cd ~

echo -е "${RED}Да ли желите да се пријавите на Atuin?${NC}"
read ATUIN

if [[ "$ATUIN" =~ ^[Yy]$ ]]; then
    echo -е "${GREEN}Пријава на Atuin...${NC}"
    atuin login
    echo -е "${GREEN}Пријава на Atuin завршена.${NC}"
else
    echo -е "${RED}Пријава на Atuin отказана.${NC}"
fi

echo
#------------------------------------------------------------------------------#

## Bat

echo -е "${GREEN}Bat${NC}"

cd ~

rm -f ~/.config/bat/config && stow bat

echo -е "${GREEN}Bat конфигурација је завршена.${NC}"

echo
#------------------------------------------------------------------------------#

## Wakapi

echo -е "${GREEN}Wakapi${NC}"

cd ~

echo -е "${RED}За постављање Wakapi покрените${NC} ${GREEN}./dotfiles/scripts/install-wakapi.sh${NC}"

echo
#------------------------------------------------------------------------------#

cd ~

echo "=== Инсталација завршена: $(date) ==="