# variables

PARTY_DATA_CLEAN=data/party-names_clean
PARTY_DATA_RAW=data/party-names_raw

TRANSITION_PROBABILITIES_DATA=data/transition-probabilities

SYNTACTIC_PATTERNS_DIR=data/syntactic-patterns

# recipes

# >>>>> abstract
all:\
	$(PARTY_DATA_RAW)/stranke_ogranci.csv\
	$(PARTY_DATA_CLEAN)/stranke_imena.json\
	$(TRANSITION_PROBABILITIES_DATA)/transition-probs.json\
	$(TRANSITION_PROBABILITIES_DATA)/initial-probs.json\
	$(SYNTACTIC_PATTERNS_DIR)/syntactic-patterns.txt

# >>>>> concrete

$(PARTY_DATA_RAW)/stranke_ogranci.csv:
	mkdir -p $(PARTY_DATA_RAW)
	curl https://mpu.gov.hr/UserDocsImages//dokumenti/Otvoreni%20podaci//ExportPolitickeStrankeOgranci08.05.2021-06_00.csv\
		-o $@

$(DATA_CLEAN)/stranke_imena.json:\
	wrangling/extract-words.py\
	$(PARTY_DATA_RAW)/stranke_ogranci.csv
	pipenv run python $<

$(TRANSITION_PROBABILITIES_DATA)/transition-probs.json\
$(TRANSITION_PROBABILITIES_DATA)/initial-probs.json:\
	analysis/token-probabilities.jl\
	helpers/*.jl
	julia $<

$(SYNTACTIC_PATTERNS_DIR)/syntactic-patterns.txt:\
	analysis/extract-syntactic-patterns.py\
	$(PARTY_DATA_CLEAN)/stranke_imena.json
	mkdir -p $(SYNTACTIC_PATTERNS_DIR)
	pipenv run python $<
