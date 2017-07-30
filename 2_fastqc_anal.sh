#!/bin/bash
if [[ -z $1 ]]; then
echo "Type path to the directory with fastq files to analyze"
exit
fi

fastqc_path=$1
mkdir $fastqc_path/fastqc_results
fastqc_results=$fastqc_path/fastqc_results

for file in `ls $fastqc_path*.fastq` 
do
fastqc -o $fastqc_results $file
done
