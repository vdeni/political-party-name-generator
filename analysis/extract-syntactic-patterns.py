import os

import classla
import pandas

# prepare classla
nlp = classla.Pipeline("hr", processors="tokenize,pos")

# import party names
party_names = pandas.read_json(
    os.path.join("data", "party-names_clean", "stranke_imena.json"), typ="series"
)

# flatten names with join
party_names = [" ".join(party) for party in party_names]

# process party names with classla
docs = [nlp(party) for party in party_names]

# extract unique syntactic patterns, but keep some words hardcoded
words_keep = [
    "STRANKA",
    "ZAJEDNICA",
    "POKRET",
    "SABOR",
    "SAVEZ",
    "UNIJA",
    "PARTIJA",
    "AKCIJA",
    "FORUM",
    "BLOK",
    "LISTA",
]

docs_pos = [
    [
        elem.get("text") if elem.get("text") in words_keep else elem.get("xpos")
        for elem in doc.to_dict()[0][0]
    ]
    for doc in docs
]

docs_pos_unique = []

for doc in docs_pos:
    if doc not in docs_pos_unique:
        docs_pos_unique.append(doc)

# filter out patterns containing X and Y POS tags
docs_filtered = []

for doc in docs_pos_unique:
    if not any(postag in ["Xf", "Y"] for postag in doc):
        docs_filtered.append(doc)

# write to file
with open(
    os.path.join("data", "syntactic-patterns", "syntactic-patterns.txt"), "w"
) as ofile:
    for doc in docs_filtered:
        ofile.write(",".join(doc) + "\n")
