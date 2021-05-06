#!/bin/bash
LICTMPFILE="/tmp/licfile.tmp"
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPLIC="/tmp/fcmd.tmp"
LICNAME=$(cat $LICTMPFILE)
dialog --title "Работа с лицензиями" \
--backtitle "АТОМ $IPDFI" \
--menu "Выберите пункт работ" 15 40 9 \
1 "Файл запроса" \
2 "Лицензия автозапрос" \
3 "Проверка наличия лицензии" \
4 "Взаимодействие с сервером" \
5 "Назад" 2>$TMPLIC
CMD2LIC=$(cat $TMPLIC)
if [ $? -eq "0" ]; then
    case $CMD2LIC in
    "1")
        sshpass -p 'Fx566434' ssh admin@$IPDFI "license_checker3" | tee /tmp/lic.tmp
        read -s -n 1
        #LIC=$(cat /tmp/lic.tmp)
        #dialog --title "Файл запроса лицензии" \
        #--msgbox "\n $LIC" 15 50
        ;;
    "2")
        dialog --title "Лицензия АТОМа" --inputbox "Введите серийный номер АТОМа:" 8 40 2>$LICTMPFILE
        LICNAME=$(cat $LICTMPFILE)
        mount -t cifs -o username=root,password=Fx566434 //10.78.9.10/PrOt /serv
        if [ $(ls /serv/licenses | grep $LICNAME) = "" ]; then
            mkdir /serv/licenses/$LICNAME
            cd /serv/licenses/$LICNAME
            touch request.file
            sshpass -p 'Fx566434' ssh admin@$IPDFI "license_checker3">request.file
        ;;
    "3")
        if [ $(sshpass -p 'Fx566434' ssh admin@$IPDFI "wc -c license | awk '{print $1}'") -eq "353" ]; then
            LIC1=$(echo Установлена)
        else
            LIC1=$(echo Пуста)
        fi
        if [ $(sshpass -p 'Fx566434' ssh admin@$IPDFI "wc -c license_vehicles | awk '{print $1}'") -eq "353" ]; then
            LIC2=$(echo Установлена)
        else
            LIC2=$(echo Пуста)
        fi
        dialog --title "Проверка лицензии" \
        --msgbox "\n Лицензия распознавания номера: $LIC1 \n Лицензия распознавания ТС: $LIC2" 7 50

        ;;
    "4")
        echo "Очень рано"

        ;;

    \
        "5") ;;

    esac

fi
rm -f $TMPLIC
rm -f $LICTMPFILE