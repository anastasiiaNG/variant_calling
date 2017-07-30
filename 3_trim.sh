#!/bin/bash
echo "Type the names of your samples (argument 1 and argument 2)"

samplename=$1

if [[ -z $1 ]]; then
echo "First argument is empty! Type sample name"
exit
fi

trimmomatic PE ${samplename}_L001_R1_001.fastq ${samplename}_L001_R2_001.fastq ${samplename}1_paired.fastq ${samplename}1_unpaired.fastq ${samplename}2_paired.fastq ${samplename}2_unpaired.fastq HEADCROP:15







#java -jar /home/ubuntu/PetrKozyrev/test_run/tools/trim/Trimmomatic-0.36/trimmomatic-0.36.jar PE ${samplename}1_001.fastq ${samplename}2_001.fastq ${samplename}1_paired.fastq ${samplename}1_unpaired.fastq ${samplename}2_paired.fastq ${samplename}2_unpaired.fastq HEADCROP:15

#rm *unpaired.fastq
#rm ${samplename}1_001.fastq
#rm ${samplename}2_001.fastq
#mv *paired.fastq $dir 
