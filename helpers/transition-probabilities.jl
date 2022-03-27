"""
Object for storing a transition probability matrix.
- `transition_probs`: component holds the transition probabilities in in\
Matrix form.
- `dimnames`: a dictionary with dimension names as keys, and matrix row\
and column indices as values.
"""
mutable struct TransitionMatrix
    transition_probs::Matrix{Number}
    dimnames::Dict{String, Int16}

    function TransitionMatrix(;
                              dimnames::Vector{String})
        dimnames = zip(dimnames,
                       1:length(dimnames)) |>
            Dict

        transition_probs = zeros(Int8,
                                 (length(dimnames),
                                  length(dimnames)))

        new(transition_probs,
            dimnames)
    end
end

"""
```
makeTransitionMatrix(;
                     names_collection::Vector{Vector{String}},
                     unique_elems::Vector{String}) => TransitionMatrix
```

This function takes a vector containing vectors of strings (i.e. each sentence\
is represented by a vector of words) and returns a transition probability\
matrix for all tokens.

- `names_collection`: a vector of vectors of strings. E.g. [['A', 'sentence']]
"""
function makeTransitionMatrix(names_collection::Vector{Vector{String}})
    # flatten vector of vector of strings to vector of strings
    unique_elems = collect(Iterators.flatten(values(names_collection)))

    # count number of occurences of each string
    counts = DataStructures.counter(unique_elems)

    # extract unique elements
    unique_elems = unique(unique_elems)

    transition_matrix = TransitionMatrix(dimnames = unique_elems)

    for name in names_collection
        for (i, elem) in enumerate(name)
            if i == 1
                continue
            else
                idx_row = transition_matrix.dimnames[name[i - 1]]
                idx_col = transition_matrix.dimnames[elem]

                transition_matrix.transition_probs[idx_row, idx_col] += 1 /
                    counts[name[i - 1]]
            end
        end
    end

    return transition_matrix
end
