#!/bin/bash

#################################################################
# Commands for filtering data based on quality, and for merging #
# paired reads. Arguments for Fastp below.                      #
#                                                               #
# --in1 : Input file for read 1                                 #
# --in2 : Input file for read 2                                 #
# -q 20 : Minimum quality value of a base, anything below is    #
# discarded                                                     #
# -u 15 : Percentage of bases allowed to be 'unqualified'       #
# before read is discarded                                      #
# -e 30 : Minimum average read quality before read is discarded #
# -l 50 : Minimum requiered read length                         #
# --detect_adapter_for_pe : Detects adapters for paired end     #
# sequences                                                     #
# --cut_front : Sliding window from 5' end, removes bases if    #
# mean quality is below --cut_front_mean_quality                #
# --cut_front_window_size 5 : Sets window size for --cut_front  #
# --cut_front_mean_quality 30 : Set mean quality threshold      #
# All --cut_tail arguments preform the same function as thier   #
# --cut_front counterparts, but from the 3' direction           #
# --correction : Enables correction of mismatched bases in      #
# pair-read sequences                                           #
# --merge : Stitches paired-end input                           #
# --merged_out : The output file for merged reads               #
# --thread 5 : How many threads to use                          #
#################################################################
# Created a directory called 'filtered' where reads were placed #
# to. After running commands for one lane, moved the merged     #
# files into a lane-spesific directory.                         #
#################################################################
# This script was run 4 times, once from within each            #
# Unaligned.X directory. Change lane number in script           #
# according to lane directory you are in                        #
#################################################################


cd Project_423 #go to project directory


ls > samples #Save list of file names to file called samples


sed -i '/samples/d' samples #Remove row in file called samples


for file in $(<samples) 


do #Remove the files that the Fastp filtering will not be run on


cd $file #list files in that directory

ls > names
sed -i '/.md5/d' names; #Removes the names of any file ending in .md5
sed -i '/I1/d' names; #Removes names of the first index file
sed -i '/I2/d' names; #Removes names of second Index file
sed -i '/fastp/d' names; #Removes names of fastp files
sed -i '/names/d' names; #Removes "names" from files
sed -i '/R2/d' names; #Removes the R2 file
sed -i 's/_R1_001.fastq.gz//g' names

for read in $(<names); #For the files that are left in the names file

do #Fastp filters


fastp --in1 ${read}_R1_001.fastq.gz --in2 ${read}_R2_001.fastq.gz -q 20 -u 15 -e 30 -l 50 --detect_adapter_for_pe --cut_front --cut_front_window_size 5 --cut_front_mean_quality 30 --cut_tail --cut_tail_window_size 5 --cut_tail_mean_quality 30 --correction --merge --merged_out ../../../../filtered/lane3/${read}_merged.fastq.gz --thread 5

done 

cd ..;

done



























 