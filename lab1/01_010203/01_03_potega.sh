#!/bin/bash

base=$1
exponent=$2

echo "With operator: "
echo $(($base**$exponent))

temp=1

for (( i=0; i<$exponent; i++ ));
do
	temp=$(($temp*$base))
	echo "Działa for"
done

echo "With for: $temp"


