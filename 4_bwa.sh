#!/bin/bash

if [[ -z $1 ]];then
echo "First argument is empty! Type read name"
exit
fi

samplename=$1

index=$ngsref/b37/b37.fa
bwa mem $index "${samplename}"1* "${samplename}"2* > "${samplename}"_b37.sam

index=$ngsref/hg38/hg38.fa
bwa mem $index "${samplename}"1* "${samplename}"2* > "${samplename}"_hg38.sam




