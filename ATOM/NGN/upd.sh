#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPUPD="/tmp/cmdupd.tmp"
dialog --title "Обновление" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите тип обновлений" 15 40 9 \
    1 "Обновление данной программы" \
    2 "Обновление прошивки БКП" \
    3 "Назад" 2>$TMPUPD
CMD2UPD=$(cat $TMPUPD)
if [ $? -eq "0" ]; then
    case $CMD2UPD in
    "1")
        cd ~
        sudo git clone https://github.com/rudebway/Rudebway.git
        cp -r ~/Rudebway/ATOM/* ~
        rm -rf ~/Rudebway/
        chmod +x ATOM.sh
        chmod +x update.sh
        chmod +x ~/NGN/*
        cd ~/NGN/
        ./upd.sh
        ;;
    "2")
        VERALV=$(ls )
        if []

        ./upd.sh
        ;;
    "3")
        ;;

    esac
fi
rm -f $TMPUPD
