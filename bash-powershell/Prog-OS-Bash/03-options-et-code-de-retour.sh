#!/bin/bash


while getopts ":abc" option
do
    case $option in
        a) echo "commande a";;
        b) echo "commande b";;
        c) echo "commande c";;
        \?)
            echo $OPTARG "option invalide"
            exit 1;;
    esac
done

echo "Option analysis over"
exit 0
