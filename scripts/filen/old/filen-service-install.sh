#!/bin/bash

# Exit on error
set -e

# Replace USERNAME with actual username
USERNAME=$(whoami)

# Create service file
sudo tee /etc/systemd/system/filen-sync.service > /dev/null << EOL
[Unit]
Description=Filen CLi Sync Service
After=network.target

[Service]
Type=oneshot
ExecStart=/home/${USERNAME}/filen-cli
User=${USERNAME}

[Install]
WantedBy=multi-user.target
EOL

# Create timer file
sudo tee /etc/systemd/system/filen-sync.timer > /dev/null << EOL
[Unit]
Description=Run Filen CLI Sync every 30 minutes

[Timer]
OnCalendar=*:0/30
Persistent=true

[Install]
WantedBy=timers.target
EOL

# Make the filensync.sh script executable
chmod +x ~/dotfiles/scripts/filen/filensync.sh

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable and start the timer
sudo systemctl enable filen-sync.timer
sudo systemctl start filen-sync.timer

# Run the service once
sudo systemctl start filen-sync.service

echo "Filen CLI Sync service and timer have been installed and started."
echo "You can check the timer status with: systemctl status filen-sync.timer"
echo "You can check the service status with: systemctl status filen-sync.service" 