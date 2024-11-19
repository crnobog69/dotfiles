#!/bin/bash

unison c_sync.prf

# Make script executable
echo "Making sync script executable..."
chmod +x /home/lain/dotfiles/scripts/unison-csync.sh

# Copy systemd files
echo "Copying systemd files..."
sudo cp unison-csync.service /etc/systemd/system/ || { echo "Failed to copy service file"; exit 1; }
sudo cp unison-csync.timer /etc/systemd/system/ || { echo "Failed to copy timer file"; exit 1; }

# Reload systemd
echo "Reloading systemd..."
sudo systemctl daemon-reload

# Enable and start timer
echo "Enabling and starting timer..."
sudo systemctl enable unison-csync.timer
sudo systemctl start unison-csync.timer

echo "Installation complete. Checking timer status..."
systemctl list-timers unison-csync.timer