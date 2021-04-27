#!/bin/bash
TMPLIC="/tmp/fcmd.tmp"
dialog --title "Работа с лицензиями" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите пункт работ" 15 40 9 \
    1 "Файл запроса" \
    2 "Ввести лицензию" \
    3 "Проверка наличия лицензии" \
    4 "Взаимодействие с сервером" \
    5 "Назад" 2>$TMPLIC
CMD2LIC=$(cat $TMPLIC)
if [ $? -eq "0" ]; then
    case $CMD2LIC in
    "1")
        sshpass -p 'Fx566434' ssh admin@$IPDFI "license_cheker3" | tee /tmp/lic.tmp
        read -s -n 1
        #LIC=$(cat /tmp/lic.tmp)
        #dialog --title "Файл запроса лицензии" \
        #--msgbox "\n $LIC" 15 50
        ;;
    "2") 
        #TMPLIC1="/tmp/license.tmp"
        #dialog --title "Ввод лицензии" --inputbox "Содержимое license" 8 40 2>$TMPLIC1
        #CATLIC1=$(cat $TMPLIC1)
        #TMPLIC2="/tmp/license_vehicles.tmp"
        #dialog --title "Ввод лицензии" --inputbox "Содержимое license_vehicles" 8 40 2>$TMPLIC2
        #CATLIC2=$(cat $TMPLIC2)
        clear
        echo "Ввод лицензии распознавания номера (license)"
        sshpass -p 'Fx566434' ssh admin@$IPDFI -T "nano license"
        clear
        echo "Ввод лицензии распознавания ТС (license_vehicles)"
        sshpass -p 'Fx566434' ssh admin@$IPDFI -T "nano license_vehicles"
        clear
        echo "Лицензии введены, перепроверьте"
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
            --msgbox "\n Лицензия распознавания номера: $LIC1 \n Лицензия распознавания: ТС $LIC2" 7 40

        ;;
    "4") 
        echo "Очень рано"
    
    ;;

    
    "5") ;;

    esac

fi
rm -f $TMPLIC
