#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
LAVENDER='\033[38;2;180;191;254m'
NC='\033[0m' # No Color

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo -e "${RED}jq is not installed. Please install it using: sudo pacman -S jq${NC}"
    exit 1
fi

# Function to check if a package is installed (for pacman and chaotic-aur packages)
is_installed() {
    pacman -Qi "$1" &>/dev/null
}

# Function to check if an AUR package is installed (uses yay)
is_aur_installed() {
    yay -Qi "$1" &>/dev/null
}

# Function to display package status
show_packages_status() {
    local package_type="$1"
    local packages=("${!2}")

    if [ ${#packages[@]} -eq 0 ]; then
        echo -e "${RED}No packages to check in the category ${package_type}.${NC}"
        return
    fi

    echo -e "\n==> Checking ${package_type} packages:"
    for package in "${packages[@]}"; do
        if is_installed "$package" || is_aur_installed "$package"; then
            echo -e "${GREEN}Package '$package' is already installed.${NC}"
        else
            echo -e "${RED}Package '$package' is not installed.${NC}"
        fi
    done
}

# Function to check if there are any uninstalled packages in a category
has_uninstalled_packages() {
    local packages=("${!1}")
    for package in "${packages[@]}"; do
        if ! is_installed "$package" && ! is_aur_installed "$package"; then
            return 0  # At least one package is not installed
        fi
    done
    return 1  # All packages are installed
}

# Function that prompts the user if they want to install packages from a specific category
prompt_install_all() {
    local package_type="$1"
    read -rp "Do you want to install all packages from the ${package_type} category? [y/N]: " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Install packages using pacman
install_pacman() {
    show_packages_status "Pacman" pacman_packages[@]
    if has_uninstalled_packages pacman_packages[@]; then
        if prompt_install_all "Pacman"; then
            for package in "${pacman_packages[@]}"; do
                if ! is_installed "$package"; then
                    echo -e "\n==> Installing package: $package"
                    sudo pacman -S --needed --noconfirm "$package"
                fi
            done
        else
            echo -e "${RED}Skipping Pacman package installation.${NC}"
        fi
    else
        echo -e "${LAVENDER}All Pacman packages are already installed.${NC}"
    fi
}

# Install packages from the chaotic-aur repository
install_chaoticaur() {
    show_packages_status "Chaotic AUR" chaoticaur_packages[@]
    if has_uninstalled_packages chaoticaur_packages[@]; then
        if prompt_install_all "Chaotic AUR"; then
            for package in "${chaoticaur_packages[@]}"; do
                if ! is_installed "$package"; then
                    echo -e "\n==> Installing Chaotic AUR package: $package"
                    sudo pacman -S --needed --noconfirm chaotic-aur/"$package"
                fi
            done
        else
            echo -e "${RED}Skipping Chaotic AUR package installation.${NC}"
        fi
    else
        echo -e "${LAVENDER}All Chaotic AUR packages are already installed.${NC}"
    fi
}

# Install AUR packages using yay
install_yay() {
    show_packages_status "AUR" aur_packages[@]
    if has_uninstalled_packages aur_packages[@]; then
        if prompt_install_all "AUR"; then
            for package in "${aur_packages[@]}"; do
                if ! is_aur_installed "$package"; then
                    echo -e "\n==> Installing AUR package: $package"
                    yay -S --needed --noconfirm "$package"
                fi
            done
        else
            echo -e "${RED}Skipping AUR package installation.${NC}"
        fi
    else
        echo -e "${LAVENDER}All AUR packages are already installed.${NC}"
    fi
}

# Load packages from a JSON file using jq
load_packages() {
    if [ ! -f "$1" ]; then
        echo -e "${RED}File '$1' not found. Make sure it's in the same directory as the script.${NC}"
        exit 1
    fi

    pacman_packages=($(jq -r '.pacman[]' "$1"))
    chaoticaur_packages=($(jq -r '.chaoticaur[]' "$1"))
    aur_packages=($(jq -r '.aur[]' "$1"))
}

# Menu for user selection
show_menu() {
    echo "Select the installation method:"
    echo "1) Only pacman"
    echo "2) pacman + chaotic-aur"
    echo "3) Only yay"
    echo "4) yay + pacman"
    echo "5) pacman + chaotic-aur + yay"
    read -rp "Your choice: " choice
}

# Check if yay is installed
check_yay() {
    if ! command -v yay &>/dev/null; then
        echo "yay is not installed."
        echo "You can install it by following the instructions at: https://github.com/Jguer/yay"
        exit 1
    fi
}

# Main function
main() {
    local json_file="packages.json"
    load_packages "$json_file"
    show_menu

    case $choice in
        1) install_pacman ;;
        2) install_pacman; install_chaoticaur ;;
        3) check_yay; install_yay ;;
        4) install_pacman; check_yay; install_yay ;;
        5) install_pacman; install_chaoticaur; check_yay; install_yay ;;
        *) echo -e "${RED}Invalid choice.${NC}"; exit 1 ;;
    esac
}

main "$@"
