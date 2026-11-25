#!/bin/bash

#-------------------------#
# Commands for converting #
# SAM files to BAM files  #
#-------------------------#


for sample in $(<samples);                 # For every sample
do                   
echo ${sample}                             # Prints the sample name to the file 
samtools view -b ${sample}.sam |           # Converts SAM file format to BAM file format 
samtools sort --threads 30 > $sample.bam;  # Sort the BAM alignment using 30 threads and saves sorted output as .bam
done
