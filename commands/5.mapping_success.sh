#!/bin/bash

#------------------------#
# Commands for checking  #
# how well reads mapped  #
# to reference genome.   #
#------------------------#

for file in $(<samples);
do
echo ${file};
samtools flagstat ${file}.sam >> mapping_results;
done

