#!/bin/bash
BASEPATH="."
ENTRADA="$BASEPATH/entradas"
SALIDA="$BASEPATH/salidas"
DIVISAS="$ENTRADA/divisas.txt"
CARGA="$SALIDA/carga.txt"
COMPRA="$SALIDAS/'Compra de divisas.txt'"

COTIZACION=(0 0 0 0 0 0 0 0) #Orden del array: venta compra para las monedas Euro, Dolar, Arg, Real

cargarDivisas() {
	hoy=$(date +%d/%m/%Y)
	if  [ -s $DIVISAS ]; then
		egrep -i "^$hoy-(EUR|ARG|USD|BRL)-[0-9]{9}-[0-9]{9}-[A-Z]*" $DIVISAS > divisasHoy.txt

		lineasEuro=$(egrep -c "^$hoy-EUR-[0-9]{9}-[0-9]{9}-[A-Z]*" divisasHoy.txt) #Cuenta cuantas cotizaciones hay en el dia para el euro
		if [ "$lineasEuro" = "0" ]; then 	#Caso que no haya cotizaciones
			echo "$hoy Carga de euros no exitosa: no hay informacion de la divisa en el dia" > $CARGA #Sobreescribe el archivo para borrar lo anterior
		elif [ "$lineasEuro" = "1" ]; then 	#Caso que hay una sola cotizacion
			echo "$(cat divisasHoy.txt | cut -d "-" -f 3)"
			echo "$(cat divisasHoy.txt | cut -d "-" -f 4)"

			COTIZACION[0]=$(cat divisasHoy.txt | cut -d "-" -f 3)	#Guardo la divisa de compra para Euro
			COTIZACION[1]=$(cat divisasHoy.txt | cut -d "-" -f 4)	#Guardo la divisa de venta para Euro
			echo "$COTIZACION[0]"	#ESTAN GUARDANDO LO MISMO
			echo "$COTIZACION[1]"
			if [ "$COTIZACION[0]" = "0" || "$COTIZACION[1]" = "0" ]; then
				echo "$hoy Carga de euros no exitosa: divisas incorrectas"
			else
				echo "$hoy La carga de euros fue exitosa" > $CARGA
			fi
		else	 #Caso que haya mas de una cotizacion
			echo "$hoy Carga de euros no exitosa: mas de una cotizacion en el dia" > $CARGA
		fi

		lineasDolar=$(egrep -c "^$hoy-USD-[0-9]{9}-[0-9]{9}-[A-Z]*" divisasHoy.txt) 
		if [ "$lineasDolar" = "0" ]; then 
			echo "$hoy Carga de dolares no exitosa: no hay informacion de la divisa en el dia" >> $CARGA
		elif [ "$lineasDolar" = "1" ]; then 
			echo "$hoy La carga de dolares fue exitosa" >> $CARGA
		else
			echo "$hoy Carga de dolares no exitosa: mas de una cotizacion en el dia" >> $CARGA
		fi

		lineasArg=$(egrep -c "^$hoy-ARG-[0-9]{9}-[0-9]{9}-[A-Z]*" divisasHoy.txt)
		if [ "$lineasArg" = "0" ]; then
			echo "$hoy Carga de pesos argentinos no exitosa: no hay informacion de la divisa en el dia" >> $CARGA
		elif [ "$lineasArg" = "1" ]; then
			echo "$hoy La carga de pesos argentinos fue exitosa" >> $CARGA
		else
			echo "$hoy Carga de pesos argentinos no exitosa: mas de una cotizacion en el dia" >> $CARGA
		fi

		lineasReal=$(egrep -c "^$hoy-BRL-[0-9]{9}-[0-9]{9}-[A-Z]*" divisasHoy.txt)
		if [ "$lineasReal" = "0" ]; then
			echo "$hoy Carga de reales no exitosa: no hay informacion de la divisa en el dia" >> $CARGA
		elif [ "$lineasReal" = "1" ]; then
			echo "$hoy - La carga de reales fue exitosa" >> $CARGA
		else
			echo "$hoy - Carga de reales no exitosa: mas de una cotizacion en el dia" >> $CARGA
		fi

		rm divisasHoy.txt
	else
		echo "$hoy - Carga de monedas no exitosa: No hay archivo de divisas" > $CARGA
	fi

#	menuPrincipal
}

menuMoneda() {
	echo "Elija una moneda"
	echo "1-Euro"
	echo "2-Dolar Americano"
	echo "3-Peso Argentino"
	echo "4-Reales"
}

comprarDivisas(){ #De donde las divisas
	hoy=$(date +%d/%m/%Y)
	menuMoneda
#	read moneda
	echo "Elija la operacion"
	echo "1-Compra"
	echo "2-Venta" # SEPARAR para ventaDivisas
#	read op
	echo "Ingrese cantidad de la moneda a comprar"
#	read cantMoneda

#	if [ "$moneda" = "1" &&  ]; then
#		echo "$hoy - compra " >> $COMPRA

#	egrep -i "^$hoy-(EUR|ARG|USD|UYU)-[0-9]{9}-[0-9]{9}-[A-Z]*" $DIVISAS > divisasHoy.txt
#	divisasHoy=$(cat divisasHoy.txt) #Toma divisas del dia

	menuPrincipal
}

menuPrincipal() {
	echo "Elija una operación:"
	echo "1-cargar divisas"
	echo "2-comprar divisas"
	echo "3-venta divisas"
	echo "0-terminar programa"

	read op

	if [ $op = "1" ]; then
		cargarDivisas
	elif [ $op = "2" ]; then
		comprarDivisas
	elif [ $op = "3" ]; then
		ventaDivisas
	elif [ $op = "0" ]; then
		exit
	else
		echo "opcion ingresada incorrecta"
		menuPrincipal
	fi
}

cargarDivisas
#menuPrincipal
