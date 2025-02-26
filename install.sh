#!/usr/bin/env bash

# █▀▀ █▀█ █▄ █ █▀█ █▄▄ █▀█ █▀▀ █▀▀ █▀ 
# █▄▄ █▀▄ █ ▀█ █▄█ █▄█ █▄█ █▄█ ██▄ ▄█
# Arch Linux Dotfiles Installer

# Дефинисање боја
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Глобалне променљиве
LOG_FILE=~/genesis.log
DOTFILES_REPO="https://github.com/crnobog69/dotfiles.git"
GITHUB_USERNAME="crnobog69"
BITBUCKET_USERNAME="crnobog69"
SOURCEHUT_USERNAME="crnobog"
GITLAB_USERNAME="crnobog"
CODEBERG_USERNAME="crnobog"
GITEA_USERNAME="crnobog"
DOTFILES_DIR=~/dotfiles
CURRENT_DIR=$(pwd)

# Функције помоћи
log() {
    echo -e "${2:-$NC}$1${NC}" | tee -a "$LOG_FILE"
}

log_header() {
    log "\n${BLUE}=== $1 ===${NC}\n" "$BLUE"
}

log_success() {
    log "$1" "$GREEN"
}

log_error() {
    log "$1" "$RED" >&2
}

log_info() {
    log "$1" "$YELLOW"
}

prompt_yes_no() {
    log_info "$1 [y/N]"
    read -r response
    [[ "$response" =~ ^[Yy]$ ]] && return 0 || return 1
}

# Припремне функције
setup_logging() {
    touch "$LOG_FILE"
    log_header "Инсталација је почела: $(date)"
    log_info "УПОЗОРЕЊЕ: Скрипта је направљена за Arch Linux + Wayland"
    log "Логови се налазе у: $LOG_FILE"
}

check_requirements() {
    log_header "Провера захтева"
    
    # Провера оперативног система
    if ! grep -q "Arch Linux" /etc/os-release 2>/dev/null; then
        log_info "Оперативни систем: $(grep ^NAME= /etc/os-release | cut -d= -f2 | tr -d '"')"
        log_info "Ова скрипта је примарно направљена за Arch Linux"
    fi
    
    # Провера sudo привилегија
    if ! sudo -v &>/dev/null; then
        log_error "Грешка: Ова скрипта захтева sudo привилегије"
        return 1
    fi
    
    # Основни пакети потребни за даљу инсталацију
    local required_commands=("git" "stow" "curl" "wl-copy" "ssh-keygen")
    
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log_info "Инсталирање ${cmd}..."
            
            if [ "$cmd" = "wl-copy" ]; then
                if ! sudo pacman -S --noconfirm wl-clipboard; then
                    log_error "Неуспешна инсталација wl-clipboard"
                    return 1
                fi
            else
                if ! sudo pacman -S --noconfirm "$cmd"; then
                    log_error "Неуспешна инсталација ${cmd}"
                    return 1
                fi
            fi
            log_success "Успешно инсталиран ${cmd}"
        fi
    done
    
    return 0
}

setup_ssh_keys() {
    log_header "Подешавање SSH кључева"
    
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
        log_info "Креирање новог SSH кључа"
        ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)" -f ~/.ssh/id_rsa -N ""
    else
        log_info "SSH кључ већ постоји"
    fi
    
    # Копирање SSH кључа у међускладиште
    if command -v wl-copy >/dev/null 2>&1; then
        wl-copy < ~/.ssh/id_rsa.pub
        log_success "SSH кључ је копиран у међускладиште"
    else
        log_info "Ваш SSH кључ је:"
        cat ~/.ssh/id_rsa.pub
    fi
    
    log_info "Додајте SSH кључ на следеће сервисе:"
    log_info "GitHub: https://github.com/settings/keys"
    log_info "BitBucket: https://bitbucket.org/account/settings/ssh-keys/"
    log_info "SourceHut: https://meta.sr.ht/keys"
    log_info "GitLab: https://gitlab.com/-/user_settings/ssh_keys"
    log_info "Gitea: https://gitea.com/user/settings/keys"
    log_info "Codeberg: https://codeberg.org/user/settings/keys"
    
    if prompt_yes_no "Да ли сте додали SSH кључ на потребним сервисима?"; then
        log_success "Постављање SSH кључа завршено."
    else
        log_info "Додајте SSH кључ касније и поново покрените скрипту."
        
        if prompt_yes_no "Желите ли да наставите без додавања SSH кључа?"; then
            log_info "Настављам са HTTPS клонирањем репозиторијума."
            return 0
        else
            return 1
        fi
    fi
}

update_system() {
    log_header "Ажурирање система"
    if sudo pacman -Syu --noconfirm; then
        log_success "Систем је успешно ажуриран."
    else
        log_error "Грешка при ажурирању система."
        return 1
    fi
}

# Главне функције за инсталацију
clone_dotfiles() {
    log_header "Клонирање Dotfiles репозиторијума"
    
    # Преузимање репозиторијума ако не постоји
    if [ ! -д "$DOTFILES_DIR" ]; онда
        log_info "Клонирам dotfiles у $DOTFILES_DIR"
        if git clone "$DOTFILES_REPO" "$DOTFILES_DIR"; онда
            log_success "Dotfiles успешно клониран."
        else
            log_error "Неуспешно клонирање dotfiles репозиторијума."
            return 1
        fi
    else
        log_info "Директоријум dotfiles већ постоји. Ажурирам репозиторијум..."
        cd "$DOTFILES_DIR" || return 1
        git pull
    fi
    
    # Конфигурисање удаљених репозиторијума
    cd "$DOTFILES_DIR" || return 1
    
    if git remote | grep -q "github"; онда
        log_info "Удаљени репозиторијуми су већ конфигурисани."
    else
        git remote rename origin github || true
        git remote add bitbucket "git@bitbucket.org:$BITBUCKET_USERNAME/dotfiles.git" || true
        git remote add sourcehut "git@git.sr.ht:~$SOURCEHUT_USERNAME/dotfiles.git" || true
        git remote add gitlab "git@gitlab.com:$GITLAB_USERNAME/dotfiles.git" || true
        git remote add codeberg "git@codeberg.org/$CODEBERG_USERNAME/dotfiles.git" || true
        git remote add gitea "git@gitea.com:$GITEA_USERNAME/dotfiles.git" || true
        log_success "Удаљени репозиторијуми су конфигурисани."
    fi
    
    return 0
}

configure_git() {
    log_header "Конфигурисање Git-а"
    
    if [ -f "$DOTFILES_DIR/scripts/git-configure.sh" ]; онда
        cd "$DOTFILES_DIR/scripts" || return 1
        chmod +x git-configure.sh
        ./git-configure.sh
        log_success "Git конфигурација завршена."
    else
        log_error "Скрипта за конфигурацију Git-а није пронађена."
        log_info "Конфигуришем основне Git параметре..."
        
        read -rp "Унесите ваше име за Git: " git_name
        read -rp "Унесите вашу e-mail адресу за Git: " git_email
        
        git config --global user.name "$git_name"
        git config --global user.email "$git_email"
        git config --global core.editor "vim"
        git config --global init.defaultBranch "main"
        
        log_success "Основна Git конфигурација завршена."
    fi
}

install_packages() {
    log_header "Инсталација пакета"
    
    if [ -f "$DOTFILES_DIR/scripts/pkg.sh" ]; онда
        cd "$DOTFILES_DIR/scripts" || return 1
        chmod +x pkg.sh
        ./pkg.sh
        log_success "Инсталација пакета завршена."
    else
        log_error "Скрипта за инсталацију пакета није пронађена."
        if prompt_yes_no "Да ли желите да инсталирате основне пакете?"; онда
            log_info "Инсталирам основне пакете..."
            sudo pacman -S --noconfirm \
                base-devel git stow curl wget \
                neovim vim micro mc ranger \
                htop btop ncdu tmux zsh fish \
                fzf ripgrep fd bat exa
            log_success "Основни пакети су инсталирани."
        fi
    fi
}

clone_additional_repos() {
    log_header "Клонирање додатних репозиторијума"
    
    # Листа репозиторијума за клонирање
    declare -A repos=(
        ["extra"]="$HOME/extra"
        ["dotwin"]="$HOME/dotwin"
        ["scripts"]="$HOME/scripts"
        ["crnogob69.github.io"]="$HOME/crnogob69.github.io"
        ["cbpaste"]="$HOME/cbpaste"
        ["cbrss"]="$HOME/cbrss"
        ["proto-orbita"]="$HOME/proto-orbita"
        ["galerija"]="$HOME/galerija"
        ["bitarctic-re"]="$HOME/bitarctic-re"
        ["py"]="$HOME/Desktop/py"
        ["c"]="$HOME/Desktop/c"
        ["dotdocs"]="$HOME/dotdocs"
    )
    
    if ! prompt_yes_no "Да ли желите да клонирате додатне репозиторијуме?"; онда
        log_info "Прескачем клонирање додатних репозиторијума."
        return 0
    fi
    
    # Проверавам и креирам Desktop директоријум ако не постоји
    if [[ ! -д "$HOME/Desktop" ]]; онда
        mkdir -p "$HOME/Desktop"
    fi
    
    # Клонирање репозиторијума
    for repo in "${!repos[@]}"; do
        dest="${repos[$repo]}"
        
        if [ ! -д "$dest" ]; онда
            log_info "Клонирам $repo у $dest"
            
            # Проверавам да ли да користим SSH или HTTPS
            if ssh -T git@github.com 2>&1 | grep -q "success"; онда
                git clone "git@github.com:$GITHUB_USERNAME/$repo.git" "$dest"
            else
                git clone "https://github.com/$GITHUB_USERNAME/$repo.git" "$dest"
            fi
            
            if [ $? -eq 0 ]; онда
                log_success "$repo клониран у $dest"
                
                # Додајем remote репозиторијуме
                cd "$dest" || continue
                git remote rename origin github || true
                git remote add bitbucket "git@bitbucket.org:$BITBUCKET_USERNAME/$repo.git" 2>/dev/null || true
                git remote add sourcehut "git@git.sr.ht:~$SOURCEHUT_USERNAME/$repo.git" 2>/dev/null || true
                git remote add gitlab "git@gitlab.com:$GITLAB_USERNAME/$repo.git" 2>/dev/null || true
                git remote add codeberg "git@codeberg.org/$CODEBERG_USERNAME/$repo.git" 2>/dev/null || true
                git remote add gitea "git@gitea.com:$GITEA_USERNAME/$repo.git" 2>/dev/null || true
            else
                log_error "Грешка при клонирању $repo"
            fi
        else
            log_info "$repo већ постоји у $dest"
        fi
    done
    
    log_success "Клонирање додатних репозиторијума завршено."
}

apply_dotfiles() {
    log_header "Примена Dotfiles конфигурације"
    
    cd "$DOTFILES_DIR" || return 1
    
    if ! command -v stow >/dev/null 2>&1; онда
        log_error "GNU Stow није инсталиран. Инсталирам..."
        sudo pacman -S --noconfirm stow
    fi
    
    if stow .; онда
        log_success "Dotfiles успешно примењени."
    else
        log_error "Грешка при примени dotfiles."
        return 1
    fi
}

install_atuin() {
    log_header "Инсталација Atuin-а"
    
    if command -v atuin >/dev/null 2>&1; онда
        log_info "Atuin је већ инсталиран."
    else
        log_info "Инсталирам Atuin..."
        curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    fi
    
    # Примена atuin конфигурације
    if [ -д "$DOTFILES_DIR/atuin" ]; онда
        rm -f ~/.config/atuin/config.toml 2>/dev/null
        cd "$DOTFILES_DIR" || return 1
        stow atuin
        log_success "Atuin конфигурација примењена."
    fi
    
    if prompt_yes_no "Да ли желите да се пријавите на Atuin?"; онда
        atuin login
        atuin sync
        log_success "Пријава на Atuin завршена."
    else
        log_info "Пријава на Atuin прескочена."
    fi
}

install_bat() {
    log_header "Конфигурација Bat-а"
    
    if ! command -v bat >/dev/null 2>&1; онда
        log_info "Инсталирам bat..."
        sudo pacman -S --noconfirm bat
    fi
    
    if [ -д "$DOTFILES_DIR/bat" ]; онда
        rm -f ~/.config/bat/config 2>/dev/null
        mkdir -p ~/.config/bat
        cd "$DOTFILES_DIR" || return 1
        stow bat
        log_success "Bat конфигурација примењена."
    else
        log_info "Bat конфигурација није пронађена у dotfiles."
    fi
}

install_filen() {
    log_header "Инсталација Filen.io клијента"
    
    if command -v filen-cli >/dev/null 2>&1; онда
        log_info "Filen.io клијент је већ инсталиран."
    else
        log_info "Инсталирам Filen.io клијент..."
        curl -sL https://filen.io/cli.sh | bash
        log_success "Filen.io клијент успешно инсталиран."
    fi
    
    if prompt_yes_no "Да ли желите да се пријавите на Filen.io?"; онда
        filen-cli auth
        log_success "Пријава на Filen.io завршена."
    else
        log_info "Пријава на Filen.io прескочена."
    fi
}

install_wakapi() {
    log_header "Wakapi информације"
    
    if [ -f "$DOTFILES_DIR/scripts/install-wakapi.sh" ]; онда
        log_info "За постављање Wakapi покрените:"
        log_info "${GREEN}$DOTFILES_DIR/scripts/install-wakapi.sh${NC}"
    else
        log_info "Скрипта за инсталацију Wakapi није пронађена."
    fi
}

# Главна функција
main() {
    setup_logging
    
    if ! check_requirements; онда
        log_error "Нису испуњени сви предуслови за инсталацију."
        return 1
    fi
    
    update_system
    
    if ! setup_ssh_keys; онда
        if ! prompt_yes_no "Да ли желите да наставите инсталацију без SSH кључева?"; онда
            log_error "Инсталација прекинута."
            return 1
        fi
    fi
    
    if ! clone_dotfiles; онда
        log_error "Грешка при клонирању dotfiles репозиторијума."
        return 1
    fi
    
    configure_git
    install_packages
    apply_dotfiles
    clone_additional_repos
    install_atuin
    install_bat
    install_filen
    install_wakapi
    
    log_header "Инсталација је завршена: $(date)"
    log_success "Све компоненте су успешно инсталиране и конфигурисане."
    
    # Покажи завршне информације
    log_info "\nЗа потпуно искуство, препоручујемо да се одјавите и поново пријавите у систем."
    log_info "Затим проверите ~/.zshrc, ~/.bashrc, или одговарајуће конфигурационе датотеке."
    
    return 0
}

# Извршавање главне функције
main "$@"