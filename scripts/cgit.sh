#!/bin/bash

RED="#f38ba8"
YELLOW="#f9e2af"
GREEN="#a6e3a1"
LAVENDER="#cdd6f4"
DARK_RED="#e78284"
DARK_LAVENDER="#babbf1"

# Check if Gum is installed
if ! command -v gum &> /dev/null; then
    echo "Gum is not installed. Please install it first."
    exit 1
fi



# Repository paths
DOTFILES_REPO="${HOME}/dotfiles"
EXTRA_REPO="${HOME}/extra"
DOTWIN_REPO="${HOME}/dotwin"
SCRIPTS_REPO="${HOME}/scripts"
WEBSITE_REPO="${HOME}/crnobog69.github.io"
CBPASTE_REPO="${HOME}/cbpaste"
CBRSS_REPO="${HOME}/cbrss"
PROTO_ORBITA_REPO="${HOME}/proto-orbita"
GALERIJA_REPO="${HOME}/galerija"
BITARCTIC_REPO="${HOME}/bitarctic"
C_ZADACI_REPO="${HOME}/Desktop/c-zadaci"
PY_ZADACI_REPO="${HOME}/Desktop/py-zadaci"
DOTDOCS_REPO="${HOME}/dotdocs"
GALERIJA_MEDIA_REPO="${HOME}/galerija-media"

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
    gum style --border normal "Гурање директоријума: $(gum style --foreground "${YELLOW}" "$repo") на све удаљене репозиторијуме"
    cd "$repo" || exit
    
    for remote in github gitlab codeberg gitea bitbucket; do
        gum spin --spinner.foreground="${RED}" --title " Гурање на $remote..." --spinner dot -- sleep 1
        git add .
        git commit -m "❄️" || true
        if git push "$remote"; then
            echo
            gum style --foreground "${GREEN}" " Успешно погурано на $remote"
            echo
        else
            gum style --foreground "${RED}" " Грешла у гурању на $remote"
        fi
    done
}

push_to_github() {
    local repo=$1
    gum style --border normal "Гурање репозиторијума: $(gum style --foreground "${YELLOW}" "$repo") на GitHub"
    cd "$repo" || exit
    
    gum spin --spinner.foreground="${RED}" --title " Гурање на GitHub..." --spinner dot -- sleep 1
    git add .
    git commit -m "❄️" || true
    if git push github; then
        echo
        gum style --foreground "${GREEN}" " Испешбо погурано на GitHub"
        echo
    else
        gum style --foreground "${RED}" " Грешка у гурању на GitHub"
    fi
}

pull_from_all_remotes() {
    local repo=$1
    gum style --border normal "Повлачење репозиторијума: $(gum style --foreground "${YELLOW}" "$repo")"
    cd "$repo" || exit
    
    for remote in github gitlab codeberg gitea bitbucket; do
        gum spin --spinner.foreground="${YELLOW}" --title "Повлачење са $remote..." --spinner dot -- sleep 1
        if git pull "$remote"; then
            echo
            gum style --foreground "${GREEN}" " Успешно повучено са $remote !"
            echo
        else
            gum style --foreground "${RED}" " Грешка у повлачењу са $remote !"
        fi
    done
}

pull_from_github() {
    local repo=$1
    gum style --border normal "Повлачење репозиторијума: $(gum style --foreground "$YELLOW" "$repo") са GitHub-а"
    cd "$repo" || exit
    
    gum spin --spinner.foreground="$YELLOW" --title " Повлачење са GitHub..." --spinner dot -- sleep 1
    if git pull github; then
        gum style --foreground "$GREEN" " Успешно повучено са GitHub!"
    else
        gum style --foreground "$RED" " Грешка у повлачењу са GitHub!"
    fi
}

handle_repository() {
    local repo=$1
    local repo_name=$2
    local has_all_remotes=$3

    local operation
    operation=$(gum choose \
        --header=" Операције за $repo_name " \
        --header.foreground="$YELLOW" \
        --cursor.foreground="${RED}" \
        --item.foreground="${LAVENDER}" \
        --selected.foreground="${RED}" \
        " Гурај" \
        " Повуци" \
        " Назад")

    case "$operation" in
        " Гурај")
            if [ "$has_all_remotes" = true ]; then
                push_to_all_remotes "$repo"
            else
                push_to_github "$repo"
            fi
            return 0
            ;;
        " Повуци")
            if [ "$has_all_remotes" = true ]; then
                pull_from_all_remotes "$repo"
            else
                pull_from_github "$repo"
            fi
            return 0
            ;;
        " Назад")
            return 1
            ;;
    esac
}

search_repositories() {
    local selected
    selected=$(printf "%s\n" \
        "Dotfiles [$DOTFILES_REPO]" \
        "Extra [$EXTRA_REPO]" \
        "DotWin [$DOTWIN_REPO]" \
        "Scripts [$SCRIPTS_REPO]" \
        "Website [$WEBSITE_REPO]" \
        "CBPaste [$CBPASTE_REPO]" \
        "CBRSS [$CBRSS_REPO]" \
        "Proto-Orbita [$PROTO_ORBITA_REPO]" \
        "Galerija [$GALERIJA_REPO]" \
        "Galerija-Media [$GALERIJA_MEDIA_REPO]" \
        "Bitarctic [$BITARCTIC_REPO]" \
        "Py-Zadaci [$PY_ZADACI_REPO]" \
        "C-Zadaci [$C_ZADACI_REPO]" \
        "DotDocs [$DOTDOCS_REPO]" \
        "  Назад" | \
        gum filter \
            --placeholder "Претражи репозиторијуме..." \
            --indicator.foreground "${RED}" \
            --prompt.foreground "${RED}" \
            --match.foreground "${YELLOW}")

    if [ -n "$selected" ]; then
        if [ "$selected" = "  Назад" ]; then
            return 1
        fi
        
        local result=0
        case "$selected" in
            "Dotfiles"*)      handle_repository "$DOTFILES_REPO" "Dotfiles" true ;;
            "Extra"*)         handle_repository "$EXTRA_REPO" "Extra" true ;;
            "DotWin"*)        handle_repository "$DOTWIN_REPO" "DotWin" true ;;
            "Scripts"*)       handle_repository "$SCRIPTS_REPO" "Scripts" false ;;
            "Website"*)       handle_repository "$WEBSITE_REPO" "Website" false ;;
            "CBPaste"*)       handle_repository "$CBPASTE_REPO" "CBPaste" false ;;
            "CBRSS"*)        handle_repository "$CBRSS_REPO" "CBRSS" false ;;
            "Proto-Orbita"*) handle_repository "$PROTO_ORBITA_REPO" "Proto-Orbita" false ;;
            "Galerija"*)     handle_repository "$GALERIJA_REPO" "Galerija" false ;;
            "Galerija-Media"*) handle_repository "$GALERIJA_MEDIA_REPO" "Galerija-Media" false ;;
            "Bitarctic"*)    handle_repository "$BITARCTIC_REPO" "Bitarctic" false ;;
            "Py-Zadaci"*)    handle_repository "$PY_ZADACI_REPO" "Py-Zadaci" false ;;
            "C-Zadaci"*)     handle_repository "$C_ZADACI_REPO" "C-Zadaci" false ;;
            "DotDocs"*)      handle_repository "$DOTDOCS_REPO" "DotDocs" false ;;
        esac
        result=$?
        [ "$result" -eq 1 ] && return 1
        return 0
    fi
    return 1
}

main_menu() {
    while true; do
        local choice
        choice=$(gum choose \
            --header="    ЦрниГит " \
            --header.foreground="$YELLOW" \
            --cursor.foreground="${RED}" \
            --item.foreground="${LAVENDER}" \
            --selected.foreground="${RED}" \
            "  Претрага" \
            "  | Dotfiles" \
            "  | Extra" \
            "  | DotWin" \
            "  | Scripts" \
            "  | Website" \
            "  | CBPaste" \
            "  | CBRSS" \
            "  | Proto-Orbita" \
            "  | Galerija" \
            "  | Galerija-Media" \
            "  | Bitarctic" \
            "  | Py-Zadaci" \
            "  | C-Zadaci" \
            "  | DotDocs" \
            "󰒆  Све репозиторијуме" \
            "󰈆  Излаз")

        case "$choice" in
            "  Претрага")
                search_repositories
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Dotfiles")
                handle_repository "$DOTFILES_REPO" "Dotfiles" true
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Extra")
                handle_repository "$EXTRA_REPO" "Extra" true
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | DotWin")
                handle_repository "$DOTWIN_REPO" "DotWin" true
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Scripts")
                handle_repository "$SCRIPTS_REPO" "Scripts" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Website")
                handle_repository "$WEBSITE_REPO" "Website" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | CBPaste")
                handle_repository "$CBPASTE_REPO" "CBPaste" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | CBRSS")
                handle_repository "$CBRSS_REPO" "CBRSS" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Proto-Orbita")
                handle_repository "$PROTO_ORBITA_REPO" "Proto-Orbita" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Galerija")
                handle_repository "$GALERIJA_REPO" "Galerija" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Galerija-Media")
                handle_repository "$GALERIJA_MEDIA_REPO" "Galerija-Media" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Bitarctic")
                handle_repository "$BITARCTIC_REPO" "Bitarctic" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | Py-Zadaci")
                handle_repository "$PY_ZADACI_REPO" "Py-Zadaci" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | C-Zadaci")
                handle_repository "$C_ZADACI_REPO" "C-Zadaci" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "  | DotDocs")
                handle_repository "$DOTDOCS_REPO" "DotDocs" false
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "󰒆  Све репозиторијуме")
                handle_all_repositories
                if [ $? -eq 1 ]; then
                    continue
                fi
                ;;
            "󰈆  Излаз")
                gum style --foreground "$COLOR_SUCCESS" " Довиђења!"
                exit 0
                ;;
        esac

        if ! gum confirm \
            --prompt.foreground="${YELLOW}" \
            --selected.background="${DARK_RED}" \
            --unselected.background="${DARK_LAVENDER}" \
            "Желите ли да извршите још неку операцију?"; then
            gum style --foreground "$YELLOW" " Довиђења!"
            exit 0
        fi
    done
}

handle_all_repositories() {
    local operation
    operation=$(gum choose \
        --header=" Операције за све репозиторијуме " \
        --header.foreground="$YELLOW" \
        --cursor.foreground="${RED}" \
        --item.foreground="${LAVENDER}" \
        --selected.foreground="${RED}" \
        " Гурај све" \
        " Повуци све" \
        " Назад")

    case "$operation" in
        " Гурај све")
            push_to_all_remotes "$DOTFILES_REPO"
            push_to_all_remotes "$EXTRA_REPO"
            push_to_all_remotes "$DOTWIN_REPO"
            push_to_github "$SCRIPTS_REPO"
            push_to_github "$WEBSITE_REPO"
            push_to_github "$PY_ZADACI_REPO"
            push_to_github "$C_ZADACI_REPO"
            push_to_github "$CBPASTE_REPO"
            push_to_github "$CBRSS_REPO"
            push_to_github "$PROTO_ORBITA_REPO"
            push_to_github "$GALERIJA_REPO"
            push_to_github "$GALERIJA_MEDIA_REPO"
            push_to_github "$BITARCTIC_REPO"
            push_to_github "$DOTDOCS_REPO"
            return 0
            ;;
        " Повуци све")
            pull_from_all_remotes "$DOTFILES_REPO"
            pull_from_all_remotes "$EXTRA_REPO"
            pull_from_all_remotes "$DOTWIN_REPO"
            pull_from_github "$SCRIPTS_REPO"
            pull_from_github "$WEBSITE_REPO"
            pull_from_github "$PY_ZADACI_REPO"
            pull_from_github "$C_ZADACI_REPO"
            pull_from_github "$CBPASTE_REPO"
            pull_from_github "$CBRSS_REPO"
            pull_from_github "$GALERIJA_REPO"
            pull_from_github "$GALERIJA_MEDIA_REPO"
            pull_from_github "$PROTO_ORBITA_REPO"
            pull_from_github "$BITARCTIC_REPO"
            pull_from_github "$DOTDOCS_REPO"
            return 0
            ;;
        " Назад")
            return 1
            ;;
    esac
}

main_menu