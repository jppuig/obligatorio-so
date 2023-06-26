#!/bin/bash

# Juan Pedro Puig - 281088
# Pedro Azambuja - 270218

BASEPATH="."
ENTRADA="$BASEPATH/entradas"
SALIDA="$BASEPATH/salidas"
DIVISAS="$ENTRADA/divisas.txt"
CARGA="$SALIDA/carga.txt"
COMPRA="$SALIDA/CompraDeDivisas.txt"
VENTA="$SALIDA/VentaDeDivisas.txt"

COTIZACION=(0 0 0 0 0 0 0 0) #Orden del array: venta compra para las monedas Euro, Dolar, Arg, Real
BLOQUEOCOMPRA="false"
BLOQUEOVENTA="false"

echo "Comienza el programa buscando divisas para el día de hoy"
echo ""

cargarDivisas() {
	hoy=$(date +%d/%m/%Y)
	if  [ -s $DIVISAS ]; then # Chequea si existe archivo
		egrep -i "^$hoy-(EUR|ARG|USD|BRL)-[0-9]{9}-[0-9]{9}" $DIVISAS > divisasHoy.txt

		lineasEuro=$(egrep -c "^$hoy-EUR-[0-9]{9}-[0-9]{9}" divisasHoy.txt) #Cuenta cuantas cotizaciones hay en el dia para el euro
		if [ "$lineasEuro" = "0" ]; then 	#Caso que no haya cotizaciones
			echo "$hoy Carga de euros no exitosa: no hay informacion de la divisa en el dia" >> $CARGA #Sobreescribe el archivo para borrar lo anterior
		elif [ "$lineasEuro" = "1" ]; then 	#Caso que hay una sola cotizacion
			cotEuro=$(egrep "^$hoy-EUR-[0-9]{9}-[0-9]{9}" divisasHoy.txt)
			COTIZACION[0]=$(echo "$cotEuro" | cut -d "-" -f 3)	#Guardo la divisa de compra para Euro
			COTIZACION[1]=$(echo "$cotEuro" | cut -d "-" -f 4)	#Guardo la divisa de venta para Euro

			compra=${COTIZACION[0]}
			venta=${COTIZACION[1]}
			if [ "$compra" -gt 0 ] && [ "$venta" -gt 0 ]; then
				echo "Se cargaron las divisas de euros"
				echo "$hoy La carga de euros fue exitosa" > $CARGA
			else
				echo 
				COTIZACION[0]=0
				COTIZACION[1]=0
				echo "$hoy Carga de euros no exitosa: divisas incorrectas" > $CARGA			
			fi
		else	 #Caso que haya mas de una cotizacion
			echo "$hoy Carga de euros no exitosa: mas de una cotizacion en el dia" > $CARGA
		fi

		lineasDolar=$(egrep -c "^$hoy-USD-[0-9]{9}-[0-9]{9}" divisasHoy.txt) 
		if [ "$lineasDolar" = "0" ]; then 
			echo "$hoy Carga de dolares no exitosa: no hay informacion de la divisa en el dia" >> $CARGA
		elif [ "$lineasDolar" = "1" ]; then
			cotDolar=$(egrep "^$hoy-USD-[0-9]{9}-[0-9]{9}" divisasHoy.txt)
			COTIZACION[2]=$(echo "$cotDolar" | cut -d "-" -f 3)
			COTIZACION[3]=$(echo "$cotDolar" | cut -d "-" -f 4)

			compra=${COTIZACION[2]}
			venta=${COTIZACION[3]}
			if [ "$compra" -gt 0 ] && [ "$venta" -gt 0 ]; then
				echo "Se cargaron las divisas de dolares"
				echo "$hoy La carga de dolares fue exitosa" >> $CARGA
			else
				COTIZACION[2]=0
				COTIZACION[3]=0
				echo "$hoy Carga de dolares no exitosa: divisas incorrectas" >> $CARGA
			fi
		else
			echo "$hoy Carga de dolares no exitosa: mas de una cotizacion en el dia" >> $CARGA
		fi

		lineasArg=$(egrep -c "^$hoy-ARG-[0-9]{9}-[0-9]{9}" divisasHoy.txt)
		if [ "$lineasArg" = "0" ]; then
			echo "$hoy Carga de pesos argentinos no exitosa: no hay informacion de la divisa en el dia" >> $CARGA
		elif [ "$lineasArg" = "1" ]; then
			cotPeso=$(egrep "^$hoy-ARG-[0-9]{9}-[0-9]{9}" divisasHoy.txt)
			COTIZACION[4]=$(echo "$cotPeso" | cut -d "-" -f 3)	#Guardo la divisa de compra para Euro
			COTIZACION[5]=$(echo "$cotPeso" | cut -d "-" -f 4)	#Guardo la divisa de compra para Euro

			compra=${COTIZACION[4]}
			venta=${COTIZACION[5]}
			if [ "$compra" -gt 0 ] && [ "$venta" -gt 0 ]; then
				echo "Se cargaron las divisas de pesos argentinos"
				echo "$hoy La carga de pesos argentinos fue exitosa" >> $CARGA
			else
				COTIZACION[4]=0
				COTIZACION[5]=0
				echo "$hoy Carga de pesos argentinos no exitosa: divisas incorrectas" >> $CARGA
			fi
		else
			echo "$hoy Carga de pesos argentinos no exitosa: mas de una cotizacion en el dia" >> $CARGA
		fi

		lineasReal=$(egrep -c "^$hoy-BRL-[0-9]{9}-[0-9]{9}" divisasHoy.txt)
		if [ "$lineasReal" = "0" ]; then
			echo "$hoy Carga de reales no exitosa: no hay informacion de la divisa en el dia" >> $CARGA
		elif [ "$lineasReal" = "1" ]; then
			cotReal=$(egrep "^$hoy-BRL-[0-9]{9}-[0-9]{9}" divisasHoy.txt)
			COTIZACION[6]=$(echo "$cotReal" | cut -d "-" -f 3)	#Guardo la divisa de compra para Euro
			COTIZACION[7]=$(echo "$cotReal" | cut -d "-" -f 4)	#Guardo la divisa de compra para Euro

			compra=${COTIZACION[6]}
			venta=${COTIZACION[7]}
			if [ "$compra" -gt 0 ] && [ "$venta" -gt 0 ]; then
				echo "Se cargaron las divisas de reales"
				echo "$hoy La carga de reales fue exitosa" >> $CARGA
			else
				COTIZACION[6]=0
				COTIZACION[7]=0
				echo "$hoy Carga de reales no exitosa: divisas incorrectas" >> $CARGA
			fi
		else
			echo "$hoy Carga de reales no exitosa: mas de una cotizacion en el dia" >> $CARGA
		fi

		rm divisasHoy.txt
	else
		echo "$hoy - Carga de monedas no exitosa: No hay archivo de divisas" > $CARGA
	fi

	echo ""
	menuPrincipal
}

menuMoneda() {
	echo "Elija una moneda"
	echo "1-Euro"
	echo "2-Dolar Americano"
	echo "3-Peso Argentino"
	echo "4-Reales"
}

comprarDivisas(){
	if [ "$BLOQUEOCOMPRA" = "false" ]; then
		hoy=$(date +%d/%m/%Y)
		menuMoneda
		read moneda
		while [ $moneda -lt 1 ] || [ $moneda -gt 4 ]; do
			echo "Moneda ingresada incorrecta, vuelva a intentarlo"
			read moneda
		done

		echo "Ingrese monto de la moneda que se quiere comprar (solo numeros enteros):"
		read cantMoneda
		while [ $cantMoneda -lt 1 ]; do
			echo "Monto ingresado incorrecto, debe ser mayor a 0"
			read cantMoneda
		done

		esta=true # Accede a una divisa que existe en el dia

		if [ "$moneda" = "1" ]; then
			if [ "${COTIZACION[1]}" = "0" ]; then # Chequea que la venta no sea 0, si es, es pq no hay cotizacion
				esta=false
				echo "No hay cotizacion del euro para el dia de hoy"
			else
				divisa="euros"
				cot=${COTIZACION[1]#"${COTIZACION[1]%%[!0]*}"}
			fi
		elif [ "$moneda" = "2" ]; then
			if [ "${COTIZACION[3]}" = "0" ]; then
				esta=false
				echo "No hay cotizacion del dolar para el dia de hoy"
			else
				divisa="dolares"
				cot=${COTIZACION[3]#"${COTIZACION[3]%%[!0]*}"}
			fi
		elif [ "$moneda" = "3" ];then
			if [ "${COTIZACION[5]}" = "0" ]; then
				esta=false
				echo "No hay cotizacion del peso argentino para el dia de hoy"
			else
				divisa="pesos argentinos"
				cot=${COTIZACION[5]#"${COTIZACION[5]%%[!0]*}"}
			fi
		elif [ "$moneda" = "4" ];then
			if [ "${COTIZACION[7]}" = "0" ];then
				esta=false
				echo "No hay cotizacion del real para el dia de hoy"
			else
				divisa="reales"
				cot=${COTIZACION[7]#"${COTIZACION[7]%%[!0]*}"}
			fi
		fi

		if [ "$esta" = "true" ]; then
			uru=$(($cot * $cantMoneda))
			uruDecimal=$(($uru % 100))
			uruEntero=$(($uru / 100))

			echo "El monto a comprar en pesos uruguayos es de $uruEntero,$uruDecimal"
			echo "$hoy - Compra de $cantMoneda $divisa por $uruEntero,$uruDecimal pesos uruguayos" >> $COMPRA
			echo "Compra exitosa"
		fi
	else
		echo "Las transacciones de compra estan bloqueadas"
	fi

	echo ""
	menuPrincipal
}

ventaDivisas(){
	if [ "$BLOQUEOVENTA" = "false" ]; then
		hoy=$(date +%d/%m/%Y)
		menuMoneda
		read moneda
		while [ $moneda -lt 1 ] || [ $moneda -gt 4 ]; do
			echo "Moneda ingresada incorrecta, vuelva a intentarlo"
			read moneda
		done

		echo "Ingrese monto de la moneda que se quiere vender (solo numeros enteros):"
		read cantMoneda
		while [ $cantMoneda -lt 1 ]; do
			echo "Monto ingresado incorrecto, debe ser mayor a 0"
			read cantMoneda
		done

		esta=true # Accede a una divisa que existe en el dia

		if [ "$moneda" = "1" ]; then
			if [ "${COTIZACION[0]}" = "0" ]; then
				esta=false
				echo "No hay cotizacion del euro para el dia de hoy"
			else
				divisa="euros"
				cot=${COTIZACION[0]#"${COTIZACION[0]%%[!0]*}"}
			fi
		elif [ "$moneda" = "2" ]; then
			if [ "${COTIZACION[2]}" = "0" ]; then
				esta=false
				echo "No hay cotizacion del dolar para el dia de hoy"
			else
				divisa="dolares"
				cot=${COTIZACION[2]#"${COTIZACION[2]%%[!0]*}"}
			fi
		elif [ "$moneda" = "3" ];then
			if [ "${COTIZACION[4]}" = "0" ]; then
				esta=false
				echo "No hay cotizacion del peso argentino para el dia de hoy"
			else
				divisa="pesos argentinos"
				cot=${COTIZACION[4]#"${COTIZACION[4]%%[!0]*}"}
			fi
		elif [ "$moneda" = "4" ];then
			if [ "${COTIZACION[6]}" = "0" ];then
				esta=false
				echo "No hay cotizacion del real para el dia de hoy"
			else
				divisa="reales"
				cot=${COTIZACION[6]#"${COTIZACION[6]%%[!0]*}"}
			fi
		fi

		if [ "$esta" = "true" ]; then
			uru=$(($cot * $cantMoneda))
			uruDecimal=$(($uru % 100))
			uruEntero=$(($uru / 100))

			echo "El monto a vender en pesos uruguayos es de $uruEntero,$uruDecimal"
			echo "$hoy - Venta de $cantMoneda $divisa por $uruEntero,$uruDecimal pesos uruguayos" >> $VENTA
			echo "Venta exitosa"
		fi
	else
		echo "Las transacciones de venta estan bloqueadas"
	fi

	echo ""
	menuPrincipal
}

buscarFecha() {
	echo "El formato de las fechas es el siguiente: dd/mm/yyyy"
	echo "Ingrese el dia a buscar (dd):"
	read dia
	while [ $dia -lt 1 ] || [ $dia -gt 31 ]; do
		echo "Dia ingresado incorrecto, debe estar entre el 1 y 31. Vuelva a intentarlo:"
		read dia
	done

	echo "Ingrese el mes a buscar (mm):"
	read mes
	while [ $mes -lt 1 ] || [ $mes -gt 12 ]; do
		echo "Mes ingresado incorrecto, debe estar entre el 1 y 12. Vuelva a intentarlo:"
		read mes
	done
# Agregar que si meten 4 pasa el while pero agrego un 0 adelante

	echo "Ingrese anio a buscar (yyyy):"
	read anio
	while [ $anio -lt 2010 ] || [ $anio -gt 2023 ]; do
		echo "Anio ingresado incorrecto, debe estar entre el 2010 y 2023. Vuelva a intentarlo:"
		read anio
	done

	fecha="$dia/$mes/$anio"
	if [ -s $COMPRA ]; then
		echo "$(egrep -i "^$fecha" $COMPRA)"
	fi

	if [ -s $VENTA ]; then
		echo "$(egrep -i "^$fecha" $VENTA)"
	fi

	echo ""
	menuPrincipal
}

buscarDivisa() {
	menuMoneda
	read moneda

	if [ "$moneda" = "1" ]; then
		divisa="euros"
	elif [ "$moneda" = "2" ]; then
		divisa="dolares"
	elif [ "$moneda" = "3" ];then
		divisa="pesos argentinos"
	elif [ "$moneda" = "4" ];then
		divisa="reales"
	else
		echo "Opcion ingresada incorrecta, vuelva a intentarlo"
		echo ""
		buscarDivisa
	fi

	hayCompra="true"
	if [ -s $COMPRA ]; then
		if [ "$(egrep -c "$divisa" $COMPRA)" -gt "1" ]; then
			echo "$(egrep -i "$divisa" $COMPRA)"
		else
			hayCompra="false"
		fi
	fi

	if [ -s $VENTA ]; then
		if [ "$(egrep -c "$divisa" $VENTA)" -gt "1" ]; then
			echo "$(egrep -i "$divisa" $VENTA)"
		elif [ "$hayCompra" = "false" ]; then
			echo "No hay registros de la divisa."
		fi
	fi

	echo ""
	menuPrincipal
}

buscarMonto() {
	# Busca todos los montos en las transacciones que terminen en la parte decimal de pesos con 3
	echo "Se buscan las transacciones que tengan montos finalizados en 3..."
	hayCompra="true"
	if [ -s $COMPRA ]; then
		if [ "$(egrep -c ",[0-9]*+3\b" $COMPRA)" -gt "0" ]; then
			echo "$(egrep -i ",[0-9]*+3\b" $COMPRA)"
		else
			hayCompra="false"
		fi
	fi

	if [ -s $VENTA ]; then
		if [ "$(egrep -c ",[0-9]*+3\b" $VENTA)" -gt "0" ]; then
			echo "$(egrep -i ",[0-9]*+3\b" $VENTA)"
		elif [ "$hayCompra" = "false" ]; then
			echo "No hay registros del monto."
		fi
	fi

	echo ""
	menuPrincipal
}

bloquearTransacciones() {
	echo "Desea bloquear transacciones?"
	echo "1-Si"
	echo "2-No"
	read confirmacion

	if [ "$confirmacion" = "1" ]; then
		echo "Que transacciones desea bloquear?"
		echo "1-Compra"
		echo "2-Venta"
		echo "3-Ambas"
		read op

		if [ $op -lt 1 ] || [ $op -gt 3 ]; then
			echo "Opcion ingresada incorrecta, vuelva a intentarlo"
			echo ""
			bloquearTransacciones
		else
			if [ "$op" = "1" ]; then
				if [ "$BLOQUEOCOMPRA" = "false" ]; then
					BLOQUEOCOMPRA="true"
					chmod a-w $COMPRA
					echo "Transacciones de compra bloqueadas"
				else
					echo "Las transacciones de compra ya estan bloqueadas"
				fi
			elif [ "$op" = "2" ]; then
				if [ "$BLOQUEOVENTA" = "false" ]; then
					BLOQUEOVENTA="true"
					chmod a-w $VENTA
					echo "Transacciones de venta bloqueadas"
				else
					echo "Las transacciones de venta ya estan bloqueadas"
				fi
			else
				BLOQUEOCOMPRA="true"
				BLOQUEOVENTA="true"
				chmod a-w $COMPRA
				chmod a-w $VENTA
				echo "Ambas transacciones estan bloqueadas"
			fi
		fi
	fi

	echo ""
	menuPrincipal
}

desbloquearTransacciones() {
	echo "Desea desbloquear transacciones?"
	echo "1-Si"
	echo "2-No"
	read confirmacion

	if [ "$confirmacion" = "1" ]; then
		echo "Que transacciones desea desbloquear?"
		echo "1-Compra"
		echo "2-Venta"
		echo "3-Ambas"
		read op

		if [ $op -lt 1 ] || [ $op -gt 3 ]; then
			echo "Opcion ingresada incorrecta, vuelva a intentarlo"
			echo ""
			bloquearTransacciones
		else
			if [ "$op" = "1" ]; then
				if [ "$BLOQUEOCOMPRA" = "true" ]; then
					BLOQUEOCOMPRA="false"
					chmod a+w $COMPRA
					echo "Transacciones de compra desbloqueadas"
				else
					echo "Las transacciones de compra ya estan desbloqueadas"
				fi
			elif [ "$op" = "2" ]; then
				if [ "$BLOQUEOVENTA" = "true" ]; then
					BLOQUEOVENTA="false"
					chmod a+w $VENTA
					echo "Transacciones de venta desbloqueadas"
				else
					echo "Las transacciones de venta ya estan desbloqueadas"
				fi
			else
				BLOQUEOCOMPRA="false"
				BLOQUEOVENTA="false"
				chmod a+w $COMPRA
				chmod a+w $VENTA
				echo "Ambas transacciones estan desbloqueadas"
			fi
		fi
	fi

	echo ""
	menuPrincipal
}

menuPrincipal() {
	echo "Elija una operación:"
	echo "1-cargar divisas"
	echo "2-comprar divisas"
	echo "3-venta divisas"
	echo "4-Buscar transacciones por fecha"
	echo "5-Buscar transacciones por divisa"
	echo "6-Buscar transacciones por monto"
	echo "7-Bloquear transacciones"
	echo "8-Desbloquear transacciones"
	echo "0-terminar programa"

	read op

	if [ "$op" = "1" ]; then
		cargarDivisas
	elif [ "$op" = "2" ]; then
		comprarDivisas
	elif [ "$op" = "3" ]; then
		ventaDivisas
	elif [ "$op" = "4" ]; then
		buscarFecha
	elif [ "$op" = "5" ]; then
		buscarDivisa
	elif [ "$op" = "6" ]; then
		buscarMonto
	elif [ "$op" = "7" ]; then
		bloquearTransacciones
	elif [ "$op" = "8" ]; then
		desbloquearTransacciones
	elif [ "$op" = "0" ]; then
		exit
	else
		echo "Opcion ingresada incorrecta"
		menuPrincipal
	fi
}

cargarDivisas
