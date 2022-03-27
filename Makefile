# variables

DATA_CLEAN=data/clean
DATA_RAW=data/raw

# recipes

# >>>>> abstract
all:\
	$(DATA_RAW)/stranke_ogranci.csv\
	$(DATA_CLEAN)/stranke_imena.json\
	analysis/transitions.json

# >>>>> concrete

$(DATA_RAW)/stranke_ogranci.csv:
	curl https://mpu.gov.hr/UserDocsImages//dokumenti/Otvoreni%20podaci//ExportPolitickeStrankeOgranci08.05.2021-06_00.csv\
		-o $@

$(DATA_CLEAN)/stranke_imena.json:\
	wrangling/extract-words.py\
	$(DATA_RAW)/stranke_ogranci.csv
	pipenv run python $<

analysis/transitions.json:\
	analysis/token-probabilities.jl\
	helpers/*.jl
	julia $<
