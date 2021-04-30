#!/bin/bash
#    Copyright (C) 2021 Artem Korotchenko <a.korotchenko@korda-group.ru>
        echo '--------------------------------------------------------------------------------'
        echo ' SIM CARD AVAILABILITY'
        echo '--------------------------------------------------------------------------------'

        sim_check() {
            local dev="$1"

            RES=NONE

            if [ -e $dev ]; then
                stty -F $dev 115200
                stty -F $dev raw
                stty -F $dev -echo -echoe -echok

                cat $dev >/tmp/modem &
                sleep 1
                CAT_PID=$!
                echo -ne "AT+UUICC?\r\n" >$dev
                TOUT_S=0
                while [ $TOUT_S -lt 5 ]; do
                    SIM=$(grep +UUICC: /tmp/modem | awk '{print $2}' | tr -d '\n')
                    if [ "$SIM" = 0 ] ||
                        [ "$SIM" = 1 ] ||
                        [ "$SIM" = 2 ]; then
                        RES=YES
                        break
                    fi
                    grep -q ERROR /tmp/modem
                    if [ $? -eq 0 ]; then
                        break
                    fi
                    TOUT_S=$(($TOUT_S + 1))
                    sleep 1
                done
                kill $CAT_PID &>/dev/null
                rm /tmp/modem
            fi

            echo -n $RES
        }

        RES_SIM_CLIENT=$(sim_check /dev/ttyACM8)
        RES_SIM_SVC=$(sim_check /dev/ttyACM1)

        echo "GSM LISA-U2 (client,  upper): $RES_SIM_CLIENT"
        echo "GSM LISA-U2 (service, lower): $RES_SIM_SVC"

        echo
        echo -n "Press any key if ready..."
        read