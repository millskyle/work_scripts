#!/bin/bash

destinations="orca:/home/kmills/work/bin bgq:/home/i/itamblyn/kmills/bin orcinus:/home/kmills/bin"

for dest in $destinations; do

   rsync -av ../work_scripts "$dest"

done





