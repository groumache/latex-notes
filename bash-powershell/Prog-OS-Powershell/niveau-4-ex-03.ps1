# Sur base d’un serveur Active Directory fonctionnel
#   - Domaine créé (henallux.local ou autre...)
#   - DNS fonctionnel sur votre domaine
#   1. Joindre un PC client au domaine
#   2. Créer les OU suivantes
#     -  Professeurs
#     -  Etudiants
#     -  Administration
#   3. En un script sur base d’un fichier csv, créer et ajouter
#      les utilisateurs en fonction des paramètres du fichier csv
#   4. Vérifier que les utilisateurs peuvent utiliser le pc client


$file = "C:\Users\groum.LAPTOP-MUKCF9T7\Documents\Programmation\Scripting-Unix-Powershell\Prog-OS-Powershell\PowerShellSecure.csv"


# 1. Joindre un PC client au domaine
Add-Computer -ComputerName "greg-laptop" -DomainName "greg-domain\domain-controller"

Get-ADComputer -Filter *


# 2. Créer les OU
New-ADOrganizationalUnit -Path "DC=henallux,DC=local" -Name "Professeurs"
New-ADOrganizationalUnit -Path "DC=henallux,DC=local" -Name "Etudiants"
New-ADOrganizationalUnit -Path "DC=henallux,DC=local" -Name "Administration"

Get-ADOrganizationalUnit -Filter *


# 3. En un script sur base d’un fichier csv
# firstname;lastname;username;departement;ChangePWlogon;ou
$csv = Import-Csv -Path $file -Delimiter ';'
$csv | ForEach-Object {
    New-ADUser -GivenName $_.firstname -Surname $_.lastname -Name $_.username `
        -Department $_.departement -ChangePasswordAtLogon $_.ChangePWlogon -Path $_.ou
}

Get-ADUser -Filter *


# 4. Vérifier que les utilisateurs peuvent utiliser le pc client
# se connecter avec un des utilisateurs


# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-computer?view=powershell-5.1
