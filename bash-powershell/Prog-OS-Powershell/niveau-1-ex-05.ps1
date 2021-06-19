# Sur base d'un fichier texte contenant une liste de noms, créez des répertoires associés
# Astuces:
# - Créez un fichier texte contenant la liste de noms
# - Copiez le contenu du fichier dans une variable
# - Utilisez la commande New-Item pour créez les répertoire

$dir_path =  "C:\Users\groum.LAPTOP-MUKCF9T7\Downloads"
$file_path = "C:\Users\groum.LAPTOP-MUKCF9T7\Documents\Programmation\Scripting-Unix-Powershell\Prog-OS-Powershell\liste-nom.txt"
$variable = Get-Content $file_path

# $variable | % {echo $_}
$variable | ForEach-Object {Write-Output ($dir_path + "\" + $_)}
$variable | ForEach-Object {New-Item -ItemType "directory" ($dir_path + "\" + $_)}

