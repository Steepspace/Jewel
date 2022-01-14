#!/usr/bin/env python3

import requests
import re

r = requests.get('https://lhapdf.hepforge.org/downloads?f=pdfsets//5.9.1')

l = list(set(re.findall(r'<a href="(\?f=pdfsets//5\.9\.1/.+?)"', r.text)))

with open('lhapdf_link.txt','w') as f:
    for s in l:
        link = 'https://lhapdf.hepforge.org/downloads'+s
        f.write(link+'\n')
