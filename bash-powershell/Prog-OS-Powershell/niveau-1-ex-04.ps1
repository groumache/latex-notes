# Créez un tableau recensant tous les processus Notepad
$variable = Get-Process | Where-Object {$_.ProcessName -eq "notepad"}

# Tuez tous les processus notepad en utilisant la méthode
# adéquate de la variable

# $variable | Get-Member  # => get the properties and methods
$variable.Kill()
