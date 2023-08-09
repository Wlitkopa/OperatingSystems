#!/bin/bash

if [[ $# != 2 ]]; then
        echo "Podaj argument: <liczba rund> <liczba graczy>"
        echo "Liczba argumentów: $#"
        exit
fi

lrund=$1
lgraczy=$2
lplikow=3
counter=0
#los1file=/home/przemek/sysop/zadanie06/los1.txt
#los2file=/home/przemek/sysop/zadanie06/los2.txt

if [ -f gra.log ]; then
        rm gra.log
fi

for (( k=0; k<$lrund; k++ )); do
        echo "start" > komenda.txt
        round=()
        for (( l=1; l<=$lgraczy; l++ )); do
                round+=(0)
                ./client.sh $l &
        done

        for (( i=1; i<$lgraczy; i++ )); do
                
                for (( j=$(($i+1)); j<=$lgraczy; j++ )); do
                        echo "Runda $(($k+1)) gracz $i oraz gracz $j"   

                 	while true;
 			do
                                los1file=/home/przemek/sysop/zadanie06/los${i}.txt
                                los2file=/home/przemek/sysop/zadanie06/los${j}.txt

                                if [[ -f "$los1file" && -f "$los2file" ]]; then

                                        #rm komenda.txt
                                        los1=$(echo $(cat ./los${i}.txt | head -n 1))
                                        los2=$(echo $(cat ./los${j}.txt | head -n 1))


                                        if [[ $los1 == $los2 ]]; then
                                                echo -n ''

                                        elif [[ $los1 > $los2 ]]; then
                                                if [[ $(($los1-$los2)) == 1 ]]; then
                                                        round[$i-1]=$((round[$i-1]+1))
                                                else
                                                        round[$j-1]=$((round[$j-1]+1))
                                                fi

                                        elif [[ $(($los2-$los1)) == 1 ]]; then
                                                round[$j-1]=$((round[$j-1]+1))
                                        else
                                                round[$i-1]=$((round[$i-1]+1))
                                        fi

                                        
                                        break
                                fi
                        done
                        
                done
                rm los${i}.txt
        done

        rm los${lgraczy}.txt

        b=0
        p=0
        indb=0
        indp=0

        for i in ${!round[@]}; do
                if [[ ${round[$i]} -ge $b ]]; then
                        p=$b
                        b=${round[$i]}
                        indp=$indb
                        indb=$i
                fi
        done

        if [[ $b == $p ]]; then
                echo "r" >> gra.log
        elif [[ $b>$p ]]; then
                echo "$(($indb+1))" >> gra.log
        else
                echo "$(($indp+1))" >> gra.log
        fi
        
        rm komenda.txt
	sleep 0.05

done

echo "stop" > komenda.txt

sleep 1

rm komenda.txt

echo -e "\n\n"


cur=0
prev=0
wc=0
wp=0


for (( i=1; i<=$lgraczy; i++ )); do

        wyg=$(cat gra.log | grep $i | wc -l)
        echo "gracz $i wygrał $wyg rund"

        if [[ $wc -le $wyg ]]; then
                prev=$cur
                cur=$i
                wp=$wc
                wc=$wyg
        fi

done

draw=$(cat gra.log | grep r | wc -l)
echo "liczba remisowych rund: $draw"

echo "cur: $cur prev: $prev"
echo "wc: $wc wp: $wp"

if [[ $wc == $wp ]]; then
        echo "Nie było gracza, który wygrał więcej rund od pozostałych"
else
        echo "Gracz $cur wygrał najwięcej rund: $wc i wygrał całą grę"
fi

exit

