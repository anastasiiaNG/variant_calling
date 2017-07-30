#!/bin/bash

if [[ -z $1 ]]; then
echo "First argument is empty! Type the name of the bam file"
exit
fi

samplename=$1
ref="b37"

gatk -T BaseRecalibrator -R ~/ngs/references/$ref/$ref.fa -I grouped_"$samplename"_b37.bam -knownSites /home/ubuntu/ngs/tools/gatk_"$ref"_bundle/dbsnp_138."$ref".vcf -knownSites ~/ngs/tools/gatk_"$ref"_bundle/Mills_and_1000G_gold_standard.indels."$ref".vcf -o recal_data_"$samplename"_b37.table -U ALLOW_SEQ_DICT_INCOMPATIBILITY
gatk -T BaseRecalibrator -R ~/ngs/references/$ref/$ref.fa -I grouped_"$samplename"_b37.bam -knownSites /home/ubuntu/ngs/tools/gatk_"$ref"_bundle/dbsnp_138."$ref".vcf  -knownSites ~/ngs/tools/gatk_"$ref"_bundle/Mills_and_1000G_gold_standard.indels."$ref".vcf -BQSR recal_data_"$samplename"_b37.table -o post_recal_data_"$samplename"_b37.table -U ALLOW_SEQ_DICT_INCOMPATIBILITY
gatk -T AnalyzeCovariates -R ~/ngs/references/$ref/$ref.fa -before recal_data_"$samplename"_b37.table -after post_recal_data_"$samplename"_b37.table -plots recalibration_plots_b37.pdf  
gatk -T PrintReads -R ~/ngs/references/$ref/$ref.fa -I grouped_"$samplename"_b37.bam -BQSR recal_data_"$samplename"_b37.table -o recal_reads_"$samplename"_b37.bam -U ALLOW_SEQ_DICT_INCOMPATIBILITY
gatk -T HaplotypeCaller -R ~/ngs/references/$ref/$ref.fa -I recal_reads_"$samplename"_b37.bam --genotyping_mode DISCOVERY -o "$samplename"_b37.vcf -U ALLOW_SEQ_DICT_INCOMPATIBILITY


ref="hg38"

gatk -T BaseRecalibrator -R ~/ngs/references/$ref/$ref.fa -I grouped_"$samplename"_hg38.bam -knownSites /home/ubuntu/ngs/tools/gatk_"$ref"_bundle/dbsnp_138."$ref".vcf -knownSites ~/ngs/tools/gatk_"$ref"_bundle/Mills_and_1000G_gold_standard.indels."$ref".vcf -o recal_data_"$samplename"_hg38.table -U ALLOW_SEQ_DICT_INCOMPATIBILITY
gatk -T BaseRecalibrator -R ~/ngs/references/$ref/$ref.fa -I grouped_"$samplename"_hg38.bam -knownSites /home/ubuntu/ngs/tools/gatk_"$ref"_bundle/dbsnp_138."$ref".vcf  -knownSites ~/ngs/tools/gatk_"$ref"_bundle/Mills_and_1000G_gold_standard.indels."$ref".vcf -BQSR recal_data_"$samplename"_hg38.table -o post_recal_data_"$samplename"_hg38.table -U ALLOW_SEQ_DICT_INCOMPATIBILITY
gatk -T AnalyzeCovariates -R ~/ngs/references/$ref/$ref.fa -before recal_data_"$samplename"_hg38.table -after post_recal_data_"$samplename"_hg38.table -plots recalibration_plots_hg38.pdf
gatk -T PrintReads -R ~/ngs/references/$ref/$ref.fa -I grouped_"$samplename"_hg38.bam -BQSR recal_data_"$samplename"_hg38.table -o recal_reads_"$samplename"_hg38.bam -U ALLOW_SEQ_DICT_INCOMPATIBILITY
gatk -T HaplotypeCaller -R ~/ngs/references/$ref/$ref.fa -I recal_reads_"$samplename"_hg38.bam --genotyping_mode DISCOVERY -o "$samplename"_hg38.vcf -U ALLOW_SEQ_DICT_INCOMPATIBILITY


rm *.sam 
rm *.bam
