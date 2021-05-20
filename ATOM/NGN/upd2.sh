#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPUPD2="/tmp/cmdupd2.tmp"

ls ~/uuu-korda/old.firmware | grep qspi- | cut -c22-28 >/tmp/table.tmp
ls ~/uuu-korda/ | grep qspi- | cut -c22-28 >>/tmp/table.tmp
curl -s http://10.78.1.67/Alvarado/ | grep qspi | cut -c31-37 >>/tmp/table.tmp
sort /tmp/table.tmp | uniq -u > /tmp/table.tmp
TABLE=$(cat /tmp/table.tmp)

STRINGS=$(wc -l /tmp/table.tmp | awk '{print $1}')
MENU=$(
    x=1
    while [ $x -le "$STRINGS" ]; do
        STR=$(cat /tmp/table | head -n$x | tail -n1)
        echo $x
        echo $STR
        x=$(($x + 1))
    done
)

dialog --title "Обновление" \
--backtitle "АТОМ $IPDFI" \
--menu "Выберите тип обновлений" 15 40 9 \
$MENU 2>$TMPUPD2


echo "cat /tmp/table | head -n$(cat $TMPUPD2) | tail -n1 | awk '{print $2}'"