# Réaliser un script qui liste les comptes utilisateurs normaux
# du système, ç à d dont le UID est supérieur à 500 (3ème
# colonne dans le fichier /etc/passwd). Le script doit également
# indiquer le shell par défaut employé par cet utilisateur.


awk -F: '{if ($3 >= 500) { print $1, "-", $3, "-", $7 }}' /etc/passwd

