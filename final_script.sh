#!/bin/bash

samplename=$1
bash ../bash_scripts/3_trim.sh $samplename
bash ../bash_scripts/4_bowtie.sh $samplename
bash ../bash_scripts/5_samtools.sh $samplename
bash ../bash_scripts/6_picard.sh $samplename
bash ../bash_scripts/7_gatk.sh $samplename
bash ../bash_scripts/8_snpeff.sh $samplename
bash ../bash_scripts/9_annovar.sh $samplename
bash ../bash_scripts/10_vcf_processing.sh $samplename
