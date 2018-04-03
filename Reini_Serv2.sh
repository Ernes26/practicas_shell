#!/bin/bash
##############################
#Elaborado por: Ernesto Curvelo.
#Titulo: Automatizar Reinicio de Servicios
#Version: 2.0
##############################
##############################
#Objetivo:
#Reiniciar los Servicios de Forma mas rapida.
##############################


#DECLARACION DE VARIABLES

NORMAL=$(tput sgr0)
VERDE=$(tput setaf 2; tput bold)
AMARILLO=$(tput setaf 3)
ROJO=$(tput setaf 1)
AZUL=$(tput setaf 4)
BLACK=$(tput setaf 0)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
DHCP="/etc/init.d/isc-dhcp-server restart"
SQUID={squidGuard -C all ; squid3 -k reconfigure}
SHOR="shorewall restart"
#FUNCIONES Y PROCEDIMIENTOS
function rojo() {
    echo -e "$ROJO$*$NORMAL"
}

function verde() {
    echo -e "$VERDE$*$NORMAL"
}

function amarillo() {
    echo -e "$AMARILLO$*$NORMAL"
}


REINICIAR_DHCP() {

 amarillo "Reiniciando Servidor DHCP:"
#/etc/init.d/isc-dhcp-server restar
$DHCP
if  [[ $? != 0 ]]; #Comprueba si el servicio va bien
then 
		rojo "El servicio fallo algo quedo mal"

	else
		verde "El servicio va correctamente"

	fi
}
############################################################
REINICIAR_PROXY() {

 amarillo "Reiniciando Servidor DHCP:"
 amarillo "Reiniciando squid3"
$DHCP
$SQUID
if  [[ $? != 0 ]];
then 
		rojo "El servicio fallo algo quedo mal"

	else
		verde "El servicio va correctamente"

	fi
	
}
############################################################

REINICIAR_firewall() {

 amarillo "REINICIAR SHOREWALL"
$DHCP
$SHOR

if  [[ $? != 0 ]];
then 
		rojo "El servicio fallo algo quedo mal"

	else
		verde "El servicio va correctamente"

	
	fi
}
############################################################

clear
echo "***********ESCOJA UNA DE LAS SIGUIENTES OPCIONES*********"
echo
while :
do
echo " Escoja una opcion "
echo "1. Reiniciar solo servicio DHCP"
echo "2. Reiniciar el servidor Proxy"
echo "3. Reiniciar el Firewall"
echo "4. Salir"
echo -n "Seleccione una opcion [1 - 4]"

read opcion

case $opcion in
1) echo "Reiniciando Servidor DHCP:";
 REINICIAR_DHCP;;        

2) echo "Reiniciando proxy:";
 REINICIAR_PROXY;;

3) echo "Reiniciando firewall:";
 REINICIAR_firewall;;

4) echo "salir:";
  exit 1;;
*) echo "$opc no es una opcion válida.";
read foo;;
esac
done
