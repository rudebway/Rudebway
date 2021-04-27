#!/bin/bash
TMPMTR="/tmp/fcmd.tmp"
dialog --title "Работа с моторизацией" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите необходимый тип работ" 15 40 9 \
    1 "Заливка Bootloader" \
    2 "Заливка прошивки" \
    3 "Проверка моторизации" \
    4 "Назад" 2>$TMPMTR
CMD2MTR=$(cat $TMPMTR)
if [ $? -eq "0" ]; then
    case $CMD2MTR in
    "1")
        ~/flasher/flashBootloader.sh && ~/NGN/mtr.sh
        ;;
    "2")
        ~/flasher/flashFW.sh && ~/NGN/mtr.sh
        ;;
    "3")
        ~/flasher/testBoard.sh && ~/NGN/mtr.sh
        ;;
    "4") ;;

    esac
fi
rm -f $TMPMTR
