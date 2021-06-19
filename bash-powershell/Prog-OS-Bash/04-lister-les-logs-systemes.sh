# Réaliser un script qui affiche le contenu de tous les fichiers
# log qui se trouvent dans le répertoire /var/log avec l'option
# -a (y compris dans les sous répertoires).
# Sans options, il affichera le listing des différents fichiers
# de log. Avec -l, il listera le contenu du fichier de log demandé.


if [[ $# -eq 1 ]]
then
    echo "listing des fichiers ^^"
    ls -l /var/log
    exit 0
fi

while getopts ":al" option
do
    case $option in
        a)
            echo "listing des fichiers récursif ^^"
            ls -R -l /var/log;; # -R = recursive
        l)
            echo "affichage du log demandé ^^"
            cat /var/log/$2;;
        \?)
            echo "erreur: option inconnue ^^"
            exit 1;;
    esac
done

exit 0
