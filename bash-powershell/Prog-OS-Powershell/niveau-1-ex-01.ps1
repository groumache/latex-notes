# Trouvez la commande originale dont les alias sont dir et ls.
Get-Alias dir   # => Get-ChildItem
Get-Alias ls    # => Get-ChildItem

# Utilisez la pour renvoyer le listing du répertoire courant dans une variable.
$variable = Get-ChildItem

# Affichez ensuite le contenu de cette variable
$variable

# Affichez maintenant uniquement la première ligne de la variable
$variable[0]

# Affichez les méthodes et propriétés associées à cette variable
$variable.GetType()
$variable | Get-Member

# Utilisez la propriété adéquate pour afficher le mode d'accès autorisé,
# la date de dernière écriture ainsi que le répertoire associés à la
# première ligne de la variable
$variable[0] | Get-Member
$variable.GetAccessControl()
$variable.LastWriteTime
$variable.Parent
