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

#FUNCIONES Y PROCEDIMIENTOS


REINICIAR_DHCP() {

echo "Reiniciando Servidor DHCP:";
/etc/init.d/isc-dhcp-server restar;;

if  [[ $? != 0 ]]; #Comprueba si el servicio va bien
then 
		echo "El servicio fallo algo quedo mal"

	else
		echo "El servicio va correctamente"

	fi
}
############################################################
REINICIAR_PROXY() {

/etc/init.d/isc-dhcp-server restar;;
squidGuard -C all ; squid3 -k reconfigure;;

if  [[ $? != 0 ]];
then 
		echo "El servicio fallo algo quedo mal"

	else
		echo "El servicio va correctamente"

	fi
	
}
############################################################

REINICIAR_firewall() {

echo "reiniciar el Servicio Firewall:";
/etc/init.d/isc-dhcp-server restar;;
shorewall restart;;

if  [[ $? != 0 ]];
then 
		echo "El servicio fallo algo quedo mal"

	else
		echo "El servicio va correctamente"

	
	fi
}
############################################################

clear
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
