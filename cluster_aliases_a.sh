

alias cd.='cd .. # '  # I often type 'cd. .' instead of 'cd ..'. This will fix this


#Function and alias for looping over all directories within current directory.
#The variable $d can be used to reference the current subdirectory in the loop.
#
#   Usage:     foralldirs <do something>; done
#
#   Example:   foralldirs cd $d; touch file.txt; cd ..; done
#      will create an empty file called file.txt in every subdirectory.
function alldirs () { 
   \ls -d */ | sed 's|\/||g'
}
alias foralldirs='for d in $(alldirs); do'




function qsubwrap() {
#!/bin/bash



if [[ "x$(   hostname | grep -o '[a-zA-Z]*-' )" == "xbgqdev-" ]]; then
   if [[ ! "x$1" == "x" ]]; then
      if [[ -a "$1" ]]; then
         sed "s|!!!basename!!!|$(basename $PWD)|g" $1 > "${1}.tmp"
         sed -i "s|!!!basename..!!!|$(basename $(sed "s|$( basename $PWD )||" <<< $PWD ))|g" "${1}.tmp"
         llsubmit "${1}.tmp"
         rm "${1}.tmp" 2>/dev/null
      else
         echo "File $1 doesn't exist!"
      fi
   else
      echo "You must specify the submit script!" 
   fi


elif [[ "x$( hostname )" == "xbugaboo.westgrid.ca" ]]; then
   if [[ ! "x$1" == "x" ]]; then
      if [[ -a "$1" ]]; then
         sed "s|!!!basename!!!|$(basename $PWD)|g" $1 > "${1}.tmp"
         qsub "${1}.tmp"
         rm "${1}.tmp" 2>/dev/null
      else
         echo "File $1 doesn't exist!"
      fi
   else
      echo "You must specify the submit script!" 
   fi

else
  echo "This script can only be run on specific clusters.  The current hostname  [$(hostname)] is not compatible.  add it to \$WORKSCRIPTS/cluster_aliases_a.sh in the qsubwrap() function."
fi

}



function column() {
  awk '{print $'$1'}'
}




