#!/bin/bash
LICTMPFILE="/tmp/licfile.tmp"
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPLIC="/tmp/fcmd.tmp"
LICNAME=$(cat $LICTMPFILE)
dialog --title "Работа с лицензиями" \
--backtitle "АТОМ $IPDFI" \
--menu "Выберите пункт работ" 15 40 9 \
1 "Лицензия автозапрос" \
2 "Отправка лицензии на АТОМ" \
3 "временно пусто" \
4 "Взаимодействие с сервером" \
5 "Назад" 2>$TMPLIC
CMD2LIC=$(cat $TMPLIC)
if [ $? -eq "0" ]; then
    case $CMD2LIC in
    "1")
        dialog --title "Лицензия АТОМа" --inputbox "Введите серийный номер АТОМа:" 8 40 2>$LICTMPFILE
        LICNAME=$(cat $LICTMPFILE)
        mount -t cifs -o username=root,password=Fx566434 //10.78.9.10/PrOt /serv 2>/dev/null
        if [ "$(ls /serv/licenses | grep $LICNAME)" = "" ] ; then
            mkdir /serv/licenses/$LICNAME
            cd /serv/licenses/$LICNAME
            touch request.file
            dialog --title "Лицензия АТОМа $LICNAME" \
           --msgbox "     Подождите пару минут, пока \n  создается файл запроса лицензии " 7 40
            sshpass -p 'Fx566434' ssh admin@$IPDFI "license_checker3">request.file
            dialog --title "Лицензия АТОМа $LICNAME" \
           --msgbox "   Файл запроса лицензии создан и \n       доступен по адресу        \n   10.78.9.10/licenses/$LICNAME" 7 40
        else 
             dialog --title "Лицензия АТОМа $LICNAME" \
            --msgbox "   Файл запроса уже существует и \n       доступен по адресу \n   10.78.9.10/licenses/$LICNAME" 7 40
        fi

        ;;
    "2")
        mount -t cifs -o username=root,password=Fx566434 //10.78.9.10/PrOt /serv 2>/dev/null
        cd /serv/licenses
        if [ "$(ls /serv/licenses/$LICNAME | grep license)" = "" ]; then
            dialog --title "Лицензия АТОМа $LICNAME" \
            --msgbox "  Файлы ответов отсутствуют!!!" 7 40
        else
            sshpass -p 'Fx566434' ssh admin@$IPDFI "cat license"<license
            sshpass -p 'Fx566434' ssh admin@$IPDFI "cat license_vehicles"<license_vehicles
        fi
        read -s -n 1
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
