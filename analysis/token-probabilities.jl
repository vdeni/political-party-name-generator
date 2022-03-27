using JSON
using DataStructures

include(joinpath("helpers",
                 "transition-probabilities.jl"))

include(joinpath("helpers",
                 "initial-probabilities.jl"))

party_names = JSON.parsefile(joinpath("data",
                                      "clean",
                                      "stranke_imena.json"))

# extract party names to vector
party_names = collect(Vector{String},
                      values(party_names))

transition_matrix = makeTransitionMatrix(party_names)

initial_probabilities = getInitialProbabilities(party_names)
