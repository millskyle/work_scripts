#!/bin/bash 

for i in $(\ls $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/*_a.sh); do 
   source $i
done






