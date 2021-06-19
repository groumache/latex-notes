# Créez un script qui permet de vérifier l’état d’un service.
# Selon son état, demander pour le démarrer/arrêter.
# Fonctionnalités du script :
#     - Demande le nom de la machine à interroger
#     - Demande à l’utilisateur le nom du service
#     - Affiche l’état du service
#     - Si le service est "Stopped", demander s’il faut le démarrer
#     - Si le service est "Running", demander s’il faut le stopper
#     - Affiche l’état final du service


$machine_name = Read-Host "Name of the machine" # ex : localhost
$service_name = Read-Host "Name of the service" # ex : WinDefend


$service = Get-Service -ComputerName $machine_name | Where-Object {$_.Name -eq $service_name}
Write-Host $service " -- " $service.Status


if ($service.Status -eq "Running") {
    $change_status = Read-Host "Should we stop this service (y/n)"
} else {
    $change_status = Read-Host "Should we start this service  (y/n)"
}


if ($change_status -eq "y" -and $service.Status -eq "Running") {
    $service | Set-Service -Status "Stopped"
} elseif ($change_status -eq "y" -and $service.Status -eq "Stopped") {
    $service | Set-Service -Status "Running"
}


Write-Host $service " -- " $service.Status

