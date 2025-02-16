#!/bin/bash

# Инсталирање Git-а ако већ није инсталиран
if ! command -v git &> /dev/null
then
    echo "Git није инсталиран, инсталираћу га..."
    sudo pacman -S --noconfirm git
else
    echo "Git је већ инсталиран."
fi

# Постављање корисничког имена и email-а за Git
git config --global user.name "crnobog"
git config --global user.email "carskalavra@proton.me"

# Потврда конфигурације
echo "Git конфигурација је завршена."
git config --list

## SSH кључ

echo -e "SSH кључ"

ssh-keygen -t rsa -b 4096 -C "carskalavra@proton.me"

cat ~/.ssh/id_rsa.pub