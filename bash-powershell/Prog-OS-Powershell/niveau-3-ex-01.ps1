# Créer un script sur un client qui permet d’afficher les services d’une machine distante.
# Fonctionnalités du script :
# - Demande le nom de la machine à interroger
#     - Si rien n’est entré, utiliser la variable d’environnement locale
#     - Utilisez le paramètre ComputerName
# - Demande si on cherche les services "Stopped" ou "Running" ==> Vérifier que l’utilisateur entre bien 1 ou 2
# - Demande le nombre de services à afficher ==> Validation entre 2 et 10
# - Utilisez une fonction avec des paramètres avancés       ====>>      ????????????????


# /!\ Désactiver les parefeux /!\
# les noms des machines sont dispo dans "active directory users and computers management"


# 1. get the machine's name
$machine_name = Read-Host "Machine name (leave blank for localhost)"
if ($machine_name.Length -eq 0) { $machine_name = "localhost" }


# 2. get the service type/status (running/stopped)
$service_type = Read-Host "Choose between running (1) or stopped (2) services. Please type 1 or 2."
$status = "Stopped"
if ($service_type -eq 1) { $status = "Running" }


# 3. get the number of services to display
$nb_services = Read-Host "Choose the number of services to display (between 1 and 10)"


# 4. get the services and filter them
Get-Service -ComputerName $machine_name `
    | Where-Object {$_.Status -eq $status} `
    | Select-Object -First $nb_services `
    | Write-Host
