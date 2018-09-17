#!/bin/bash
ROJO='\033[01;31m'   #Definen los colores
CYAN='\033[01;36m'

echo -n -e "${CYAN}Hoy es: ${ROJO}"
date | awk '{print $(NF-3),$(NF-4),$(NF)}'