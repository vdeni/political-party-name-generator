using JSON

include(joinpath("helpers",
                 "transition-probabilities_h.jl"))

party_names = JSON.parsefile(joinpath("data",
                                      "clean",
                                      "stranke_imena.json"))

# extract unique words and named entities from party names
unique_entries = collect(Iterators.flatten(values(party_names)))

unique_entries = unique(unique_entries)

# extract party names to vector
party_names = collect(Vector{String},
                      values(party_names))

makeTransitionProbs(names_collection = party_names,
                    unique_elems = unique_entries)
