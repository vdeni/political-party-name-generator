import os

import pandas

import classla

# prepare classla
classla.download('hr')

nlp = classla.Pipeline('hr',
                       processors='tokenize,pos')

# import party names
party_names = pandas.read_json(os.path.join('data',
                                            'party-names_clean',
                                            'stranke_imena.json'),
                               typ='series')

# flatten names with join
party_names = party_names.map(lambda x: ' '.join(x))

# process party names with classla
docs = party_names.to_list()

docs = [nlp(doc) for doc in docs]

# extract unique syntactic patterns
docs_pos = [doc.get('xpos') for doc in docs]

docs_pos_unique = list()

for doc in docs_pos:
    if doc not in docs_pos_unique:
        docs_pos_unique.append(doc)

# filter out patterns containing X POS tags
docs_pos_unique = [doc for doc in docs_pos_unique if 'Xf' not in doc]

# write to file
with open(os.path.join('data',
                       'syntactic-patterns',
                       'syntactic-patterns.txt'), 'w') as ofile:
    for doc in docs_pos_unique:
        ofile.write(','.join(doc) + '\n')
