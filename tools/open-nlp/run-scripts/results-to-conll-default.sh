#!/bin/bash

SCRIPT="../src/tokenize_from_opennlp_format.py"
for r in {0..3}
do
	printf "\n** repeat "$r" **\n"
	
	for i in {0..9}
	do
		TRAIN=../train/results/repeat-$r/fold-$i
		OUTR=../outputs/repeat-$r/ner-results/fold-$i
		OUT=../outputs/repeat-$r/fold-$i
		printf "\n** fold "$i" **\n"
		
		python $SCRIPT $TRAIN"/out-cat.txt" $OUTR"/out-cat.txt" "UTF-8"
		python $SCRIPT $TRAIN"/out-types.txt" $OUTR"/out-types.txt" "UTF-8"
		python $SCRIPT $TRAIN"/out-subtypes.txt" $OUTR"/out-subtypes.txt" "UTF-8"
		python $SCRIPT $TRAIN"/out-filtered.txt" $OUTR"/out-filtered.txt" "UTF-8"

		python $SCRIPT $OUT"/cat_test_sent_doc.xml" $OUTR"/out-cat-gold.txt" "ISO-8859-1"
		python $SCRIPT $OUT"/types_test_sent_doc.xml" $OUTR"/out-types-gold.txt" "ISO-8859-1"
		python $SCRIPT $OUT"/subtypes_test_sent_doc.xml" $OUTR"/out-subtypes-gold.txt" "ISO-8859-1"
		python $SCRIPT $OUT"/filtered_test_sent_doc.xml" $OUTR"/out-filtered-gold.txt" "ISO-8859-1"
	done
done