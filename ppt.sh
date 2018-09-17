#!/usr/bin/env bash


ScoreJUG=0 # Puntuacion total del jugador
ScorePC=0 # Puntuacion total del PC 

rondas=-1 # Numero de rondas

turnoJUG=-1 # Eleccion del Jugador 
turnoPC=-1 # Eleccion de la Pc

RONDA=1 # Ronda actiual

Escogido_JUG=-1 
Escogido_PC=-1 # Aca se almacenara si elijio piedra, papel o tijera

re='^[0-9]+$'

clear
echo -e "${BLANCO}Piedra, Papel o Tijeras!\n"

while : 
do #ciclo infinito
  echo -e "${BLANCO}Cuantas rondas quieres jugar?" 
  read -r rondas  #numero de rondas a jugar

  if ! [[ $rondas =~ $re ]] ; then 
     echo -e "${ROJO}Numero invalido!" 
     echo -e "Intente de nuevo\n"
  elif [ $rondas == 0 ]; then #obligando al usuario que elija al menos una ronda
    echo -e "${ROJO}Tienes que elegir almenos una ronda"
  else
    echo -e "${CYAN}Duelo a muerte a $rondas rondas!\n"
    break
  fi
done

re='^[rps]+$'
while [ $rondas -gt 0 ]; do #si rondas es diferente de 0
  clear
  echo -e "${CYAN}Ronda: $RONDA"
  turnoPC=$(shuf -i 1-3 -n 1)   #se escoge un numero al azar del 1-3 para la PC
  [ "$turnoPC" == "1" ] && turnoPC="r"
  [ "$turnoPC" == "2" ] && turnoPC="p"    #dependiendo del numero se le asigna una letra que simboliza una piedra, papel o tijera
  [ "$turnoPC" == "3" ] && turnoPC="s"
  echo -n "Piedra (r), Papel (p) o Tijeras (s): "
  read -r turnoJUG #guarda la opcion del jugador
  if ! [[ "$turnoJUG" =~ $re ]] || [ "${#turnoJUG}" != "1" ]; then #si no es una opcion permitida
     echo -e "${ROJO}Eso no esta permitido!"
     echo -e "Intente de nuevo en un momento\n"
  else

    [ "$turnoJUG" == "r" ] && Escogido_JUG="Piedra"
    [ "$turnoJUG" == "p" ] && Escogido_JUG="Papel"
    [ "$turnoJUG" == "s" ] && Escogido_JUG="Tijeras"
    													#Dependiendo de la letra se le asigna el valor Piedra, Papel o Tijera
    [ "$turnoPC" == "r" ] && Escogido_PC="Piedra"
    [ "$turnoPC" == "p" ] && Escogido_PC="Papel"
    [ "$turnoPC" == "s" ] && Escogido_PC="Tijeras"

    clear
    echo -e "${CYAN}Escogiste: $Escogido_JUG !"
    echo "La PC escogio: $Escogido_PC !"
    echo -e "\n"										#Imprime las opciones elegidas del jugador y de la PC

    PC_won=0  
    JUG_won=0  #contadores de las rondas ganadas del PC y el Jugador

    if [ "$turnoJUG" == "r" ]; then
      [ "$turnoPC" == "p" ] && PC_won=1
      [ "$turnoPC" == "s" ] && JUG_won=1
    fi
    if [ "$turnoJUG" == "p" ]; then
      [ "$turnoPC" == "r" ] && PC_won=1     # Define que opcion le gana a cual
      [ "$turnoPC" == "s" ] && JUG_won=1
    fi
    if [ "$turnoJUG" == "s" ]; then
      [ "$turnoPC" == "r" ] && PC_won=1
      [ "$turnoPC" == "p" ] && JUG_won=1
    fi
    if [ "$PC_won" == "0" ] && [ "$JUG_won" == "0" ]; then #si ninguno gano empatan
      echo -e "${AMARILLO}Empataron :s"
    elif [ "$JUG_won" == 1 ]; then
      echo -e "${VERDE}Ganaste :)"
      ((ScoreJUG++))
    elif [ "$PC_won" == 1 ]; then
      echo -e "${ROJO}Gano la PC :("
      ((ScorePC++))
    fi

    echo -e "\n${BLANCO}Cargando la siguiente ronda...\n"
    ((rondas--))   #reduce la ronda para saber cuantas van 
    ((RONDA++))    #Aumenta para imprimir la ronda que se juega
  fi
  sleep 4
done

sleep 1
clear
echo -e "${BLANCO}Eso fue todo amigo!\n"
echo "Tu puntaje: $ScoreJUG"
echo "Puntaje de la PC: $ScorePC"    #imprime los resultados finales 
echo -e "\n"

if [ $ScorePC -gt $ScoreJUG ]; then
  echo -e "${ROJO}Perdiste :s"
elif [ $ScoreJUG -gt $ScorePC ]; then
  echo -e "${VERDE}Ganaste <3"
elif [ $ScorePC -eq $ScoreJUG ]; then
  echo -e "${AMARILLO}Un simple empate..."
fi

sleep 5
clear
echo -e "${VERDE}Gracias por Jugar"

exit
