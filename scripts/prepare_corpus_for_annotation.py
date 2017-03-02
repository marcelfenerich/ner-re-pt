#!/usr/bin/python3

import sys, os
import csv, string
import langdetect

sys.path.extend(['.', '..'])
from util.web import html_to_text

if len(sys.argv) < 4:
    print("Usage: %s CORPUSCSV BRATDIR LIMIT" % sys.argv[0])
    sys.exit(1)

corpus_filename = sys.argv[1]
brat_data_dirname = sys.argv[2]
limit = int(sys.argv[3])

with open(corpus_filename, 'r') as csv_file:
    csv_reader = csv.DictReader(csv_file, delimiter = ',')
    count = 0
    for row in csv_reader:
        text = html_to_text(row['content'])
        try:
            if langdetect.detect(text) != 'pt':
                print("===> Not portuguese, skipping %s" % row['id'])
                continue
        except:
            print("===> langdetect error, skipping %s" % row['id'])

        basename = os.path.join(brat_data_dirname, row['id'])
        open('%s.ann' % basename, 'w').close()

        with open('%s.txt' % basename, 'w') as f:
            f.write("%s\n" % row['title'])
            f.write("%s\n" % row['subtitle'])
            f.write(html_to_text(row['content']))

        count += 1
        if count >= limit: break
