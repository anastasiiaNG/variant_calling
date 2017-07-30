#!/bin/bash

if [[ -z $1 ]]; then
echo "First argument is empty! Type the name of the vcf file"
exit
fi

samplename=$1

annovar "$samplename"_ann_b37.vcf  $ngstools/annovar/humandb/ -buildver hg19 -out "$samplename" -remove -protocol refGene,cytoBand,genomicSuperDups,esp6500siv2_all,1000g2015aug_all,1000g2015aug_eur,exac03,avsnp147,dbnsfp30a -operation g,r,r,f,f,f,f,f,f -nastring . -vcfinput


annovar "$samplename"_ann_b37.vcf  $ngstools/annovar/humandb/ -buildver hg38 -out "$samplename" -remove -protocol refGene,cytoBand,genomicSuperDups,esp6500siv2_all,1000g2015aug_all,1000g2015aug_eur,exac03,avsnp147,dbnsfp30a -operation g,r,r,f,f,f,f,f,f -nastring . -vcfinput

#perl ~/ngs/tools/annovar/table_annovar.pl "$samplename"_ann.vcf  $ngstools/annovar/humandb/ -buildver $ref_name -out $samplename -remove -protocol refGene,cytoBand,genomicSuperDups,esp6500siv2_all,1000g2015aug_all,1000g2015aug_eur,exac03,avsnp147,dbnsfp30a -operation g,r,r,f,f,f,f,f,f -nastring . -vcfinput


