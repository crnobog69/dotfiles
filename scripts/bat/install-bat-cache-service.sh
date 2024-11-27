#!/bin/bash

# Exit on error
set -e

# Replace USERNAME with actual username
USERNAME=$(whoami)

# Create service file
sudo tee /etc/systemd/system/bat-cache.service > /dev/null << EOL
[Unit]
Description=Build bat syntax highlighting cache
After=network.target

[Service]
Type=oneshot
ExecStart=/home/${USERNAME}/dotfiles/scripts/bat/bat-cache.sh
User=${USERNAME}

[Install]
WantedBy=multi-user.target
EOL

# Create timer file
sudo tee /etc/systemd/system/bat-cache.timer > /dev/null << EOL
[Unit]
Description=Run bat cache builder every 30 minutes

[Timer]
OnCalendar=*:0/30
Persistent=true

[Install]
WantedBy=timers.target
EOL

# Make the bat-cache.sh script executable
chmod +x ~/dotfiles/scripts/bat/bat-cache.sh

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable and start the timer
sudo systemctl enable bat-cache.timer
sudo systemctl start bat-cache.timer

# Run the service once
sudo systemctl start bat-cache.service

echo "Bat cache service and timer have been installed and started."
echo "You can check the timer status with: systemctl status bat-cache.timer"
echo "You can check the service status with: systemctl status bat-cache.service" 