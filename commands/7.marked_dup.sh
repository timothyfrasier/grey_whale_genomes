#! /bin/bash


#-----------------------------#
# Commands for running Marked #
# duplicates through Picard   #
#-----------------------------#

#-----------------------------------------------#
# -I flag: followed by input file name          #
# -O flag: followed by name of output file      #
# -M flag: followed by name of the file for     #
# storing summary infromation about the process #
#-----------------------------------------------#


for sample in $(<samples);

do

echo ${sample}

java -jar /usr/local/bin/picard.jar MarkDuplicates -I ${sample}.bam -O ${sample}_marked_duplicates.bam -M ${sample}_marked_dup_metrics.txt;

done

