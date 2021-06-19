
# Réaliser un script qui affiche "le fichier existe" dans
# le cas ou il existe et si oui le type de fichier
# (fichier, dossier, exécutable, etc.)


FILE=$1

if test $FILE;
then
    echo "le fichier existe ^^"

    file $FILE

    exit 0
fi

exit 1

