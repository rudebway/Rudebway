#!/bin/bash
# (c) 418
LICTMPFILE="/tmp/licfile.tmp"
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPFCMD="/tmp/cmd.tmp"
dialog --title "Работа с АТОМом" \
--backtitle "АТОМ $IPDFI" \
--menu "Выберите необходимый тип работ" 15 40 9 \
1 "Прошивка моторизации" \
2 "Прошивка БКП" \
3 "Прошивка нового iMX" \
4 "Настройка DFI" \
5 "Подключение к БКП(БСИ)" \
6 "Типовые решения" \
7 "Обновления" \
8 "Выход" 2>$TMPFCMD
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
        cd NGN && ./uuu2.sh && cd .. && ./ATOM.sh
        ;;
    "4")
        cd NGN && ./dfi.sh && cd .. && ./ATOM.sh
        ;;
    "5")
        picocom -b 115200 /dev/ttyUSB0 && ./ATOM.sh
        ;;
    "6")
        cd NGN && ./tbl.sh && cd .. && ./ATOM.sh
        ;;
    "7")
        cd NGN && ./upd.sh && cd .. && ./ATOM.sh
        ;;

    "8")
        exit
        ;;
    esac
fi
rm -f $TMPFCMD
echo "" >/tmp/ipdfi.tmp
echo "" >/tmp/licfile.tmp
echo "" >/tmp/atom.tmp