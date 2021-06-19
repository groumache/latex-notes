# Créez un script qui inverse les lettres des mots d’un texte
# Inversez les lettres, pas les mots
# Exemple :
# « Ceci est un tout petit script »
# « iceC tse nu tuot titep tpircs »


$text = Read-Host -Prompt 'Input text to reverse'
$text = $text.Split() | ForEach-Object {
    $word = $_.ToCharArray()
    for ($i = $_.ToCharArray().Count - 1; $i -ge 0 ; $i--) {
        $letter = $word[$i]
        $letter
    }
    ' '
}

Write-Host -Separator "" -ForegroundColor "Green" $text
