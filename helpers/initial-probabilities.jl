using DataStructures

"""
```
getInitialProbabilities(names_collection::Vector{Vector{String}}) =>
    Dict{String, Float64}
```
Get initial probabilities by counting how often each word appear as the first
word of a political party name.

Parameters:
    - `names_collection`: a `Vector` of `Vector`s of `String`s.
    E.g. [['A', 'sentence']]

Returns:
    - `Dict` of `String`s and `Float64`s holding the probability of choosing
    each string as the first word in the party name to be generated.
"""
function getInitialProbabilities(names_collection::Vector{Vector{String}})
    initials = []

    for name in names_collection
        append!(initials,
                [name[1]])
    end

    N_tot = length(initials)

    counts = DataStructures.counter(initials)

    initial_probs = Dict{String, Float64}(counts)

    for key in keys(initial_probs)
        initial_probs[key] /= N_tot
    end

    return initial_probs
end
