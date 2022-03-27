"""
```
getInitialProbabilities(names_collection::Vector{Vector{String}})
```
Get initial probabilities by counting how often each word appear as the first
word of a political party name.

- `names_collection`: a vector of vectors of strings. E.g. [['A', 'sentence']]
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
