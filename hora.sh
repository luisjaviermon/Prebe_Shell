#!/bin/bash
ROJO='\033[01;31m'
VERDE='\033[01;32m'   #Definen los colores
BLANCO='\033[37m'


echo -n -e "${VERDE}Son ${BLANCO}las:${ROJO} "
date | awk '{print $(NF-2)}'