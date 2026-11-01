#!/bin/bash
# Extraemos el número de semana
semana=$(date "+%V")

# -N hace que tar solo guarde los archivos más nuevos que marca_total
tar -czf /bacmarcos/CopDifSem-${semana}.tar.gz -N /bacmarcos/marca_total /home 2>/dev/null
