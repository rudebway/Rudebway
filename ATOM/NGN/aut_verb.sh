#!/usr/bin/env bash
chk_mtr() {
    IPDFI=$(cat /tmp/ipdfi.tmp)
    local usb="$1"
    sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S FtDetect' 
    sshpass -p 'Fx566434' ssh admin@$IPDFI 'sudo systemctl stop cortes'
    sshpass -p 'Fx566434' ssh admin@$IPDFI "cortes-lctrl callib Focus 74000 30000 -p $usb" >/tmp/mtrf
    sshpass -p 'Fx566434' ssh admin@$IPDFI "cortes-lctrl callib Diaphragm 2400 5000 -p $usb" >/tmp/mtrd
    MTRF=$(wc -c /tmp/mtrf | awk '{print $1}')
    MTRD=$(wc -c /tmp/mtrd | awk '{print $1}')
    if [ "$MTRF" -gt "1000" ] && [ "$MTRD" -gt "1000" ]; then
        MTR="Калибровка моторизации прошла успешно"
    else
        MTR="Возникли проблемы при калибровке"
    fi
    rm -f /tmp/mtrf /tmp/mtrd
    echo $MTR
}
chk_gps() {
    IPDFI=$(cat /tmp/ipdfi.tmp)
    local usb="$1"
    timeout 5s sshpass -p 'Fx566434' ssh admin@$IPDFI "picocom -b 9600 $usb" >/tmp/gps
    GPST=$(wc -c /tmp/gps | awk '{print $1}') 2>/dev/null
    if [ "$GPST" -gt "590" ]; then
        GPS="GPS работает нормально"
    else
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S rm /dev/ublox' 
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S rm /dev/leans' 
        sshpass -p 'Fx566434' ssh admin@$IPDFI 'echo moLD02p | sudo -S FtDetect'
        timeout 5s sshpass -p 'Fx566434' ssh admin@$IPDFI "picocom -b 9600 $usb" >/tmp/gps
        GPST=$(wc -c /tmp/gps | awk '{print $1}') 
        if [ "$GPST" -gt "590" ]; then
            GPS="GPS работает нормально"
        else
            timeout 5s sshpass -p 'Fx566434' ssh admin@$IPDFI "picocom -b 9600 /dev/ttyUSB1" >/tmp/gps
            GPST=$(wc -c /tmp/gps | awk '{print $1}') 
            if [ "$GPST" -gt "590" ]; then
                GPS="GPS работает"
            else
                GPS="Нет данных с GPS"
            fi
        fi
    fi
    rm -f /tmp/gps
    echo $GPS
}

chk_rdr() {
    IPDFI=$(cat /tmp/ipdfi.tmp)
    timeout 5s sshpass -p 'Fx566434' ssh admin@$IPDFI 'picocom -b 115200 /dev/ttyS0' >/tmp/rdr
    RDRT=$(wc -c /tmp/rdr | awk '{print $1}')

    if [ "$RDRT" -gt "600" ]; then
        RDR="Радар работает нормально"
    else
        RDR="Нет данных с радара (проверьте провод)"
    fi
    rm -f /tmp/rdr
    echo $RDR
}

chk_lic() {
    LICT=$(cat /tmp/atom.tmp)
    mount -t cifs -o username=root,password=Fx566434 //10.78.9.10/PrOt /serv 
    if [ "$(ls /serv/licenses | grep $LICT)" = "" ]; then
        mkdir /serv/licenses/$LICT
        cd /serv/licenses/$LICT
        touch request.file
        sshpass -p 'Fx566434' ssh admin@$IPDFI "license_checker3" >request.file
        LIC="Файл запроса лицензии создан"
    else
        cd /serv/licenses
        if [ "$(ls /serv/licenses/$LICT | grep license)" != "" ]; then
            cd /serv/licenses/$LICT
            sshpass -p 'Fx566434' ssh admin@$IPDFI "cat > license" <license
            sshpass -p 'Fx566434' ssh admin@$IPDFI "cat > license_vehicles" <license_vehicles
            LIC="Лицензия на данный АТОМ установлена"
        else
            LIC="Файл запроса лицензии существует, запросите ключи"
        fi
    fi
    echo $LIC
}

IPDFI=$(cat /tmp/ipdfi.tmp)

LICFILE="/tmp/atom.tmp"
dialog --title "Серийный номер АТОМА" --inputbox "Введите серийный номер:" 8 40 2>$LICFILE
SDKVER="$(sshpass -p 'Fx566434' ssh admin@$IPDFI "cortes-builder list | grep roadarsdk" | awk '{print $3}' | cut -b 1-5)"
if [ "$(sshpass -p 'Fx566434' ssh admin@$IPDFI 'ls ~/cortes/cortes')" == "" ]; then
    sshpass -p 'Fx566434' ssh admin@$IPDFI "bash <(sed 's/sudo/echo moLD02p | sudo -S/g' <(wget -qO- http://10.78.1.67/install_atom.sh))" 
    sshpass -p 'Fx566434' ssh admin@$IPDFI "bash <(sed 's/sudo/echo moLD02p | sudo -S/g' <(wget -qO- http://10.78.1.67/update_roadar.sh))" 
    CRT="CORTES установлен"
    SDKVER="$(sshpass -p 'Fx566434' ssh admin@$IPDFI "cortes-builder list | grep roadarsdk" | awk '{print $3}' | cut -b 1-5)"
    SDK="Версия RoadAR SDK $SDKVER"
else
    CRT="CORTES уже был установлен"
    if [ "$(sshpass -p 'Fx566434' ssh admin@$IPDFI "cortes-builder list | grep roadarsdk" | awk '{print $3}' | cut -b 1-5)" == "1.0.6" ]; then
        SDK="Версия RoadAR SDK $SDKVER"
    else
        sshpass -p 'Fx566434' ssh admin@$IPDFI "bash <(sed 's/sudo/echo moLD02p | sudo -S/g' <(wget -qO- http://10.78.1.67/update_roadar.sh))" 
        SDK="Версия RoadAR SDK $SDKVER"
    fi
fi
TSTUSB=$(sshpass -p 'Fx566434' ssh admin@$IPDFI 'ls /dev/ | grep USB | tr -d "ttyUSB; \n"')
sleep 1
if [ "$TSTUSB" == "01" ]; then
    RESULT="Провода FTDI -> DFI в порядке"
    MTR=$(chk_mtr /dev/leans)
    GPS=$(chk_gps /dev/ublox)
elif [ "$TSTUSB" == "0" ] || [ "$TSTUSB" == "1" ]; then
    FTD=$(sshpass -p 'Fx566434' ssh admin@$IPDFI "echo moLD02p | sudo -S rm -f /dev/leans /dev/ublox && sudo FtDetect |grep USB" | awk '{print $3}') 
    sleep 1
    if [ "$FTD" == "0" ] || [ "$FTD" == "1" ]; then
        MRT=$(chk_mtr /dev/leans)
        RESULT="Нет соединения DFI -> БСИ"

    else
        sleep 1
        GPS=$(chk_gps /dev/$(sshpass -p 'Fx566434' ssh admin@$IPDFI 'ls /dev/ | grep ttyUSB'))
        MTR="Калибровка моторизации невозможна"
        RESULT="Нет соединения DFI -> моторизация"

    fi
else
    RESULT="Провод FTDI -> DFI не подключен/не работает"
fi
RDR=$(chk_rdr)
LIC=$(chk_lic)
sleep 2
#dialog --title "Отчёт по оборудованию" \
#    --msgbox 
echo -n "$RESULT\n$MTR\n$GPS\n$RDR\n$LIC\n$CRT\n$SDK" 
#12 418
