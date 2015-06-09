#!/bin/bash

function vaspcp() {
rsync -av --exclude=WAVECAR --exclude=CHG* --exclude=LOCPOT $1/ $2
}


function check() {
[[ $( grep accuracy OUTCAR 2>/dev/null ) ]] && echo "$(tput setaf 2; tput bold)Accuracy reached$(tput sgr0) " || echo $(tput setaf 1)$(grep pressure OUTCAR 2>/dev/null | wc -l ) steps completed.  Sufficient accuracy not reached.$(tput sgr0)

}

function recursivecheck () {

   temp=$(pwd)
   for i in $(find . -type d ); do
      cd $i
      if [[ $( ls -d */ 2>/dev/null | wc -l ) == '0' ]]; then #if this dir doesn't contain any more directories
         if [[ "x$(ls -d ../part* 2>/dev/null | sed 's|../||g' | sort -r | head -1 )x" == "x$(basename $(pwd))x" ]] || [[ ! -d ../part01 ]] ; then
                 echo $i
                 echo -ne "\t"
                 if [[ $( grep accuracy OUTCAR 2>/dev/null ) ]]; then 
                    echo "$(tput setaf 2; tput bold)Accuracy reached$(tput sgr0) " 
                 else
                    echo $(tput setaf 1)$(grep pressure OUTCAR 2>/dev/null | wc -l )" steps completed.  Sufficient accuracy not reached.$(tput sgr0) "
                 fi
              fi
        fi
         cd $temp ; done


}

