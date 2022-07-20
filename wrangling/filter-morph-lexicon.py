import os
import sys

import pandas

sys.path.append('.')

from helpers import data_loaders

d_path = os.path.join('data',
                      'croatian-morphological-lexicon',
                      'clean',
                      'morphological-lexicon.txt')

colnames = ['wordform',
            'lemma',
            'msd',
            'msd_features',
            'upos',
            'morph_features',
            'frequency',
            'frequency_per_mil']

morphological_lexicon = pandas.read_table(d_path,
                                          sep='<SEP>',
                                          names=colnames,
                                          usecols=colnames[0:3])

syntactic_patterns = data_loaders.load_syntactic_patterns()

syntactic_patterns_set = set([pattr for pattr_combo in syntactic_patterns
                              for pattr in pattr_combo])

morphological_lexicon.query('msd.isin(@syntactic_patterns_set)')

morphological_lexicon.to_csv(os.path.join('data',
                                          'croatian-morphological-lexicon',
                                          'clean',
                                          'morphological-lexicon.txt'),
                             index=False,
                             sep='|')
