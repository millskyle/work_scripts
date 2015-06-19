

alias cd.='cd .. # '  # I often type 'cd. .' instead of 'cd ..'. This will fix this



function qsubwrap() {
#!/bin/bash



if [[ "x$(   hostname | grep -o '[a-zA-Z]*-' )" == "xbgqdev-" ]]; then
   if [[ ! "x$1" == "x" ]]; then
      if [[ -a "$1" ]]; then
         sed "s|!!!basename!!!|$(basename $PWD)|g" $1 > "${1}.tmp"
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





