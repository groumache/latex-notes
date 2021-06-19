# Créez un script réalisant les tâches suivantes :
# 1. Ajout de deux clés de registre
#     - Test-Version
#         - Valeur : 2.0
#     - Test-Region
#         - Valeur : Belgium
#     - Chemin : HKEY_LOCAL_MACHINE\SOFTWARE
#     - Remarque : Stockez les données dans une variable tableau (hashtable)


$hashtable_register_keys = @{"Test-Version" = "2.0"; "Test-Region" = "Belgium"}


function Set-RegKey {
    param (
        $KeyName,
        $KeyValue
    )
    $path = "HKLM:\SOFTWARE"

    Write-Output "New register key in: $path, name: $KeyName, value: $KeyValue"
    New-ItemProperty -Path $path -Name $KeyName -Value $KeyValue
}


# 2. Enregistrement des actions dans un fichier log
#     - Chemin : vous stockez vos logs dans un répertoire « logs » à la racine d’un disque
#     - Information à enregistrer
#         - Démarrage du script
#         - Création de la clé de registre « Test-Version », Valeur : 2.0
#         - Création de la clé de registre « Test-Région », Valeur : Belgium
#         - Fin de script
#     - Utilisez des variables pour les données


function Write-Log {
    param (
        $message = "This is not an exercise."
    )
    $log_path = "E:\logs-niveau2-02-ex.txt"
    $start_log_msg = "[ $(Get-Date) ] "
    $log_msg = $start_log_msg + $message

    Write-Output $log_msg
    $log_msg | Out-File -FilePath $log_path -Append
}


# affiche les valeurs de clé de registres
# Get-PSDrive
# on voit qu'il y a deux entrées pour le registre:
# HKCU (HKEY_CURRENT_USER) et HKLM (HKEY_LOCAL_MACHINE)


# Information à enregistrer
#    - Démarrage du script
#    - Création de la clé de registre « Test-Version », Valeur : 2.0
#    - Création de la clé de registre « Test-Région », Valeur : Belgium
#    - Fin de script
Write-Log -message "Start of the script"


$hashtable_register_keys.Keys | ForEach-Object {
    $Name = $_
    $Value = $hashtable_register_keys.$_
    Write-Log -message "Create register key: $Name : $Value"
    Set-RegKey -KeyName $Name -KeyValue $Value
}

Write-Log -message "End of the script"


Remove-ItemProperty -Path "HKLM:\SOFTWARE" -Name "Test-Version"
Remove-ItemProperty -Path "HKLM:\SOFTWARE" -Name "Test-Region"

