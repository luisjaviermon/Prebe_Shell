#!/bin/bash

#Programa reproductor de musica

function buscar {
	echo "**********/LISTA DE CANCIONES\*************" > $1/canciones.txt
	echo "**********/LISTA DE CANCIONES\*************" > $1/cancionesu.txt
	echo dentro de funcion
	echo $1
	cd $1
	cont=0
	for dir in *
	do
		if [ -d "$dir" ]; then
			cd $1/$dir
			for ar in *
			do
				if [ "$( echo $ar | awk -F'.' '{print $2}' )" = "mp3" ]; then
					cont=`expr $cont + 1`
					echo -e "$cont):$ar:$PWD\n" >> $1/canciones.txt
					echo -e "$cont) $ar \n" >> $1/cancionesu.txt
				fi
		done
			cd ..
		fi
	done
}

function rep {
	clear
	mpg123 -Cv $1/"$2"
}

RUTA=$1
menu=0
while [ $menu != 4 ]; do
dpkg -s mpg123
CONT=$( echo $? | awk -F':' '{print $1}' )
clear
if [ $CONT != 0 ]; then
 
	echo -e "No tienes instalado mpg123 y no puedo trabajar sin el\n"
	read -p "Deseas instalarlo [s/n] " ELEC
	case $ELEC in
	 	's')
			sudo apt-get install mpg123
	 		;;
	 	'n')
			clear
			echo 'Si cambias de opinion vuelve cuando quieras'
			exit
			;;
	 esac 
	
else
	menu=$(zenity --title="..:: Reproductor musical ::.." --text "Que desea hacer?\n\n 1.- Instrucciones\n 2.- Reproducir una cancion\n 3.- Reproducir carpeta de canciones\n 4.- Salir\n" --entry);
	  
	case $menu in
		1) clear ; ruta=$(zenity --title="..:: Reproductor musical ::.." --text "(d)____________________________________Cancion anterior\n(f)______________________________________Cancion siguiente\n(Barra espaciadora)_____Pausa\n(q)_____________________________________Salir\n(+)____________________________________Subir volumen\n(-)_______________________________________Bajar volumen\n\nPresiona Enter para continuar" --entry);;
		2)	buscar $1
			clear
			cat $1/cancionesu.txt
			ruta=$(zenity --title="..:: Reproductor musical ::.." --text "Seleccione el numero de su cancion" --entry)
			nombre=$( cat $1/canciones.txt | grep "$ruta)" | awk -F':' '{print $2}' )
			ruta=$( cat $1/canciones.txt | grep "$ruta)" | awk -F':' '{print $3}' )
			rep $ruta "$nombre"
			;;
		3) clear ; ruta=$(zenity --title="..:: Reproductor musical ::.." --text "***Dame la ruta de la carpeta***\nEj. /home/usuario/carpeta.../carpetademusica" --entry);
	       cd $ruta
	       ruta=$(zenity --title="..:: Reproductor musical ::.." --text "***¿Que desea?\n\n1)Reproducir de manera continua\n\n2)Reproducir de manera aleatoria" --entry)
		   case $ruta in
		   		1) mpg123 -vC *.mp3 ;;
		   		2) mpg123 -vzC *.mp3 ;;
		   		*) clear ; zenity --info --title="..:: Reproductor musical ::.." --text "No valida tu opcion man" ;;
		   esac
		   ;;
			
		4) clear ; exit ;;
		*) clear ; zenity --info --title="..:: Reproductor musical ::.." --text "No valida tu opcion man" ;;
	esac  
fi
done