using JSON

include(joinpath("helpers",
                 "transition-probabilities_h.jl"))

party_names = JSON.parsefile(joinpath("data",
                                      "clean",
                                      "stranke_imena.json"))

# extract unique words and named entities from party names
# extract party names to vector
party_names = collect(Vector{String},
                      values(party_names))

transition_matrix = makeTransitionMatrix(party_names)
