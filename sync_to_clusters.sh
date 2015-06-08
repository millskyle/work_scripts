#!/bin/bash

destinations="orca:/home/kmills/work/bin "

for dest in $destinations; do

   rsync -av ../work_scripts "$dest"

done





