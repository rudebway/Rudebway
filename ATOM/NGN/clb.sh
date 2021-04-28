#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPCLB="/tmp/cmdclb.tmp"
dialog --title "Настройки и тесты" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите настройку или тест" 15 40 9 \
    1 "Просмотр каталогa /dev/" \
    2 "Работа радара" \
    3 "Работа GPS" \
    4 "Калибровка фокусировки" \
    5 "Калибровка диафрагмы" \
    6 "Назад" 2>$TMPCLB
CMD2CLB=$(cat $TMPCLB)
if [ $? -eq "0" ]; then
    case $CMD2CLB in
    "1")
        DEV=$(sshpass -p 'Fx566434' ssh admin@$IPDFI 'ls /dev/ | grep ttyUSB')
        dialog --title "Наличие USB в каталоге /dev/" \
        --msgbox "\n $DEV" 6 50
        ./clb.sh
        ;;
    "2")
        IPDFI=$(cat /tmp/ipdfi.tmp)
        timeout 5s sshpass -p 'Fx566434' ssh admin@$IPDFI 'picocom -b 115200 /dev/ttyS0'
        ./clb.sh
        ;;
    "3")
        IPDFI=$(cat /tmp/ipdfi.tmp)
        timeout 5s sshpass -p 'Fx566434' ssh admin@$IPDFI 'picocom -b 9600 /dev/ublox'
        ./clb.sh
        ;;
    "4")
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'sudo systemctl stop cortes'
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'cortes-lctrl callib Focus 74000 30000 -p /dev/leans'
        ./clb.sh
        ;;
    "5")
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'sudo systemctl stop cortes'
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'cortes-lctrl callib Diaphragm 2400 5000 -p /dev/leans'
        ./clb.sh
        ;;
    "6") ;;

    esac
fi
rm -f $TMPCLB
