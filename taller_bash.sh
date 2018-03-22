#!/bin/bash
#Creado por Johan Sebastian Hernandez
#Fecha 21-03-2018
#

#Saca el numero total de procesos
numProcesos=$(ps ax | tail -n +2 | wc -l)
echo $numProcesos
 
#Calcula el porcentaje de memoria libre
freeMemory=$(vmstat --unit K | tail -n 1 | awk '{print $4}')
freeMemory=$(($freeMemory * 100))
allMemory=$(free | grep Mem | awk '{print $2}')
porcMemoria=$(($freeMemory / $allMemory))
echo $porcMemoria


#Saca el porcentaje de disco duro libre
porcDisco=$(df | grep root | awk '{print $5}' | cut -c 1-2)
porcDisco=$(($porcDisco + 100 - ($porcDisco * 2)))
echo $porcDisco

#Actualiza la informacion en Thingspeak
curl --silent --request POST --header "X-THINGSPEAKAPIKEY:CYYQWK3K6LTRV9UN" --data "field1=${numProcesos}&field2=${porcMemoria}&field3=${porcDisco}" http://api.thingspeak.com/update
