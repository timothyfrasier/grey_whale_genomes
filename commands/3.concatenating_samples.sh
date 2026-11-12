#!/bin/bash

##############################
# Commands for concatenating #
# files from each lane into  #
# one file per sample.       #
#----------------------------#
# Script was run from within #
# the "filtered" directory.  #
##############################

#--------------------------#
# Get list of sample names #
#--------------------------#
ls lane1 > samples

#-------------------------------#
# Remove non-needed information #
#-------------------------------#
sed -i '/lane1_read_counts/d' samples   # Remove filename of file containing read counts
sed -i 's/_.*//' samples                # Remove everything from first underscore on

#--------------------------#
#  Loop through samples    #
#--------------------------#
for sample in $(<samples);
do
  for lane in lane1 lane2 lane3 lane4;
  do
  cd $lane;
  echo $lane;
  echo $sample;
  cat ${sample}*.fastq.gz >> ../combined/${sample}_combined.fastq.gz;
  cd ..
 done
done 
