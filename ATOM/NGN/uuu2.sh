#!/bin/bash
clear
echo "===================================================Прошивка БКП======================================================="
echo "введите серийный номер"
read SN
echo $SN #повторение строки сделано для проверки введенной информации
echo "введите внутренний мак-адрес"
read INTMAC
echo $INTMAC
echo "введите внешний мак-адрес"
read EXMAC
echo $EXMAC
echo "введите логин VPN"
read LOGIN
echo $LOGIN
echo "введите пароль VPN"
read PASS
echo $PASS
#echo "=======================================================QSPI==========================================================="
#cd ~/uuu-korda/ && ./uuu-qspi.sh $(ls . | grep qspi-) u-boot.imx
echo "========================================================MMC==========================================================="
cd ~/uuu-korda2/ && ./uuu-mmc.sh $(ls . | grep mmc-) u-boot.imx $LOGIN $PASS
sudo ip addr add 192.168.100.128/24 dev enp2s0
ssh-keygen -f "/root/.ssh/known_hosts" -R 192.168.100.100
ssh-keyscan -H 192.168.100.100 >>/root/.ssh/known_hosts
sshpass -p 'Fx566434' ssh user@192.168.100.100 '#############################'
echo "=======================================================EEPROM========================================================="
cd ~/uuu-korda2/ && ./uuu-eeprom.sh u-boot.imx ATOM $SN $INTMAC $EXMAC
echo "========================================================DONE=========================================================="
echo "===================================================Press any key======================================================"
echo "======================================================================================================================"
read -s -n 1