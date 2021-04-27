#!/bin/bash
cd ~
sudo git clone https://github.com/rudebway/Rudebway.git
cp -r ~/Rudebway/ATOM/* ~
rm -rf ~/Rudebway/
chmod +x ATOM.sh
chmod +x update.sh
chmod +x ~/NGN/*