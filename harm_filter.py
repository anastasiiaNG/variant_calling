#!/usr/bin/python3

import sys 
import argparse
import re

score_patt = re.compile(r'([\d\.]+)[^;]')


parser = argparse.ArgumentParser()
parser.add_argument('--mean', type=argparse.FileType('r'), help='Annotated vcf with meaningful variants')
parser.add_argument('--unmn', type=argparse.FileType('r'), help='Annotated vcf with frequent variants')
parser.add_argument('--unkn', type=argparse.FileType('r'), help='Annotated vcf with unknown variants')
parser.add_argument('--fin', type=argparse.FileType('w'), help='Output final good tsv')
parser.add_argument('--frequent', type=argparse.FileType('w'), help='Output tsv for variants high frequency')
args = parser.parse_args()


class Variant():
    def __init__(self, line):
        line = line.strip().split()
        self.chr = line[0]
        self.pos = line[1]
        self.ref = line[3]
        self.samp = line[4]
        self.cov = line[5]
        self.rest = line[6:]
        self.name = line[7].split("|")[3]
        self.kind = line[7].split("|")[1]

def filter_imp(line, high, moderate, low, unknown):
    if "HIGH" in line:
        high.append(line)
    elif "MODERATE" in line:
        moderate.append(line)
    elif "LOW" in line:
        low.append(line)
    else:
        unknown.append(line)

def find_kind(var):
    if "nonsense" in var.rest[-3]:
        return "Nonsense"
    if "missense" in var.rest[-3]:
        return "Missense"
    if "splice" in var.rest[-3]:
        return "Splice variant"
    return "Unknown"

def ex_score_find(var):
    line = var.rest[-3]
    if "ExAC_ALL=." in line:
        return 0
    else:
        return float(score_patt.search(line[(line.index("ExAC_ALL=") + len("ExAC_ALL=")):]).group(1))

def polyph_score_find(var):
    line = var.rest[-3]
    if "Polyphen2_HDIV_score=." in line:
        if "Polyphen2_HVAR_score=." in line:
            return (0, 0)
        return (0, float(score_patt.search(line[(line.index("Polyphen2_HVAR_score=") + len("Polyphen2_HVAR_score=")):]).group(0)))
    else:
        if "Polyphen2_HVAR_score=." in line:
            return (float(score_patt.search(line[(line.index("Polyphen2_HDIV_score=") + len( "Polyphen2_HDIV_score=")):]).group(0)), 0)
        return (float(score_patt.search(line[(line.index("Polyphen2_HDIV_score=") + len("Polyphen2_HDIV_score=")):]).group(0)), float( score_patt.search(line[(line.index("Polyphen2_HVAR_score=") + len( "Polyphen2_HVAR_score=")):]).group(0)))

def sift(var):
    line = var.rest[-3]
    if "SIFT_score=." in line:
         return 0
    return float(score_patt.search(line[(line.index("SIFT_score=") + len("SIFT_score=")):]).group(1))


def mut_ass_score(var):
    line = var.rest[-3]
    if "MutationAssessor_score=." in line:
         return 0
    return float(score_patt.search(line[(line.index("MutationAssessor_score=") + len("MutationAssessor_score=")):]).group(1))


def write_tsv(var, harm, mean, outp):
    outp.write("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n" % (var.name, var.kind, var.chr, var.pos, var.ref, var.samp, var.cov, harm, mean, ex_score_find(var), polyph_score_find(var)[0], polyph_score_find(var)[1], sift(var), mut_ass_score(var) ))

def determ_mean(count, mn, unkn, unmn):
    if count < mn:
       return "Low frequency (<10%)"
    if count < unkn:
       return "Unknown"
    if count < unmn:
       return "High frequency (>=10%)"


HIGH = []
MODERATE = []
LOW = []
UNKNOWN = []

for line in args.mean:
    filter_imp(line, HIGH, MODERATE, LOW, UNKNOWN)
quantity_mn = (len(HIGH), len(MODERATE), len(LOW), len(UNKNOWN))

for line in args.unkn:
    filter_imp(line, HIGH, MODERATE, LOW, UNKNOWN)
quantity_unkn = (len(HIGH), len(MODERATE), len(LOW), len(UNKNOWN))

for line in args.unmn:
    filter_imp(line, HIGH, MODERATE, LOW, UNKNOWN)
quantity_unmn = (len(HIGH), len(MODERATE), len(LOW), len(UNKNOWN))

args.fin.write("Gene name\tKind\tCromosome\tPosition\tReference\tSample\tQuality\tAnnovar harm prediction\tFrequency\tExAC\tPolyphen HDIV\tPolyphen HVAR\tSIFT score\tMutation Assessor\n")
count = 0

for el in HIGH:
    meaning = determ_mean(count, quantity_mn[0], quantity_unkn[0], quantity_unmn[0])
    var = Variant(el)
    write_tsv(var, "HIGH", meaning, args.fin)
    count += 1

count = 0
for el in MODERATE:
    meaning = determ_mean(count, quantity_mn[1], quantity_unkn[1], quantity_unmn[1])
    var = Variant(el)
    write_tsv(var, "MODERATE", meaning, args.fin)
    count += 1

count = 0
for el in LOW:
    meaning = determ_mean(count, quantity_mn[2], quantity_unkn[2], quantity_unmn[2])
    var = Variant(el)
    write_tsv(var, "LOW", meaning, args.fin)
    count += 1


args.frequent.write("Gene name\tKind\tCromosome\tPosition\tReference\tSample\tQuality\tAnnovar harm prediction\tFrequency\tExAC\tPolyphen HDIV\tPolyphen HVAR\tSIFT score\tMutation Assessor\n")
count = 0
for el in UNKNOWN:
    meaning = determ_mean(count, quantity_mn[3], quantity_unkn[3], quantity_unmn[3])
    var = Variant(el)
    write_tsv(var, "UNKNOWN", meaning, args.frequent)
    count += 1
             

