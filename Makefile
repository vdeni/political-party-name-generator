# variables

PARTY_DATA_CLEAN=data/party-names_clean
PARTY_DATA_RAW=data/party-names_raw

TRANSITION_PROBS_DATA=data/transition-probabilities

SYNT_PATTRS_DIR=data/syntactic-patterns

MORPH_LEXICON_DIR=data/croatian-morphological-lexicon

# recipes

# >>>>> abstract
all:\
	$(PARTY_DATA_RAW)/stranke_ogranci.csv\
	$(PARTY_DATA_CLEAN)/stranke_imena.json\
	$(TRANSITION_PROBS_DATA)/transition-probs.json\
	$(TRANSITION_PROBS_DATA)/initial-probs.json\
	$(SYNT_PATTRS_DIR)/syntactic-patterns.txt

# >>>>> concrete

$(PARTY_DATA_RAW)/stranke_ogranci.csv:
	mkdir -p $(PARTY_DATA_RAW)
	curl https://mpu.gov.hr/UserDocsImages//dokumenti/Otvoreni%20podaci//ExportPolitickeStrankeOgranci08.05.2021-06_00.csv\
		-o $@

$(DATA_CLEAN)/stranke_imena.json:\
	wrangling/extract-words.py\
	$(PARTY_DATA_RAW)/stranke_ogranci.csv
	pipenv run python $<

$(TRANSITION_PROBS_DATA)/transition-probs.json\
$(TRANSITION_PROBS_DATA)/initial-probs.json:\
	analysis/token-probabilities.jl\
	helpers/*.jl
	julia $<

$(SYNT_PATTRS_DIR)/syntactic-patterns.txt:\
	analysis/extract-syntactic-patterns.py\
	$(PARTY_DATA_CLEAN)/stranke_imena.json
	mkdir -p $(SYNT_PATTRS_DIR)
	pipenv run python $<

$(MORPH_LEXICON_DIR)/clean/morphological-lexicon.csv:\
	$(MORPH_LEXICON_DIR)/raw/hml_50_metashare_v2.txt
	mkdir -p $(@D)
	sed -Ee 's/\s/,/g' $< > $@
	sed -i -Ee 's/,$$//' $@
