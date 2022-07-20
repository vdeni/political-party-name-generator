import os


def load_syntactic_patterns():
    with open(os.path.join('data',
                           'syntactic-patterns',
                           'syntactic-patterns.txt'),
              'r') as infile:
        syntactic_patterns = infile.readlines()

    syntactic_patterns = [pattr.strip() for pattr in syntactic_patterns]
    syntactic_patterns = [pattr.split(',') for pattr in syntactic_patterns]

    return syntactic_patterns
