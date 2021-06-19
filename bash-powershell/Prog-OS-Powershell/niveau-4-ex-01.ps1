# Modifiez la politique d’exécution de script de la machine locale
# pour qu’elle n’exécute que des scripts signés qu’ils soient locaux ou non.


Get-ExecutionPolicy
# - RemoteSigned => default = scripts can run, requires a signature for downloaded scripts
# - AllSigned => every scripts needs to be signed
# Set-ExecutionPolicy AllSigned
# Set-ExecutionPolicy RemoteSigned
Get-ExecutionPolicy


# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.1