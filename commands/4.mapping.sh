#!/bin/bash

#---------------------------#
# Commands for mapping grey #
# whale reads to the        #
# reference genome.         #
#---------------------------#

for sample in $(<samples);
do
echo $sample
bwa mem -t 50 -M reference/ncbi_dataset/data/GCA_028021215.1/GCA_028021215.1_mEscRob2.pri_genomic.fna filtered/combined/${sample}_combined.fastq.gz > mapped/${sample}.sam;
done

