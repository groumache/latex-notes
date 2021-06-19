# idem que: '02-parametres-1.sh'

exit=0

echo "Nombre de paramètres = $#"

case $1 in
    "robert") echo "bonjour robert"
    "test") echo "attention ceci est un compte de test"
    "root") echo "Bienvenue administrateur"
    *)
        echo "Erreur >_<"
        exit=1
esac

echo $exit
