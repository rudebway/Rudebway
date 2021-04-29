#!/bin/bash
while true; do
  clear
  GREEN='\033[1;32m'
  NC='\033[0m'
  chmod +x script_import
  chmod +x script_AU_PCI
  printf 'Select an action \n \n'
  printf '1) Import VM \n'
  printf '2) Customization VM \n'
  printf '\n'
  printf '3) Exit \n \n'

  read KEY

  case $KEY in
  1)
    bash ./script_import
    sleep 1
    clear
    echo "Import VM"
    printf "\n"
    echo $(printf "${GREEN}Done${NC}")
    printf "\n"
    sleep 1
    ;;
  2)
    bash ./script_AU_PCI
    sleep 1
    clear
    echo "Customization VM"
    printf "\n"
    echo $(printf "${GREEN}Done${NC}")
    printf "\n"
    sleep 1
    ;;
  3)
    clear
    echo "Exit"
    sleep 1
    break
    ;;
  esac
done
