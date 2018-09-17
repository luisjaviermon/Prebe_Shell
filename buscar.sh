#!/bin/bash
ROJO='\033[01;31m'   #Definen los colores
CYAN='\033[01;36m'
BLANCO='\033[37m'

if [ "$2" = "" ]; then
	if [ $( ls $( pwd ) | grep -c "$( echo $1 )") -ne 0 ]; then
		echo -e "\nArchivo ${CYAN}$( ls $( pwd ) | grep -i "$(echo $1)" ) ${BLANCO}ubicado en ${ROJO}$( pwd )${BLANCO}\n"
	else
		echo 'Archivo o directorio no encontrado :c'
	fi

else
	if [ $( ls $( echo "$2" ) | grep -c "$( echo $1 )" ) -ne 0 ]; then
		echo -e "\nArchivo ${CYAN}$( ls $( echo "$2" ) | grep -i "$( echo $1 )" )${BLANCO} ubicado en ${ROJO}$2${BLANCO}\n"
	else
		echo 'Archivo o directorio no encontrado :c'
	fi
fi