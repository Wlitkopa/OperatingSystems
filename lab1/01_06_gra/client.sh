#!/bin/bash

#COMFILE=/home/przemek/sysop/zadanie06/komenda.txt

if [[ $# != 1 ]]; then
	echo "Wpisz argument: <numer gracza>"
	exit
fi

nrgracza=$1

#echo "Działa klient"

while true
do
        if [ -f "/home/przemek/sysop/zadanie06/komenda.txt" ]; then
                komenda=$(echo $(cat /home/przemek/sysop/zadanie06/komenda.txt | head -n 1))
                #echo "komenda: '$komenda'"
                if [ "$komenda" == "start" ] && [ ! -f "los${nrgracza}.txt" ]; then
                        los=$(($RANDOM%3 + 1))
                        echo "$los" >> los${nrgracza}.txt
                elif [ "$komenda" == "stop" ]; then
                        #echo "komenda: $komenda"
                        break
                fi
	else
		exit
        fi
done

exit

