using Pkg
Pkg.activate(".")
using JSON
using StatsBase

transition_probs = JSON.parsefile(joinpath("analysis",
                                           "transition-probs.json"))

initial_probs = JSON.parsefile(joinpath("analysis",
                                        "initial-probs.json"))
