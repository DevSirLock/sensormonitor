#!/bin/bash

digits=12 
a=$(date +%s)
b=$((a*RANDOM))

while [ ${#b} -lt 12 ]; do

    b="${b}$RANDOM"

done



echo "${b:0:digits}"
