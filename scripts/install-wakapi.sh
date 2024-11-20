#!/bin/bash

# Lokacija gde se nalazi binarna datoteka Wakapi (direktno u /home/lain)
WAKAPI_BIN="/home/lain/wakapi"

# Kreiranje systemd servisa
echo "Kreiranje systemd servisa za Wakapi..."

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

# Omogućavanje servisa da se automatski pokrene pri startovanju sistema
echo "Omogućavanje servisa da se pokrene pri startovanju sistema..."
sudo systemctl enable wakapi.service

# Pokretanje servisa
echo "Pokretanje Wakapi servisa..."
sudo systemctl start wakapi.service

# Provera statusa servisa
echo "Provera statusa Wakapi servisa..."
sudo systemctl status wakapi.service
