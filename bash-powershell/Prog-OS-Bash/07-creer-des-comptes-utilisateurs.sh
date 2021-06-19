# Réaliser un script qui permet de créer des comptes
# utilisateurs à partir d'un fichier comprenant : login
# et mot de passe, séparé par des virgules.

# L'option –h permet d'afficher une aide indiquant l’ordre
# dans lequel les éléments doivent être présent dans le
# fichier et l'option -o. Le séparateur par défaut est ";".
# L'option –s permet de choisir un autre séparateur.


function create_logins() {
    file=$1
    separator=$2

    echo "file ='$file', separator = '$separator'"

    while read -r line
    do
        login=$(echo $line | cut -d $separator -f 1)
        password=$(echo $line | cut -d $separator -f 2)
        command="useradd $login --password $password"
        echo $command
        $command
    done < "$file"
}


separator=';'


while getopts ":hos" option
do
    case $option in
        h)
            echo "format fichier = <login>;<mdp>"
            echo "use -s to change the separator"
            echo "use -o to specify the file";;
        o)
            file=$2
            create_logins $file $separator;;
        s)
            separator=$2;;
        \?)
            echo "erreur: option incorrecte";;
    esac
done
