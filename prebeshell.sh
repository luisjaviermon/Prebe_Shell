#!/bin/bash
function login {
	read -p 'Usuario: ' USUARIO
	stty -echo
	read -p 'Contraseña: ' M_PASSWORD
	clear
	if [ $( grep -c $USUARIO /etc/shadow ) -ne 0 ]; then
		COMO='$'
		S_PASSWORD=$( grep $USUARIO /etc/shadow | awk -F':' '{print $2}' )
		AE=$( grep $USUARIO /etc/shadow | awk -F'$' '{print $2}' )
		SALT_PASSWORD=$( grep $USUARIO /etc/shadow | awk -F'$' '{print $3}' )
		CONTRASENA=$( perl -e 'print crypt("$ ARGV[0]","\$$ ARGV[1]\$$ ARGV[2]\$")' $M_PASSWORD $AE $SALT_PASSWORD )
		if [ "$CONTRASENA" = "$S_PASSWORD" ]; then
			echo '|   _  \  |   _  \     |   ____||   _  \  |   ____|    /       ||  |  |  | |   ____||  |     |  |     '
			echo '|  |_)  | |  |_)  |    |  |__   |  |_)  | |  |__      |   (----`|  |__|  | |  |__   |  |     |  |     '
			echo '|   ___/  |      /     |   __|  |   _  <  |   __|      \   \    |   __   | |   __|  |  |     |  |     '
			echo '|  |      |  |\  \----.|  |____ |  |_)  | |  |____ .----)   |   |  |  |  | |  |____ |  `----.|  `----.'
			echo '| _|      | _| `._____||_______||______/  |_______||_______/    |__|  |__| |_______||_______||_______|'
			ret=0
		else
			echo -e "\nContraseña incorrecta, favor de intentar de nuevo\n"
			ret=1
		fi
	else
		echo -e "\nEsto no funciona, intentalo de nuevo"
	fi
	stty echo
}

if [ $UID = 0 ]; then
	trap 'clear;echo "Solo se puede salir usando el comando salir, presiona ENTER para continuar"' SIGINT
	trap 'clear;echo "Solo se puede salir usando el comando salir, presiona ENTER para continuar"' SIGTSTP
	clear
	ret=1
	SALIDA=0
	while [ $ret = 1 ]; do
		echo -e "\n****Bienvenido a Prebeshell****\n"
		login
	done
	if [ ! -f /usr/bin/creditos ]; then
		cp creditos.sh /usr/bin/creditos
	fi
	if [ ! -f /usr/bin/prebeplayer ]; then
		cp prebeplayer.sh /usr/bin/prebeplayer
	fi
	if [ ! -f /usr/bin/arbol ]; then
		cp arbol.sh /usr/bin/arbol
	fi
	if [ ! -f /usr/bin/buscar ]; then
		cp buscar.sh /usr/bin/buscar
	fi
	if [ ! -f /usr/bin/ahorcado ]; then
		cp ahorcado.sh /usr/bin/ahorcado
	fi
	if [ ! -f /usr/bin/fecha ]; then
		cp fecha.sh /usr/bin/fecha
	fi
	if [ ! -f /usr/bin/hora ]; then
		cp hora.sh /usr/bin/hora
	fi
	if [ ! -f /usr/bin/infosis ]; then
		cp infosis.sh /usr/bin/infosis
	fi
	if [ ! -f /usr/bin/ppt ]; then
		cp ppt.sh /usr/bin/ppt
	fi
	if [ ! -f /usr/share/man/es/man1/ayuda.1 ]; then
		cp ayuda.1 /usr/share/man/es/man1/
	fi
	RUTA=$( grep $USUARIO /etc/passwd | awk -F':' '{print $6}' )
	cd $RUTA

	while [ $SALIDA = 0 ]; do
		ROJO='\033[01;31m'
		VERDE='\033[01;32m'   #Definen los colores
		CYAN='\033[01;36m'
		BLANCO='\033[37m'
		echo -e "\n\n${CYAN}┌┼─┼─${VERDE}[ $USUARIO ] | ( $PWD ) ${CYAN}"
		read -p "└┼─>" COMANDO

		if [ "$COMANDO" = "salir" ]; then
			SALIDA=1

			rm -f /usr/bin/creditos
			rm -f /usr/bin/prebeplayer
			rm -f /usr/bin/arbol
			rm -f /usr/bin/buscar
			rm -f /usr/bin/ahorcado
			rm -f /usr/bin/fecha
			rm -f /usr/bin/hora
			rm -f /usr/bin/infosis
			rm -f /usr/bin/ppt
			rm -f /usr/share/man/es/man1/ayuda.1

		else
			if [ "$COMANDO" = "prebeplayer" ]; then
				prebeplayer $RUTA
			else
				if [ "$COMANDO" = "ayuda" ]; then
					man ayuda
				else
					$COMANDO
				fi	
			fi
		fi
	done
else
	clear
	echo -e "No es usuario root\nFavor de ejecutar el comando de esta manera: sudo ./prebeshell.sh "
fi
