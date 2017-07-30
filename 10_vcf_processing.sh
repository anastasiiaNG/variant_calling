#!/bin/bash

samplename=$1
ref="hg19"

python3 freq_filter.py --vcf "$samplename"."$ref"_multianno.vcf --mean "$samplename"_mean_b37.vcf --unmn "$samplename"_unmean_b37.vcf --unkn "$samplename"_unkn_b37.vcf
python3 harm_filter.py --mean "$samplename"_mean_b37.vcf --unmn "$samplename"_unmean_b37.vcf --unkn "$samplename"_unkn_b37.vcf --fin "$samplename"_b37.tsv --frequent "$samplename"_unkn_b37.tsv


ref="hg38"
python3 freq_filter.py --vcf "$samplename"."$ref"_multianno.vcf --mean "$samplename"_mean_hg38.vcf --unmn "$samplename"_unmean_hg38.vcf --unkn "$samplename"_unkn_hg38.vcf
python3 harm_filter.py --mean "$samplename"_mean_hg38.vcf --unmn "$samplename"_unmean_hg38.vcf --unkn "$samplename"_unkn_hg38.vcf --fin "$samplename"_hg38.tsv --frequent "$samplename"_unkn_hg38.tsv




