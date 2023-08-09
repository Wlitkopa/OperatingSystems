#!/bin/bash

if [[ $# != 1 ]]; then
	echo "Podaj jeden argument"
	exit
elif [[ ! -d $1 ]]; then
	echo "Nie istnieje podany katalog"
	exit
fi




ls -lR $1 | cut -d' ' -f1 | grep ^[-,b,l,d,c,p,f,s] | tail -n +2 | sort | uniq -c
