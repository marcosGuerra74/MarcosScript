$registros = Get-EventLog -List
$opcion = ""

while ($opcion -ne "0") {
    Write-Host ""
    Write-Host "MENU DE REGISTROS"
    Write-Host "0. Salir"
    
    # Usamos el bucle for básico recorriendo el array por su posición
    for ($i = 0; $i -lt $registros.Count; $i++) {
        $numero = $i + 1
        $nombre = $registros[$i].Log
        Write-Host "$numero. $nombre"
    }
    
    Write-Host ""
    $opcion = Read-Host "Elige un numero"

    if ($opcion -eq "0") {
        Write-Host "Saliendo..."
    }
    elseif ($opcion -gt 0 -and $opcion -le $registros.Count) {
        
        # Le restamos 1 porque el índice de los arrays empieza en 0
        $posicion = $opcion - 1
        $registroElegido = $registros[$posicion].Log
        
        # Sacamos todos los eventos y los contamos
        $eventos = Get-EventLog -LogName $registroElegido
        $total = $eventos.Count

        Write-Host "Hay $total eventos en $registroElegido"
        Write-Host "Mostrando los 12 ultimos:"
        Get-EventLog -LogName $registroElegido -Newest 12
        
    }
    else {
        Write-Host "Opcion no valida."
    }
}