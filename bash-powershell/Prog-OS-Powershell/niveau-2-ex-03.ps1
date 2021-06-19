# Dans l'exercice précédent, on suppose que les clés sont inexistantes avant le lancement du script.
# Dans le cas contraire, PowerShell génère une erreur.
# Exercice : Implémentez la gestion des erreurs via try-catch-finally



$hashtable_register_keys = @{"Test-Version" = "2.0"; "Test-Region" = "Belgium"}


function Set-RegKey {
    param (
        $KeyName,
        $KeyValue
    )
    $path = "HKLM:\SOFTWARE"

    try {
        New-ItemProperty -Path $path -Name $KeyName -Value $KeyValue
        Write-Output "New register key in: $path, name: $KeyName, value: $KeyValue"
    }
    catch {
        Write-Host -ForegroundColor "Magenta" "The key $KeyName already exists."
    }
}


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

