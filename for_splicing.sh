#!/bin/bash

samplename=$1

python3 ~/ngs/scripts/extract_region_ref.py "$samplename"_splice.vcf  "$samplename"_splice_ref.bed
bedtools getfasta -fi ~/ngs/references/b37/b37.fa  -bed "$samplename"_splice_ref.bed -s  > "$samplename"_splice_ref.fasta
python3 ~/ngs/scripts/create_mutated.py "$samplename"_splice_ref.fasta "$samplename"_splice.vcf "$samplename"_splice_mut.fasta
