#!/bin/bash

if [[ -z $1 ]]; then
echo "First argument is empty! Type sample name"
exit
fi

samplename=$1

samtools view -@ 2 -Sb "$samplename"_b37.sam > "$samplename"_b37.bam  
samtools sort -@ 2 "$samplename"_b37.bam -o sorted_"$samplename"_b37.bam 

samtools view -@ 2 -Sb "$samplename"_hg38.sam > "$samplename"_hg38.bam
samtools sort -@ 2 "$samplename"_hg38.bam -o sorted_"$samplename"_hg38.bam
