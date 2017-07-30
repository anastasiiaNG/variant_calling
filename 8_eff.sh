#!/bin/bash
samplename=$1
ref_name=$2

if [[ -z $1 ]]
then 
echo "Type vcf name"
exit
fi

ref="hg19"
snpeff ann $ref  "$samplename"_b37.vcf > "$samplename"_ann_b37.vcf

ref="hg38"
snpeff ann $ref  "$samplename"_hg38.vcf > "$samplename"_ann_hg38.vcf

