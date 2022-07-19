using Pkg
Pkg.activate(".")
using JSON

include(joinpath("..",
                 "helpers",
                 "transition-probabilities.jl"))

include(joinpath("..",
                 "helpers",
                 "initial-probabilities.jl"))

include(joinpath("..",
                 "helpers",
                 "writers.jl"))

party_names = JSON.parsefile(joinpath("data",
                                      "party-names_clean",
                                      "stranke_imena.json"))

# extract party names to vector
party_names = collect(Vector{String},
                      values(party_names))

# get transition probabilities
transition_matrix = makeTransitionMatrix(party_names)

transition_probs = gatherWordInfo(transition_matrix)

open(joinpath("data",
              "transition-probabilities",
              "transition-probs.json"),
     "w") do outfile
    write(outfile,
          JSON.json(transition_probs))
end

# get initial probabilities
initial_probabilities = getInitialProbabilities(party_names)

open(joinpath("data",
              "transition-probabilities",
              "initial-probs.json"),
     "w") do outfile
    write(outfile,
          JSON.json(initial_probabilities))
end
