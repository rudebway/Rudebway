#!/bin/bash
# (C) 418
sudo apt-get install --assume-yes cmake make libc6* libqt5* pkg-config libusb-1.0.0-dev curl gcc progress git openssh-server ssh sshpass
cd ~
sudo git clone http://git.korda-group.local/cortes/boards/motioncontroller/flasher.git
cd flasher/
./buildUtility.sh
cd ..
sudo git clone https://github.com/stlink-org/stlink
cd stlink
cmake .
make
cd bin
sudo cp st-* /usr/local/bin
cd ../lib
sudo cp *.so* /lib32
sudo cp stlink/config/udev/rules.d/49-stlinkv* /etc/udev/rules.d/
systemctl start sshd
systemctl stop sshd
echo "PermitRootLogin yes" >>/etc/ssh/sshd_config
systemctl restart sshd
cd ~
mkdir /serv
mount -t cifs -o username=root,password=Fx566434 //10.78.9.10/PrOt /serv
echo "mount -t cifs -o username=root,password=Fx566434 //10.78.9.10/PrOt /serv " | cat > /etc/network/mcifs.ch
chmod +x /etc/network/mcifs.ch
cp -R /serv/ATOM/uuu-korda ~/uuu-korda
cp /serv/ATOM/firmwares/* ~/uuu-korda & progress -mp $!
cd ~
sudo git clone https://github.com/rudebway/Rudebway.git
cp -r ~/Rudebway/ATOM/* ~
rm -rf ~/Rudebway/
chmod +x ATOM.sh
chmod +x ~/NGN/*
cd ~
echo "export NCURSES_NO_UTF8_ACS=1" >> .bashrc
source ~/.bashrc
