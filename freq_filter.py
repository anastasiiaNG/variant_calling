#!/usr/bin/python3

import re
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--vcf', type=argparse.FileType('r'), help='Annotated vcf')
parser.add_argument('--mean', type=argparse.FileType('w'), help='Output vcf with for meaningful variations')
parser.add_argument('--unmn', type=argparse.FileType('w'), help='Output vcf, high frequency')
parser.add_argument('--unkn', type=argparse.FileType('w'), help='Output vcf, unkn')
args = parser.parse_args()

score_patt = re.compile(r'([\d\.]+)[^;]')

def ex_score_find(line):
    if "ExAC_ALL=." in line:
        return 0
    else:
        return float(score_patt.search(line[(line.index("ExAC_ALL=") + len("ExAC_ALL=")):]).group(1))

def polyph_score_find(line):
    if "Polyphen2_HDIV_score=." in line:
        if "Polyphen2_HVAR_score=." in line:
            return (0, 0)
        return (0, float(score_patt.search(line[(line.index("Polyphen2_HVAR_score=") + len("Polyphen2_HVAR_score=")):]).group(0)))
    else:
        if "Polyphen2_HVAR_score=." in line: 
            return (float(score_patt.search(line[(line.index("Polyphen2_HDIV_score=") + len( "Polyphen2_HDIV_score=")):]).group(0)), 0)
        return (float(score_patt.search(line[(line.index("Polyphen2_HDIV_score=") + len("Polyphen2_HDIV_score=")):]).group(0)), float( score_patt.search(line[(line.index("Polyphen2_HVAR_score=") + len( "Polyphen2_HVAR_score=")):]).group(0)))    

while True:
    line = next(args.vcf)
    if not line.startswith("#"):
        break

ex = ex_score_find(line)
if ex:
    if ex < 0.1:
        args.mean.write(line)
    else:
        args.unmn.write(line)
else:
    polyph = polyph_score_find(line)
    if not True in polyph:
        args.unkn.write(line)
    else:
        if True in list(filter(lambda x: x < 0.1, polyph)):
            args.mean.write(line)
        else:
            args.unmn.write(line)

for line in args.vcf:
    ex = ex_score_find(line)
    print(line, ex)
    if ex:
        if ex < 0.1:
            args.mean.write(line)
        else:
            args.unmn.write(line)
    else:
        polyph = polyph_score_find(line)
        if not True in polyph:
            args.unkn.write(line)
        else:
            if True in list(filter(lambda x: x < 0.1, polyph)):
                args.mean.write(line)
            else:
                args.unmn.write(line)
