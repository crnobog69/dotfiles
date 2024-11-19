#!/bin/bash

# Unison инсталациона скрипта
# Креира systemd timer за пкретање скрипте свака 3 сата

# Unison инсталација
# Креирање директоријума
mkdir -p /home/lain/.unison/

# Копирање конфигурационог фајла
cp /home/lain/dotfiles/scripts/unison/c_sync.prf home/lain/.unison/

# Позив унисона
echo "Pozivam unison..."
unison c_sync.prf -batch

# Права доступа за синхронизацију скрипте
echo "Права доступа за синхронизацију скрипте..."
chmod +x /home/lain/dotfiles/scripts/unison-csync.sh

# Копирање systemd датотека
echo "Копирање systemd датотека..."
sudo cp unison-csync.service /etc/systemd/system/ || { echo "Failed to copy service file"; exit 1; }
sudo cp unison-csync.timer /etc/systemd/system/ || { echo "Failed to copy timer file"; exit 1; }

# Поновно поретање systemd
echo "Поновно поретање systemd..."
sudo systemctl daemon-reload

# Омогућавање и покретање тајмера
echo "Омогућавање и покретање тајмера..."
sudo systemctl enable unison-csync.timer
sudo systemctl start unison-csync.timer

echo "Инсталација завршена. Испитивање статуса тајмера..."
systemctl list-timers unison-csync.timer
