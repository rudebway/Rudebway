#!/bin/bash
IPDFI=$(cat /tmp/ipdfi.tmp)
TMPTBL="/tmp/cmdtbl.tmp"
dialog --title "Типовые решения проблем" \
    --backtitle "АТОМ $IPDFI" \
    --menu "Выберите возникшую проблему" 15 40 9 \
    1 "Нет камер в веб-интерфейсе" \
    2 "Ошибка GPS (host/port)" \
    3 "Проблемы с моторизацией/GPS" \
    4 "Назад" 2>$TMPTBL
CMD2TBL=$(cat $TMPTBL)
if [ $? -eq "0" ]; then
    case $CMD2TBL in
    "1")
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'rm -rf ~/cortes/security_keys/*'
        ./tbl.sh
        ;;
    "")
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S systemctl restart gpsd'
        ./tbl.sh
        ;;
    "3")
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S rm /dev/ublox'
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S rm /dev/leans'
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S FtDetect'
        ;;
    "4") ;;

    esac
fi
rm -f $TMPTBL
