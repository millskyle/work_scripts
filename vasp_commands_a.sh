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


function remoteposcar()
{
   thisdir="$PWD"
   if [[ "x$1" == "x" ]] || [[ "x$2" == "x" ]] ; then
      echo -e "Two arguments required:\
                     remoteposcar hostname directory-containing-vasprun \
            \n\n\t e.g.: remotevasprun orcinus /home/kmills/alcomp/Naphthalene/6-6/TUBE_iso\
            \n"
   else
      if [[ "x$3" == "xCONTCAR" ]]; then
         ffile=CONTCAR
      else
         ffile=POSCAR
      fi
      cd /tmp
      scp -r $1:$2/$ffile /tmp/POSCAR
      vmdPOSCAR /tmp/POSCAR 
   fi
   cd $thisdir
}


function remotevasprun()
{
   if [[ "x$1" == "x" ]] || [[ "x$2" == "x" ]] ; then
      echo -e "Two arguments required:\
                     remotevasprun hostname directory-containing-vasprun \
            \n\n\t e.g.: remotevasprun orcinus /home/kmills/alcomp/Naphthalene/6-6/TUBE_iso\
            \n"
   else
      scp -r $1:$2/vasprun.xml /tmp
      vmd /tmp/vasprun.xml > /dev/null 
   fi
}





