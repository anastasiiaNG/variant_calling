#!/usr/bin/python3.5

import sys
import requests

with open(sys.argv[1]) as vcf, open(sys.argv[2], "w") as ann:
    while True:
        line = next(vcf).strip()
        if not line.startswith("#"):
            break
    url_to_req = 'http://mutationassessor.org/r3/?cm=var&var=hg38,'+",".join((line.split()[0], line.split()[1], line.split()[3], line.split()[4]))+'&frm=txt'
    req = requests.get(url_to_req).text.split()[16:]
    if len(req) > 9:
        for el in req:
            ann.write(el+"\t")
        ann.write("\n")
    for line in vcf:
        line = line.strip()
        url_to_req = 'http://mutationassessor.org/r3/?cm=var&var=hg38,'+",".join((line.split()[0], line.split()[1], line.split()[3], line.split()[4]))+'&frm=txt'
        req = requests.get(url_to_req).text.split()[16:]
        if len(req) > 9:    
            for el in req:
                ann.write(el+"\t")
            ann.write("\n")

