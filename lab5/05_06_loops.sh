#!/bin/bash


echo $(ls -l | grep '^l' | cut -d' ' -f11,13 | tr ' ' '\n' > output.txt)


file="output.txt"

declare -A myArray

i=0
j=0
counter=0
loop_len=1
oper1=0 

while read -r line; do	
    myArray[$i,$j]=$line
    i=$(( $j + $i ))
    j=$(( ($j+1) % 2 ))
    
done < output.txt


for (( k=0; k<$i; k++ )) do
	end=${myArray[$k,0]}
	to_find=${myArray[$k,1]}
	oper1=0
	loop_len=1

	for (( m=0; m<$i; m++ )) do
		
	        for (( n=0; n<$i; n++ )) do
			if [[ ${myArray[$n,0]} == $to_find  ]]; then

				if [[ ${myArray[$n,1]} == $end ]]; then
					loop_len=$(( $loop_len + 1  ))
					echo -e "Istnieje pętla: ${myArray[$k,0]}->${myArray[$k,1]}\nJej długość to: $loop_len"
					counter=$(( $counter + 1 ))
					loop_len=1					
					oper1=1
					break
				elif [[ $n -le $(( $i - 1 ))  ]]; then
					to_find=${myArray[$n,1]}
      		                       	loop_len=$(( $loop_len + 1 ))
					break
				fi
			fi

			if [[ $n == $(( $i - 1 )) ]]; then
                                oper1=1
                                break
                        fi
	        done

		if [[ $oper1 == 1 ]]; then
		       break
		fi	       
					
	done

done	


echo -e "\nWszystkich pętli jest: $counter"
