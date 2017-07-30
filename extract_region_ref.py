#!/usr/bin/python3

import sys 

#sys.argv[1] -- splice vcf file
#sys.argv[2] -- output bed file

with open(sys.argv[1]) as vcf, open(sys.argv[2], "w") as bed:
    for line in vcf:
        line = line.strip().split()
        bed_position = int(line[1]) - 1
        bed.write("%s\t%d\t%d\t%s_%d_forward\t1\t+\n" % (line[0], bed_position - 20, bed_position + 20, line[0], bed_position))
        bed.write("%s\t%d\t%d\t%s_%d_reverse\t1\t-\n" % (line[0], bed_position - 20, bed_position + 20, line[0], bed_position))
