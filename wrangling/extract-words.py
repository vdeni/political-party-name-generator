# izvuci imena politickih stranaka iz popisa ogranaka stranaka. izbaci .txt
# datoteku koja sadrzi popis rijeci u imenu svake stranke. grupiranje
# imenovanih entiteta (poput osobnih imena) izvrseno je rucno, izvan ove
# datoteke
import os

import pandas

d = pandas.read_csv(os.path.join('data',
                                 'raw',
                                 'stranke_ogranci.csv'),
                    sep=';')

# izvuci naziv stranaka

imena = d['NAZIV STRANKE']

imena = imena.unique()

imena = pandas.Series(imena)

# promijeni sve rijeci u uppercase
imena = imena.map(str.upper)

# rascijepaj na rijeci
imena = imena.map(str.split)

imena.to_json(os.path.join('data',
                           'clean',
                           'stranke_imena.json'))
