#!/bin/bash


min=$1
max=$2


echo "Min: $min Max: $max"

if [[ $max -le $min ]];then
	echo "Najpierw ma być mniejsza liczba, potem większa"
	exit 0
fi
range=$(($max - $min))
number=$(( $RANDOM%$(($max-$min+1))+$min ))
attempts=10

for (( i=0; i<$attempts; i++ )); do

	read us_num

	if [[ $us_num -eq $number ]]; then
		echo "That's the number!"
		exit
	else
		echo "Zostało Ci $(( $attempts-$i-1 )) prób"
	fi
done

echo "Spróbuj następnym razem!"

echo "Range: $range"
echo "Random: $number"

