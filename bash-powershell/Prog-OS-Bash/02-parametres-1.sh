# Créer un script qui compte le nombre de paramètres
# qui lui ont été passé

# affiche un message personnalisé selon votre nom
# d'utilisateur entré en paramètre au script:

# robert = bonjour robert
# test = attention ceci est un compte de test
# root = Bienvenue administrateur
# nom inconnu = Erreur (+ retourner le code d'erreur)

# Variante : pour chaque paramètre entré, le script fait le test


exit=0

if [$1 == "robert"]
    then echo "bonjour robert"
elif [$1 == "test"]
    then echo "attention ceci est un compte de test"
elif [$1 == "root"]
    then echo "Bienvenue administrateur"
else
    echo "Erreur !! >_<"
    exit=1
fi

echo $exit


# faire: echo $?, pour avoir le code de sortie du script !!

