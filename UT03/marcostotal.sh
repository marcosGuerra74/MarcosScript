#!/bin/bash
# Extraemos mes y año completo (ej. noviembre2026)
mes_ano=$(date "+%B%Y")

# Hacemos la copia de seguridad total
tar -czf /bacmarcos/CopTot-${mes_ano}.tar.gz /home 2>/dev/null

# Creamos un archivo de marca de tiempo que usará la copia diferencial
touch /bacmarcos/marca_total


