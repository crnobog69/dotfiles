#!/bin/bash

# Локација где се налази бинарна датотека Wakapi (директно у /home/lain)
WAKAPI_BIN="/home/lain/wakapi"

# Креирање systemd сервиса
echo "Креирање systemd сервиса за Wakapi..."

cat <<EOF | sudo tee /etc/systemd/system/wakapi.service > /dev/null
[Unit]
Description=Wakapi Service
After=network.target

[Service]
ExecStart=$WAKAPI_BIN
WorkingDirectory=/home/lain
Restart=always
User=lain
Group=lain

[Install]
WantedBy=multi-user.target
EOF

# Омогућавање сервиса да се покрене при стартовању система
echo "Омогућавање сервиса да се покрене при стартовању система..."
sudo systemctl enable wakapi.service

# Покретање сервиса
echo "Покретање Wakapi сервиса..."
sudo systemctl start wakapi.service

# Провера статуса сервиса
echo "Провера статуса Wakapi сервиса..."
sudo systemctl status wakapi.service
