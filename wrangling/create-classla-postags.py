import re
import sys

import pandas
import classla

sys.path.append('.')

from helpers import data_loaders

filename = sys.argv[1]

morphological_lexicon = pandas.read_csv(filename,
                                        names=['form', 'lemma', 'postag'])

syntactic_patterns = data_loaders.load_syntactic_patterns()

syntactic_patterns_set = set([pattr for pattr_combo in syntactic_patterns
                              for pattr in pattr_combo])

# filter out some word categories from lexicon
word_categories = set([cat[0:3] for cat in syntactic_patterns_set])

pattr = re.compile('|'.join(word_categories))

idx_keep = morphological_lexicon.postag.map(lambda x: pattr.match(x)
                                            is not None).values

morphological_lexicon = morphological_lexicon.loc[idx_keep, :]

# prepare classla
nlp = classla.Pipeline('hr',
                       processors='tokenize,pos')

# get postags
words = morphological_lexicon.form.to_list()[0:1000]

docs = [nlp(word) for word in words]

print(f'Done: {docs[0]}')
