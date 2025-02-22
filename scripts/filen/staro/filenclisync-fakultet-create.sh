#!/bin/bash

# Configuration variables
WATCH_DIR="/run/media/lain/VERMAHT/Факултет/"
USERNAME="lain"
SCRIPT_NAME="filen-sync-fakultet.sh"
SERVICE_NAME="filen-sync-fakultet.service"
SCRIPT_DIR="/home/lain/dotfiles/scripts/filen/"

# Ensure the script directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
    sudo mkdir -p "$SCRIPT_DIR"
fi

# Check if inotify-tools is installed
if ! command -v inotifywait &> /dev/null; then
    echo "Installing inotify-tools..."
    sudo pacman -S --noconfirm inotify-tools
fi

# Create the watch script
echo "Creating the watch script..."
sudo cat <<EOF > "$SCRIPT_DIR/$SCRIPT_NAME"
#!/bin/bash

while inotifywait -r -e modify,create,delete,move "$WATCH_DIR"; do
    /home/lain/filen-cli sync
done
EOF

# Make the watch script executable
sudo chmod +x "$SCRIPT_DIR/$SCRIPT_NAME"

# Create the systemd service file
echo "Creating the systemd service file..."
sudo cat <<EOF > "/etc/systemd/system/$SERVICE_NAME"
[Unit]
Description=Watch directory and run filen-cli sync
After=network.target

[Service]
Type=simple
User=$USERNAME
ExecStart="$SCRIPT_DIR/$SCRIPT_NAME"
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

sudo cp filen-sync-fakultet.timer /etc/systemd/system

sudo systemctl enable filen-sync-fakultet.timer
sudo systemctl start filen-sync-fakultet.timer

# Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable and start the service
echo "Enabling and starting the service..."
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl start "$SERVICE_NAME"

# Check the service status
echo "Checking service status..."
sudo systemctl status "$SERVICE_NAME"

echo "Setup complete. Test by making changes in $WATCH_DIR."