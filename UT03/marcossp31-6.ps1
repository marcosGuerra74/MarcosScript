# Directorios típicos de logs en Windows Server
$logPaths = @(
    "C:\Windows\Logs",
    "C:\Windows\System32\LogFiles",
    "C:\inetpub\logs\LogFiles"  # Solo si existe IIS
)

# Tiempo máximo permitido de logs (30 días)
$dias = 30
$fechaLimite = (Get-Date).AddDays(-$dias)

foreach ($path in $logPaths) {
    if (Test-Path $path) {
        Write-Output "Procesando: $path"

        # Buscar logs antiguos
        $logs = Get-ChildItem -Path $path -Recurse -File -Include *.log, *.txt, *.evtx `
            | Where-Object { $_.LastWriteTime -lt $fechaLimite }

        foreach ($log in $logs) {
            try {
                Remove-Item $log.FullName -Force
                Write-Output "Eliminado: $($log.FullName)"
            }
            catch {
                Write-Output "No se pudo eliminar: $($log.FullName)"
            }
        }
    }
    else {
        Write-Output "Ruta no encontrada: $path"
    }
}

Write-Output "Limpieza de logs completada correctamente."