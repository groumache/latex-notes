# Créez un script qui permet d’ajouter ou de modifier une clé de registre sur une machine distante.
# Fonctionnalités du script :
#     - Utilisation des fonctions avancées          ====>>          Quelles fonctions ??
#     - Gestion des erreurs avec try/catch
#     - Gestion du forçage en cas de clé déjà présente, ce qui produit une modification de la valeur    ====>>      What ?
#     - Le script demande à l’utilisateur :
#         - D’entrer le nom de la machine distante
#         - Le nom de la clé à ajouter/modifier
#         - La valeur de la clé
#         - Donne le choix entre les chemins suivants :
#             - HKLM:\Software\
#             - HKLM:\System\


$machine_name = Read-Host "Name of the machine"
$key_name = Read-Host "Name of the key"
$key_value = Read-Host "Value of the key"
$path = Read-Host "Choose between path (1) 'HKLM:\Software\' and (2) 'HKLM:\System\'. Type 1 or 2."


if ($path -eq 1) {
    $path = "HKLM:\Software\"
} else {
    $path = "HKLM:\System\"
}


try {
    New-ItemProperty -ComputerName $machine_name -Path $path -Name $key_name -Value $key_value
} catch {
    Write-Host -ForegroundColor "Magenta" "The key $key_name already exists."
}

