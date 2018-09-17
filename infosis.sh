#!/bin/bash
verde="\e[1;32m"
rojo='\e[1;31m'
cyan='\e[1;36m'
blanco='\e[1;37m'
clear
echo ' /$$            /$$$$$$                    /$$          '
echo '|__/           /$$__  $$                  |__/          '
echo ' /$$ /$$$$$$$ | $$  \__//$$$$$$   /$$$$$$$ /$$  /$$$$$$$'
echo '| $$| $$__  $$| $$$$   /$$__  $$ /$$_____/| $$ /$$_____/'
echo '| $$| $$  \ $$| $$_/  | $$  \ $$|  $$$$$$ | $$|  $$$$$$ '
echo '| $$| $$  | $$| $$    | $$  | $$ \____  $$| $$ \____  $$'
echo '| $$| $$  | $$| $$    |  $$$$$$/ /$$$$$$$/| $$ /$$$$$$$/'
echo '|__/|__/  |__/|__/     \______/ |_______/ |__/|_______/ '

maquina=$HOSTNAME
SO=$( cat /etc/*release | grep DISTRIB_ID | awk -F'=' '{print $2}' )
VERSION=$( cat /etc/*release | grep DISTRIB_RELEASE | awk -F'=' '{print $2}' )
KER=$( uname -mrs )
PROCE=$( cat /proc/cpuinfo | grep 'model name' | head -n 1 | sed -e 's/model name	://g' )
RAM=$( free -h | grep Mem | awk '{print $2}' )

echo -e "\n\n\n$verdeLa informacion de tu sistema es el siguiente: \n\nTu maquina se llama: $maquina\n\nTiene el SO: $SO con la version $VERSION\n\nKernel: $KER\n\nEl procesador: $PROCE\n\nY RAM: $RAM\n"
