"""
Generate a party name.
"""
function makePartyName(transition_probs::Dict{String, Any},
                       initial_probs::Dict{String, Any})
    party_name = Vector()

    words = collect(keys(initial_probs))

    initial_weights = StatsBase.Weights(Vector{Float64}(undef,
                                                        length(words)))

    for (i, word) in enumerate(words)
        initial_weights[i] = initial_probs[word]
    end
end
