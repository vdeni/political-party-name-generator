import os

import pandas

morphological_lexicon =\
    pandas.read_csv(os.path.join('data',
                                 'croatian-morphological-lexicon',
                                 'clean',
                                 'morphological-lexicon.csv'),
                    names=['morph_form', 'lemma', 'postag'])

with open(os.path.join('data',
                       'syntactic-patterns',
                       'syntactic-patterns.txt'),
          'r') as infile:
    syntactic_patterns = infile.readlines()

syntactic_patterns = [pattr.strip() for pattr in syntactic_patterns]

syntactic_patterns = [pattr.split(',') for pattr in syntactic_patterns]

syntactic_patterns = [pattr for pattr_set in syntactic_patterns
                      for pattr in pattr_set]

syntactic_patterns = set(syntactic_patterns)

# filter out missing
morphological_lexicon =\
    morphological_lexicon.query('postag.isin(@syntactic_patterns)')

morphological_lexicon.reset_index(inplace=True,
                                  drop=True)

pos_set = set(morphological_lexicon.postag.values)

syntactic_patterns.difference(pos_set)
