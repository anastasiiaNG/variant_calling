#!/bin/bash

if [[ -z $1 ]] 
then
echo "The first argument is empty! Type the path to directory with input data (in .gz format)"
exit
fi

gunzip_path=$1
for file in `ls $gunzip_path*.gz` 
do
gunzip  $file 
done










