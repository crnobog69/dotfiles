#!/bin/bash

COLOR_PRIMARY="#e54b4b"    # imperial-red
COLOR_SUCCESS="#ffa987"    # atomic-tangerine
COLOR_ERROR="#444140"      # jet
COLOR_HIGHLIGHT="#f7ebe8"  # seashell
COLOR_ACCENT="#1e1e24"     # raisin-black
COLOR_BORDER="#e54b4b"     # imperial-red for border

# Check if Gum is installed
if ! command -v gum &> /dev/null; then
    echo "Gum is not installed. Please install it first."
    exit 1
fi

# Repository paths
DOTFILES_REPO="${HOME}/dotfiles"
EXTRA_REPO="${HOME}/extra"
SCRIPTS_REPO="${HOME}/scripts"
WEBSITE_REPO="${HOME}/crnobog69.github.io"
CBPASTE_REPO="${HOME}/cbpaste"
CBRSS_REPO="${HOME}/cbrss"
PROTO_ORBITA_REPO="${HOME}/proto-orbita"
GALERIJA_REPO="${HOME}/galerija"
BITARCTIC_REPO="${HOME}/bitarctic"
C_ZADACI_REPO="${HOME}/Desktop/c-zadaci"

# gum style \
#     --border double \
#     --align center \
#     --width 65 \
#     --margin "1" \
#     --padding "1" \
#     --foreground "$COLOR_HIHGLIGHT" \
#     --border-foreground "$COLOR_BORDER" \
#     "  _  _  ____  _  _  _ __  ____  _ __  ____ 
#  / \( \(  _ \/ )( \/ )  )/  __)/ )  )(_  _)
#  ) (/ ( ) __/) __ (\    \) (   \    \  )(  
# \___\/(__)  \_)(_/(__(_/\_/   (__(_/ (__) "

push_to_all_remotes() {
    local repo=$1
    gum style --border normal "Гурање директоријума: $(gum style --foreground "$COLOR_HIGHLIGHT" "$repo") на све удаљене репозиторијуме"
    cd "$repo" || exit
    
    for remote in github gitlab codeberg; do
        gum spin --spinner.foreground="$COLOR_PRIMARY" --title "Гурање на $remote..." --spinner dot -- sleep 1
        git add .
        git commit -m "❄️" || true
        if git push "$remote"; then
            gum style --foreground "$COLOR_SUCCESS" "Успешно погурано на $remote"
        else
            gum style --foreground "$COLOR_ERROR" "Грешла у гурању на $remote"
        fi
    done
}

push_to_github() {
    local repo=$1
    gum style --border normal "Гурање репозиторијума: $(gum style --foreground "$COLOR_HIGHLIGHT" "$repo") на GitHub"
    cd "$repo" || exit
    
    gum spin --spinner.foreground="$COLOR_PRIMARY" --title "Гурање на GitHub..." --spinner dot -- sleep 1
    git add .
    git commit -m "❄️" || true
    if git push github; then
        gum style --foreground "$COLOR_SUCCESS" "Испешбо погурано на GitHub"
    else
        gum style --foreground "$COLOR_ERROR" "Грешка у гурању на GitHub"
    fi
}

pull_from_all_remotes() {
    local repo=$1
    gum style --border normal "Повлачење репозиторијума: $(gum style --foreground "$COLOR_HIGHLIGHT" "$repo")"
    cd "$repo" || exit
    
    for remote in github gitlab codeberg; do
        gum spin --spinner.foreground="$COLOR_PRIMARY" --title "Pulling from $remote..." --spinner dot -- sleep 1
        if git pull "$remote"; then
            gum style --foreground "$COLOR_SUCCESS" "Успешно повучено са $remote !"
        else
            gum style --foreground "$COLOR_ERROR" "Грешка у повлачењу са $remote !"
        fi
    done
}

main_menu() {
    local choice
    choice=$(gum choose \
        --header=" ЦРНИГИТ - Git Helper " \
        --header.foreground="$COLOR_PRIMARY" \
        --cursor.foreground="#e54b4b" \
        --item.foreground="#f7ebe8" \
        --selected.foreground="#ffa987" \
        "Гурај све репозиторијуме" \
        "Гурај Dotfiles" \
        "Гурај Extra" \
        "Гурај Scripts" \
        "Гурај вебсајт" \
        "Гурај c-zadaci" \
        "Гурај CBPaste" \
        "Гурај CBRSS" \
        "Гурај Proto-Orbita" \
        "Гурај Galerija" \
        "Гурај Bitarctic" \
        "Повуци све репозиторијуме" \
        "Излаз")

    case "$choice" in
        "Гурај све репозиторијуме")
            push_to_all_remotes "$DOTFILES_REPO"
            push_to_all_remotes "$EXTRA_REPO"
            push_to_github "$SCRIPTS_REPO"
            push_to_github "$WEBSITE_REPO"
            push_to_github "$CBPASTE_REPO"
            push_to_github "$CBRSS_REPO"
            push_to_github "$PROTO_ORBITA_REPO"
            push_to_github "$GALERIJA_REPO"
            push_to_github "$BITARCTIC_REPO"
            push_to_github "$C_ZADACI_REPO"
            ;;
        "Гурај Dotfiles")
            push_to_all_remotes "$DOTFILES_REPO"
            ;;
        "Гурај Extrta")
            push_to_all_remotes "$EXTRA_REPO"
            ;;
        "Гурај Scripts")
            push_to_github "$SCRIPTS_REPO"
            ;;
        "Гурај вебсајт")
            push_to_github "$WEBSITE_REPO"
            ;;
        "Гурај c-zadaci")
            push_to_github "$C_ZADACI_REPO"
            ;;
        "Гурај CBPASTE")
            push_to_github "$CBPASTE_REPO"
            ;;
        "Гурај CBRSS")
            push_to_github "$CBRSS_REPO"
            ;;
        "Гурај Proto-Orbita")
            push_to_github "$PROTO_ORBITA_REPO"
            ;;
        "Гурај Galerija")
            push_to_github "$GALERIJA_REPO"
            ;;
        "Гурај Bitarctic")
            push_to_github "$BITARCTIC_REPO"
            ;;
        "Повуци све репозиторијуме")
            pull_from_all_remotes "$DOTFILES_REPO"
            pull_from_all_remotes "$EXTRA_REPO"
            pull_from_all_remotes "$SCRIPTS_REPO"
            pull_from_all_remotes "$WEBSITE_REPO"
            pull_from_all_remotes "$CBPASTE_REPO"
            pull_from_all_remotes "$CBRSS_REPO"
            pull_from_all_remotes "$PROTO_ORBITA_REPO"
            pull_from_all_remotes "$GALERIJA_REPO"
            pull_from_all_remotes "$C_ZADACI_REPO"
            ;;
        "Излаз")
            gum style --foreground "$COLOR_SUCCESS" " Довиђења!"
            exit 0
            ;;
    esac
    
    if gum confirm \
        --prompt.foreground="#f7ebe8" \
        --selected.background="#e54b4b" \
        --unselected.background="#1e1e24" \
        "Желите ли да извршите још неку операцију?"; then
        main_menu
    else
        gum style --foreground "$COLOR_SUCCESS" " Довиђења!"
    fi
}

main_menu
