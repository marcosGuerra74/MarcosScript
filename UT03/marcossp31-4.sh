#!/bin/bash

fichero="programas.txt"


echo "Iniciando lectura de $fichero..."
echo "------------------------------------------------"

# Usamos un bucle for leyendo el contenido del fichero con el comando cat
for programa in $(cat "$fichero"); do
    # dpkg -s comprueba el estado del paquete en el sistema
    if dpkg -s  "$programa"; then
        echo "Desinstalando: $programa..."
        # Ejecutamos la desinstalación automática (-y) de forma silenciosa (-qq)
      sudo apt-get remove -y -qq "$programa" >/dev/null 2>&1
        echo "El programa $programa ha sido eliminado."
    else
        echo "El programa $programa no esta instalado. Pasando al siguiente..."
    fi
    echo "------------------------------------------------"

done

echo "Proceso de limpieza terminado."


