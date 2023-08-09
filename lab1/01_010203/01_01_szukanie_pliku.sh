#!/bin/bash


echo `find $1 -type f -size +$2c -print0 | xargs -0 ls -alt | head -1`

echo "Ścieżka: $1"
