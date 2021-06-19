
# Réaliser un script qui affiche le contenu de 2 variables.
# La variable utilisateur private est interne au script et
# la variable pub est une variable globale définie dans le
# shell avant d'exécuter le script. Vérifier selon que l'on
# définisse pub comme variable globale ou non, elle est
# accessible par le script ou pas.


# this is my private variable
PRIVATE="Hello ^w^"

# print both variables
echo "public variable = $PUB"
echo "private variable = $PRIVATE"


# NOTE: the public variable has to be exported to be used in the script
#       e.g. $PATH can be used with no problem

# ex - create a public variable:
# 1. PUB="bonjour ^o^"
# 2. export PUB
# --> or : export PUB="bonjour ^o^"
