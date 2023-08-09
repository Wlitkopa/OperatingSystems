#!/bin/bash

if [[ $# -le 1 ]]; then
	echo "Podaj argumenty do funkcji"
	exit
fi


for (( i=$#; i>0; i-- )); do
	echo -n "${!i} " 
done

echo ""

