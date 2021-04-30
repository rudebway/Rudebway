#!/bin/bash
# 418-scripts
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPFCMD="/tmp/cmd.tmp"
dialog --title "Работа с АТОМом" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите необходимый тип работ" 15 40 9 \
    1 "Прошивка моторизации" \
    2 "Прошивка БКП" \
    3 "Настройка DFI" \
    4 "Подключение к БКП(БСИ)" \
    5 "Типовые решения" \
    6 "Обновления" \
    7 "Выход" 2>$TMPFCMD
CMD2RUN=$(cat $TMPFCMD)
if [ $? -eq "0" ]; then
    case $CMD2RUN in
    "1")
        cd NGN && ./mtr.sh && cd .. && ./ATOM.sh
        ;;
    "2")
        cd NGN && ./uuu.sh && cd .. && ./ATOM.sh
        ;;
    "3")
        cd NGN && ./dfi.sh && cd .. && ./ATOM.sh
        ;;
    "4")
        picocom -b 115200 /dev/ttyUSB0 && ./ATOM.sh
        ;;
    "5")
        cd NGN && ./tbl.sh && cd .. && ./ATOM.sh
        ;;
    "6") 
        cd NGN && ./upd.sh && cd .. && ./ATOM.sh
        ;;

    "7")
        exit
        ;;
    esac
fi
rm -f $TMPFCMD
echo "" >/tmp/ipdfi.tmp
