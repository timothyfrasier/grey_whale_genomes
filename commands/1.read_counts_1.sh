#!/bin/bash

######################################################
# Commands for getting read counts for raw sequences #
# straight from the sequencing facility (McGill).    #
# Samples were spread across four lanes. The         #
# directories for these lanes were labeled as        #
# Unaligned.1, Unaligned.2, Unaligned.3, and         #
# Unaligned.4. The file structure within each was    #
# the same:                                          #
#                                                    #
# |-- Unaligned.1                                    #
#     |-- Project_423                                #
#         |-- Sample1                                #
#         |-- Sample2                                #
#         |-- etc...                                 #
#                                                    #
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
# run bioawk on remaining files to   #
# get read counts.                   #
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
for read in $(<names);      # For each file name remaining
do
bioawk -c fastx 'END{print NR}' $read >> ../../raw_read_counts;  # Run bioawk to get read counts
done
cd ..;                      # Go back up one directory
done

