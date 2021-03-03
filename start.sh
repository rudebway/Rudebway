#!/bin/bash
while true
do
clear
RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m'
chmod +x script_import
chmod +x script_AU_PCI
printf 'Выберите действие \n \n'
printf '1) Установка Виртульных машин \n'
printf '2) Настройка Виртуальных машин \n'
printf '\n'
printf '3) Выход \n \n'

read KEY

case $KEY in
  1)bash ./script_import
    sleep 2
    clear
    echo "Установка Виртуальных машин"
    printf "\n"
    echo `printf "${GREEN}Done${NC}"`
    printf "\n"
    sleep 2 ;;
  2)bash ./script_AU_PCI
    sleep 2
    clear
    echo "Настройка Виртуальных машин"
    printf "\n"
    echo `printf "${GREEN}Done${NC}"`
    printf "\n"
    sleep 2 ;;
  3) clear
    echo "Выход"
    sleep 2
    break;;
esac
done
