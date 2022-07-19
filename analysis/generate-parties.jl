using Pkg
Pkg.activate(".")
using JSON

include(joinpath("helpers",
                 "party-sampler.jl"))

transition_probs = JSON.parsefile(joinpath("analysis",
                                           "transition-probs.json"))

initial_probs = JSON.parsefile(joinpath("analysis",
                                        "initial-probs.json"))

for i in 1:20
    makePartyName(transition_probs,
                  initial_probs) |> println
end
