#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPUPD2="/tmp/cmdupd2.tmp"

ls ~/uuu-korda/old.firmware | grep qspi- | cut -c22-28 >/tmp/table.tmp
ls ~/uuu-korda/ | grep qspi- | cut -c22-28 >>/tmp/table.tmp
curl -s http://10.78.1.67/Alvarado/ | grep qspi | cut -c31-37 >>/tmp/table.tmp
cat /tmp/table.tmp | awk '! a[$0]++' >/tmp/table2.tmp
TABLE=$(cat /tmp/table.tmp)
TABLE2=$(cat /tmp/table2.tmp)
STRINGS=$(wc -l /tmp/table2.tmp | awk '{print $1}')
MENU=$(
    x=1
    while [ $x -le "$STRINGS" ]; do
        STR=$(cat /tmp/table2.tmp | head -n$x | tail -n1)
        echo $x
        echo $STR
        x=$(($x + 1))
    done
)
dialog --title "Обновление" \
--backtitle "АТОМ $IPDFI" \
--menu "Выберите тип обновлений" 15 40 9 \
$MENU 2>$TMPUPD2
NUMUPD=$(cat /tmp/table2.tmp | head -n$(cat $TMPUPD2) | tail -n1 | awk '{print $1}')
if [ $NUMUPD = $(ls ~/uuu-korda/ | grep qspi- | cut -c22-28) ]; then
    dialog --title "Проверка обновлений" \
    --msgbox "\n Обновление не требуется" 7 50
elif [ $NUMUPD = $(ls ~/uuu-korda/old.firmware | grep qspi- | cut -c22-28 | grep $NUMUPD) ]; then
    clear
    cd ~/uuu-korda/
    mv $(ls | grep cortex) ~/uuu-korda/old.firmware
    cd ~/uuu-korda/old.firmware
    mv $(ls | grep $NUMUPD) ~/uuu-korda/
    dialog --title "Проверка обновлений" \
    --msgbox "\n Обновление завершено" 7 50
else
    clear
    cd ~/uuu-korda/
    mkdir old.firmware
    mv $(ls ~/uuu-korda/ | grep openwrt) ~/uuu-korda/old.firmware
    wget -r --no-parent http://10.78.1.67/Alvarado/
    rm ~/uuu-korda/10.78.1.67/Alvarado/index.html
    mv ~/uuu-korda/10.78.1.67/Alvarado/* ~/uuu-korda/
    mkdir web.firmware
    mv $(ls ~/uuu-korda/ | grep sysup) ~/uuu-korda/web.firmware
    rm -rf ~/uuu-korda/10.78.1.67/
    dialog --title "Проверка обновлений" \
    --msgbox "\n Обновление завершено" 7 50
fi