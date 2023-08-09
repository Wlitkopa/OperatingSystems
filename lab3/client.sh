#!/bin/bash

if [[ $# != 1 ]]; then
	echo "Podaj numer klienta"
fi

path=$(echo $(pwd))
echo "path: $path"


pipes=$(ls -l $path/pipes | grep pipe | wc -l)

nrcl=$1


if [[ -f "/home/przemek/sysop/lab3/pipes/usr" ]]; then
	last_user=$(cat $path/pipes/usr | cut -f 1 -d":")
	gtus=$(cat $path/pipes/usr | cut -f 2 -d":")
else
	last_user=0
	gtus=0
fi
echo -e "========================\nLast logged user: $last_user"

#echo "Greatest user before first comparison: $gtus"

if [[ $gtus -le $nrcl ]]; then
	gtus=$nrcl
else
	gtus=$last_user
fi


if [[ -p "/home/przemek/sysop/lab3/pipes/pipe${nrcl}" ]]; then
	echo "This user exists"
	exit
else
	echo "$nrcl:$gtus" > $path/pipes/usr
fi
echo "Current client (user): $nrcl"


pipe_path_write=$path/pipes/
pipe_path_read=$path/pipes/pipe${nrcl}

#echo "pipe_path_read: $pipe_path_read"

if [[ -p "$pipe_path_read" ]]; then
	echo "file $pipe_path_read exists"
	echo "Serious ERROR"
	exit
else
	mkfifo $pipe_path_read
fi


while true;

do	
#	echo "pipe_path_read: $pipe_path_read"
	if [[ -p "$pipe_path_read" ]]; then
        	cat $pipe_path_read
#		echo "Działa ten while"
	else
		echo "leaving this while"
		break
	fi
done &


echo -e "========================\n\n ~~ type '--exit' to leave the chat ~~\n\nChat:\n"
while true;
do	
	read message;
	if [[ $message == "--exit" ]]; then
		rm $pipe_path_read
		pipes=$(ls -l $path/pipes | grep pipe | wc -l)
	        if [[ $pipes == 1 ]]; then
        	        rm $path/pipes/usr
		fi
		exit
        fi

	pipes=$(ls -l $path/pipes | grep pipe | wc -l)
	gtus=$(cat $path/pipes/usr | cut -f 2 -d":")


#	if [[ $pipes == 1 ]]; then
#		rm /home/przemek/sysop/lab3/pipes/usr
#		exit
#	fi
	
#	echo "Greatest user before pipe comparison: $gtus"

	
	if [[ $pipes -le $gtus ]]; then
	#	echo -e "pipes: $pipes\ngtus: $gtus\n"
		pipes=$gtus
	fi

#	echo "Greatest user after pipe comparison: $gtus\nPipes after comparison: $pipes"

	for (( i=1; i<$(($pipes + 1)); i++ )); do
		pipe_to_write=$pipe_path_write/pipe${i}
#		echo "pipe_to_write: $pipe_to_write"
		if [ -p "$pipe_to_write" ] && [ $i != $nrcl ]; then
       			echo "Client $nrcl: $message" > $pipe_to_write
		fi
		
	done
done

