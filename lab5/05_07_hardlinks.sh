#!/bin/bash

if [[ $# != 1 ]]; then
        echo "Podaj jeden argument"
        exit
elif [[ ! -d $1 ]]; then
        echo "Nie istnieje podany katalog"
        exit
fi

find $1 -type f | xargs stat losowy.dat --printf='%n   %h\n' | awk '{if($2 != 1) print $1"   "$2}'

