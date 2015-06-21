#!/bin/bash

function vaspruntime () { 
   
   echo $(( ( $(date -ud "$(head -n 1 time.dat)" +'%s') - $(date -ud "$(tail -1 time.dat)" +'%s') ) ))
   
     } 

function HOMOLUMO() {

pcregrep -M '2\.00000.*(\n)*.*2\.00000.*(\n)*.*0\.00000.*(\n)*.*0\.00000' OUTCAR | tail -4 | head -3 | tail -2 | awk '{print $2}'

}




function energy_per_atom() {
        atoms=$(awk 'NR==7 {for(i=1;i<=NF;i++) t+=$i; print t; t=0}' POSCAR)
        energy=$(grep TOTEN OUTCAR | tail -n 1 | awk '{print $5 }')
        echo -e "TOTEN  \t NATOMS "
        echo -e "$energy \t $atoms "
}






