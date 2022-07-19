using Pkg
Pkg.activate(".")
using DataFrames
using CSV

include(joinpath("helpers",
                 "party-sampler.jl"))

syntactic_patterns = readlines(joinpath("data",
                                        "syntactic-patterns",
                                        "syntactic-patterns.txt"))

morphological_lexicon = CSV.read(joinpath("data",
                                          "croatian-morphological-lexicon",
                                          "clean",
                                          "morphological-lexicon.csv"),
                                 DataFrames.DataFrame;
                                 header = ["morph_form", "lemma", "postag"])

for i in 1:20
    makePartyName(transition_probs,
                  initial_probs) |> println
end
