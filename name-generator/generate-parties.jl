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
                                          "morphological-lexicon.txt"),
                                 DataFrames.DataFrame;
                                 delim = "|")

for i in 1:20
    makePartyName(syntactic_patterns,
                  morphological_lexicon) |>
        println
end
