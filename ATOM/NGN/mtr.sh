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
        cd ~/flasher/
        ./flashBootloader.sh
        cd ~/NGN/
        ./mtr.sh
        read -s -n 1
        ;;
    "2")
        cd ~/flasher/
        ./flashFW.sh
        cd ~/NGN/
        ./mtr.sh
        read -s -n 1
        ;;
    "3")
        cd ~/flasher/
        ./testBoard.sh
        cd ~/NGN/
        ./mtr.sh
        read -s -n 1
        ;;
    "4") ;;

    esac
fi
rm -f $TMPMTR
