#!/bin/bash

function tree {
for dir in `echo *` # `echo *` enumera todos los archivos en el directorio actual
do
    if [ -d "$dir" ] ; then     # Si se trata de un directorio (-d)
        n_arbol=0                    # Variable temporal para registrar el nive del directorio.
        while [ $n_arbol != $1 ]; do     # Bucle para mostrar las barras verticales interiores
            echo -ne "${CYAN}| "        # Muestra el simbolo del enlace vertical
            n_arbol=`expr $n_arbol + 1` #Aumenta el contador n_arbol
        done
        echo -e "${CYAN}├──${VERDE}$dir"             # Muestra el simbolo del enlace
        numdir=`expr $numdir + 1`   # Incrementa el contador del directorio
        if cd "$dir" ; then         # Si se ha podido acceder al directorio...
            tree `expr $1 + 1`   # llamada recursiva
            cd ..                   # volvemos al directorio anterior
        fi
    fi
done

}

if [ $# != 0 ] ; then #si el numero de argumentos recibidos es diferente de cero 
    cd $1 #entramos al argumento 
fi
CYAN='\033[01;36m'
VERDE='\033[01;32m'
echo "Directorio inicial = `pwd`"
numdir=0 #contendra el numero de directorios
tree 0 #inicia desde la raiz pedida, osease nivel 0
echo "Total directorios = $numdir"

