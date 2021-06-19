# Lister les fichiers d'un répertoire qui ont pour extension
# txt via la commande Where-Object (?).
# Utilisez un pipeline pour réaliser la commande en une seule ligne.

Get-ChildItem | Where-Object {$_.Extension -eq ".txt"}
# ls | ? {$_.Extension -eq ".txt"}

