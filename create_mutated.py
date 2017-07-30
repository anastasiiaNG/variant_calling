#!/usr/bin/python3

import sys
#sys.argv[1] -- input with reference seqs 
#sys.argv[2] -- input with vcf
#sys.argv[3] -- output with mutated regions

rev_compl = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G', 'a': 't', 't': 'a', 'c': 'g', 'g': 'c', 'N': 'N', 'n': 'n'}
to_replace = []
with open(sys.argv[1]) as fas, open(sys.argv[2]) as vcf, open(sys.argv[3], "w") as out:
     for line in vcf:
         line = line.strip().split()
         to_replace.append((line[3], line[4]))

     for line in fas:
         name = line
         line = list(next(fas).strip())
         to_del = len(to_replace[0][0])
         to_ins = len(to_replace[0][1].split(','))
         rev_name = next(fas)
         for i in range(to_ins):
             out.write(name)
             new_line = line[:20] + list(to_replace[0][1].split(',')[i]) + line[(20+to_del):]
             new_line_rev = [rev_compl[x] for x in new_line]
             out.write("".join(new_line))
             out.write("\n")
             out.write(rev_name)
             out.write("".join(new_line_rev))
             out.write("\n")
         next(fas)
         to_replace.pop(0)

