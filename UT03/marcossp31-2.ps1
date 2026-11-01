param (
    $FechaInicio,
    $FechaFin
)

Write-Host "Buscando inicios de sesión entre $FechaInicio y $FechaFin ..."

# Sacamos los eventos directamente sin esconder los errores
$eventos = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624; StartTime=$FechaInicio; EndTime=$FechaFin}

Write-Host "----------------------------------------------------"
Write-Host "Día`t`tHora`t`tUsuario"
Write-Host "----------------------------------------------------"

foreach ($evento in $eventos) {
    # El nombre de usuario está en la posición 5 de las propiedades del evento
    $usuario = $evento.Properties[5].Value

    # Solo filtramos SYSTEM como pide el ejercicio
    if ($usuario -ne "SYSTEM") {
        
        # Sacamos la fecha y hora de forma más sencilla
        $dia = $evento.TimeCreated.ToShortDateString()
        $hora = $evento.TimeCreated.ToShortTimeString()
        
        # Imprimimos la línea separada por tabulaciones (`t)
        Write-Host "$dia`t$hora`t`t$usuario"
    }
}