

alias cd.='cd .. # '  # I often type 'cd. .' instead of 'cd ..'. This will fix this



function qsubwrap() {
#!/bin/bash

inputFile="$1"
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
else
  echo "This script can only be run on Blue Gene Q (bgqdev)"
fi

}





