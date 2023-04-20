#!/bin/bash

BASEPATH="./"
ENTRADA="$BASEPATH/entradas"
SALIDA="$BASEPATH/salidas"
DIVISAS="$ENTRADA/divisas.txt"
CARGA="$SALIDA/carga.txt"

cargarDivisas() {
	hoy=$(date +%d/%m/%Y)
	cat ./entradas/divisas.txt | grep -i "^$hoy-(EUR|ARG|USD|UYU)-[0-9]{9}-[0-9]{9}-[A-Z]*" > divisasHoy.txt
	cat divisasHoy.txt
	rm divisasHoy.txt
	
	#echo "$hoy carga no exitosa"
}


cargarDivisas
