#!/bin/bash

# tokenize train and test set, in filter-harem/outputs/
printf "***tokenizing***\n"
./tokenize.sh
# convert tokens to conll annotation scheme
printf "\n***token to conll***\n"
./token-to-conll.sh

# train
for i in {0..9}
do
	printf "\n*****fold "$i"*****\n"
	printf "\n***training categories***\n"
	cd train/fold-$i && ./train-cat.sh ; cd -
	printf "\n***training filtered***\n"
	cd train/fold-$i && ./train-filtered.sh ; cd -
	# printf "\n***training types***\n"
	# cd train/fold-$i && ./train-types.sh ; cd - # not enough RAM
	# printf "\n***training subtypes***\n"
	# cd train/fold-$i && ./train-subtypes.sh ; cd - # not enough RAM
done

# test - perform ner
printf "\n***testing categories***\n"
cd test && ./test-cat.sh ; cd -
printf "\n***testing filtered***\n"
cd test && ./test-filtered.sh ; cd -
# printf "\n***testing types***\n"
# cd test && ./test-types.sh ; cd - # not enough RAM
# printf "\n***testing subtypes***\n"
# cd test && ./test-subtypes.sh ; cd - # not enough RAM