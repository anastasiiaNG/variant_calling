#!/bin/bash

if [[ -z $1 ]]; then
echo "First argument is empty! Type the name of the bam file"
exit
fi

samplename=$1

picard MarkDuplicates I=sorted_"$samplename"_b37.bam O=marked_"$samplename"_b37.bam M=marked_dup_"$samplename"_b37.txt 
picard AddOrReplaceReadGroups I=marked_"$samplename"_b37.bam O=grouped_"$samplename"_b37.bam RGID=4 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=20 
picard BuildBamIndex I=grouped_"$samplename"_b37.bam


picard MarkDuplicates I=sorted_"$samplename"hg38.bam O=marked_"$samplename"_hg38.bam M=marked_dup_"$samplename"_hg38.txt 
picard AddOrReplaceReadGroups I=marked_"$samplename"_hg38.bam O=grouped_"$samplename"_hg38.bam RGID=4 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=20
picard BuildBamIndex I=grouped_"$samplename"_hg38.bam

