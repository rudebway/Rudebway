#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPDFI="/tmp/cmddfi.tmp"
dialog --title "Работа с DFI" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите необходимый тип работ" 15 40 9 \
    1 "Соединение с DFI" \
    2 "Установка CORTES" \
    3 "Лицензия" \
    4 "Настройки и тесты" \
    5 "Назад" 2>$TMPDFI
CMD2DFI=$(cat $TMPDFI)
if [ $? -eq "0" ]; then
    case $CMD2DFI in
    "1")
        IPDFITMP="/tmp/ipdfi.tmp"
        dialog --title "Соединение с DFI" --inputbox "Введите IP-адрес DFI:" 8 40 2>$IPDFITMP
        IPDFI=$(cat $IPDFITMP)
        ssh-keygen -f "/root/.ssh/known_hosts" -R $IPDFI
        ssh-keyscan -H $IPDFI >>/root/.ssh/known_hosts
        ./dfi.sh
        ;;
    "2")
        IPDFI=$(cat /tmp/ipdfi.tmp)
        sshpass -p 'Fx566434' ssh admin@$IPDFI "bash <(sed 's/sudo/echo moLD02p | sudo -S/g' <(wget -qO- http://10.78.1.67/install_atom.sh))"
        sshpass -p 'Fx566434' ssh admin@$IPDFI "bash <(sed 's/sudo/echo moLD02p | sudo -S/g' <(wget -qO- http://10.78.1.67/update_roadar.sh))"
        read -s -n 1
        ;;
    "3")
        ./lic.sh && ./dfi.sh
        ;;
    "4")
        ./clb.sh && ./dfi.sh
        ;;
    "5") ;;

    esac
fi
rm -f $TMPDFI