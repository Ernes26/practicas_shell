#!/bin/bash
########################################################
#######   Creado por LIC ERNESTO CURVELO      ################
########################################################
##########      Backup servidores  ########
########################################################
# Debe existir un archivo servidores.txt con las ip usuarios y puertos de los servidores a respaldar
# 

#Fecha
fecha=$(date +"%d-%m-%Y")


#archivo con lista de servidores "ip", "usuario" y "PuertoSSH"
fileservidores="root/Escritorio/servidores.txt"

#####################
#formato del archivo
#ip
#usuario
#####################

######################
#####################
#Inicio Bucle de copia remota
#####################
######################
#lectura por lineas del archivo de servidores.txt
#USAREMOS UN BUCLE FOR

direccion=/root/Escritorio/pruebacasa.txt
for LINEA in $(cat $direccion)
do

    ip=`echo $LINEA | cut -d ":" -f1` #Extrae IP
    usuario=`echo $LINEA | cut -d ":" -f2` #Extrae nombre usuario
    servidor=`echo $LINEA | cut -d ":" -f3` #Extrae nombre servidor
   

    ####### SE CREA EL DIRECTORIO EN LA RUTA PARA EL RESPALDO Y SE GUARDA EN UNA VARIABLE ########

        mkdir -p /root/home/$servidor/$fecha 	
	respaldos=/root/home/$servidor/$fecha
   #################################################################################################
  
 
   rsync --progress -avze ssh $usuario@$ip:/etc/network/ $respaldos/interfaces
done



