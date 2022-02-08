#!/bin/bash
i=0
INDIP=1
while [ $i -le 253 ]
do
ENDNAME=$((101+$i))
PASS=$(sudo < /dev/urandom tr -dc 'A-Z-a-z-0-9' | head -c${1:-12};echo;)
ENDIP=$((2+$i))
echo -e "add name=cortes$ENDNAME password=$PASS profile=Rub-PPTP4 remote-address=172.20.5.$ENDIP" >> outpt.file
((i++))
done
