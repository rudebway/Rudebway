#!/bin/bash
TMPFCMD="/tmp/cmd.tmp"
dialog --title "Работа с АТОМом" \
--backtitle "АТОМ" \
--menu "Выберите необходимый тип работ" 15 40 9 \
1 "Прошивка БКП" \
2 "Прошивка моторизации" \
3 "Настройка DFI" \
4 "Подключение к БКП(БСИ)" \
5 "Выход" 2>$TMPFCMD
CMD2RUN=$(cat $TMPFCMD)
if [ $? -eq "0" ]; then
case $CMD2RUN in
"1")
cd uuu-korda && ./auto.sh && cd .. && ./ATOM.sh;;
"2")
cd flasher && ./flash.sh && cd .. && ./ATOM.sh;;
"3")
cd dfi && ./dfi.sh && cd .. && ./ATOM.sh;;
"4")
picocom -b 115200 /dev/ttyUSB0  && ./ATOM.sh;;
"5")
exit;;
esac
fi
rm -f $TMPFCMD
echo "">/tmp/ipdfi.tmp
