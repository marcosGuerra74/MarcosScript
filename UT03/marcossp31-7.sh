#!/bin/bash

# Guardaremos el registro en la misma carpeta para no tener problemas de permisos
archivo_log="registro_disco.log"
umbral=80

# Usamos grep '^/dev/' para revisar solo los discos reales (ignorando tmpfs, loop, etc.)
df -h | grep '^/dev/' | while read linea; do
    # Extraemos el nombre de la partición (columna 1) y el porcentaje (columna 5)
    particion=$(echo $linea | awk '{print $1}')
    uso_texto=$(echo $linea | awk '{print $5}')
    # Le quitamos el símbolo "%" al porcentaje para poder comparar números matemáticamente
    uso=$(echo $uso_texto | tr -d '%')
   # Si el uso es mayor o igual al umbral, escribimos en el log
    if [ $uso -ge $umbral ]; then
        fecha=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[$fecha] ATENCION: La particion $particion esta al $uso% de uso." >> "$archivo_log"
    fi

done

