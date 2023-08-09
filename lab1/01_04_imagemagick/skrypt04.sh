#!/bin/bash


if [[ $# -le 3 ]]; then
	echo "Podaj 4 argumenty: <dokument.pdf> <podpis.png> <x> <y>"
	echo "Optymalny x: +5000"
	echo "Optymalny y: +5500"
	exit
fi

image=$1
signature=$2
x=$3
y=$4

#echo "xy: $x$y    x: $x    y: $y    image: $image    Signature: $signature"
echo $(magick composite -geometry $3$4 $signature $image sample-over.png && sxiv sample-over.png)




