############Creado por LIC ERNESTO CURVELO      ################
########################################################
##########      Backup servidores  ########
########################################################
# Debe existir un archivo servidores.txt con las ip usuarios y puertos de los servidores a respaldar
# 

#Fecha
fecha=$(date +"%d-%m-%Y")

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
excluidos=/home/dell1/excluidos.txt #Archivo con los directorios a excluir
direccion=/home/dell1/servidores.txt #Direcciones ip y nombres de servidores
for LINEA in $(cat $direccion)
do

	    ip=`echo $LINEA | cut -d ":" -f1` #Extrae IP
	        usuario=`echo $LINEA | cut -d ":" -f2` #Extrae nombre usuario
		    servidor=`echo $LINEA | cut -d ":" -f3` #Extrae nombre servidor


 ####### SE CREA EL DIRECTORIO EN LA RUTA PARA EL RESPALDO Y SE GUARDA EN UNA VARIABLE ########

			        mkdir -p /home/respaldos/$servidor/$fecha
				         respaldos=/home/respaldos/$servidor/$fecha


#################################################################################################
					    #RESPALDO DE INTERFACES 
 rsync --progress -avrcze ssh $usuario@$ip:/etc/network/ $respaldos/interfaces
################################################################################################
 #RESPALDO DEL ETC
 rsync --progress -avrcze ssh $usuario@$ip:/etc $respaldos/etc
rsync --progress --exclude-from=$excluidos -avrcze ssh $usuario@$ip:/etc $respaldos/etc

#################################################################################################
 ##RESPALDO DE LOS LOGS

 rsync --progress --exclude-from=$excluidos -avrcze ssh $usuario@$ip:/var $respaldos/var
################################################################################################
RESPALDO DE CORREOS Y HOME DEL HERCULES

##############################################################################################
if [ $ip == "172.31.37.199" ]; then


 rsync --progress --exclude-from=$excluidos -avrcze ssh $usuario@$ip:/wwwroot $respaldos/wwwroot


fi


  done

