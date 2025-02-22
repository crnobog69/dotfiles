```bash
cd ~
mv filen-cli /usr/local/bin/
cd ~/dotfiles/scripts/filen
sudo cp filen-cont.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable filen-cont.service
sudo systemctl start filen-cont.service
sudo systemctl status filen-cont.service
```
