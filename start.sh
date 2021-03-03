#!/bin/bash

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
printf '3) Выход \n'
read KEY

case $KEY in
  1)bash ./script_import
    sleep 5
    clear
    echo "Установка Виртуальных машин"
    printf "\n"
    echo `printf "${GREEN}Done${NC}"`
    printf "\n"
    sleep 3 ;;
  2)bash ./script_AU_PCI
    sleep 5
    clear
    echo "Настройка Виртуальных машин"
    printf "\n"
    echo `printf "${GREEN}Done${NC}"`
    printf "\n"
    sleep 3 ;;
  3) clear
    echo "Выход"
    sleep 3;;
esac
