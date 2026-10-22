#!/bin/bash

######################################################
# Commands for using fastp to filter the data based  #
# on quality and also merge the paired reads. The    #
# arguments used for fastp are as follows:           #
#                                                    #
#    --in1 - Input file for read 1                   #
#    --in2 - Input file for read 2                   #
#    -q 20 - The quality value at which a base is    #
#            "qualified" and therefore kept.         #
#    -u 15 - How many percent of bases are allowed   #
#            to be "unqualified" before a read is    #
#            discarded.                              #
#    -e 30 - If one read's average quality score is  #
#            < 30 then read is discarded.            #
#    -l 50 - Minimum length of read allowed          #
#    --detect_adapter_for_pe - Atuo detect adapters  #
#            for paired-end reads.                   #
#    --correction - Enables correction of mismatched #
#            bases in paired-read data.              #
#    --thread 10 - How many threads to use.          #
#    --merged_out - The output file for merged reads #
#                                                    #
#----------------------------------------------------#
# Manually created a "filtered" directory that       #
# reads were placed into. After running commands for #
# one lane, moved the merged files into a lane-      #
# specific directory.                                #
#----------------------------------------------------#
#  Ran this script 4 times: once from within each of #
#  of the Unaligned.x directories.                   #
######################################################

#------------------------------------#
# Go into the Project_423 directory  #
#------------------------------------#
cd Project_423

#------------------------------------#
# Create a file of all the           #
# directories, which are also each   #
# of the samples.                    #
#------------------------------------#
ls > samples

#------------------------------------#
# This file also contains a row that #
# says "samples", so removed that.   #
#------------------------------------#
sed -i '/samples/d' samples

#------------------------------------#
# Then made a series of two loops.   #
# Loop through the directory for     #
# each sample, create a new file     #
# with the names of the files in that#
# directory, remove the names that   #
# we don't need for counting reads,  #
# run fastp on the remaining samples #
#------------------------------------#
for file in $(<samples);    # For every sample 
do
cd $file;                   # Go into its directory
ls > names;                 # Make a list of files in that directory
sed -i '/.md5/d' names;     # Remove the names of the md5 files
sed -i '/_I1_/d' names;     # Remove the names of the first index file
sed -i '/_I2_/d' names;     # Remove the names of the second index file
sed -i '/fastp/d' names;    # Remove the name of the fastp directory
sed -i '/names/d' names;    # Remove the word "names" from file
sed -i '/_R2_/d' names;     # Remove the Read 2 file
sed -i 's/_R1_001.fastq.gz//g' names # Remove the trailing end of file name
for read in $(<names);      # For each file name remaining
do
fastp --in1 ${read}_R1_001.fastq.gz --in2 ${read}_R2_001.fastq.gz -q 20 -u 15 -e 30 -l 50 --detect_adapter_for_pe --correction --thread 10 --merged_out ../../../../filtered/${read}_merged.fastq.gz;  done
cd ..;                      # Go back up one directory
done

