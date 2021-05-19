#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPUPD2="/tmp/cmdupd2.tmp"

ls ~/uuu-korda/old.firmwares | grep qspi- | cut -c22-28 >/tmp/table.tmp
ls ~/uuu-korda/ | grep qspi- | cut -c22-28 >/tmp/table.tmp
curl -s http://10.78.1.67/Alvarado/ | grep qspi | cut -c31-37 >/tmp/table.tmp

TABLE=$(cat /tmp/table.tmp)

STRINGS=$(wc -l /tmp/table.tmp)
MENU=$(
    x=1
    while x<=$STRINGS
    do
    STR=$(cat $TABLE | head -n$x | tail -n1)
    echo "$x $STR "
    done
)

dialog --title "Обновление" \
--backtitle "АТОМ $IPDFI" \
--menu "Выберите тип обновлений" 15 40 9 \
$MENU 2>$TMPUPD2
CMD2UPD=$(cat $TMPUPD2)
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
        if [ $(curl -s http://10.78.1.67/Alvarado/ | grep qspi | cut -c31-37) = $(ls ~/uuu-korda/ | grep qspi- | cut -c22-28) ]; then
            dialog --title "Проверка обновлений" \
            --msgbox "\n Обновление не требуется" 7 50
        else
            clear
            # cd ~/uuu-korda/
            # mkdir old.firmware
            # mv $(ls ~/uuu-korda/ | grep openwrt) ~/uuu-korda/old.firmware
            # wget -r --no-parent http://10.78.1.67/Alvarado/
            # rm ~/uuu-korda/10.78.1.67/Alvarado/index.html
            # mv ~/uuu-korda/10.78.1.67/Alvarado/* ~/uuu-korda/
            # mkdir web.firmware
            # mv $(ls ~/uuu-korda/ | grep sysup) ~/uuu-korda/web.firmware
            # rm -rf ~/uuu-korda/10.78.1.67/
            dialog --title "Проверка обновлений" \
            --msgbox "\n Обновление завершено" 7 50

        fi
        ./upd.sh
        ;;
    "3") ;;

    esac

fi
rm -f $TMPUPD2
