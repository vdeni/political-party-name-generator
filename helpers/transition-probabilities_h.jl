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

This function takes a vector containing vectors of strings (i.e. each sentence/\
entry is represented by a vector of words) and returns a transition probability\
matrix for all entries.

- `names_collection`: a vector of vectors of strings. E.g. [['A', 'sentence']]
- `unique_elems`: vector of strings containing the unique elements (tokens)\
that appear in all of the elements of the `names_collection` vector.
"""
function makeTransitionMatrix(;
                              names_collection::Vector{Vector{String}},
                              unique_elems::Vector{String})
    transition_matrix = TransitionMatrix(dimnames = unique_elems)

    for name in names_collection
        for (i, elem) in enumerate(name)
            if i == 1
                continue
            else
                idx_row = transition_matrix.dimnames[name[i - 1]]
                idx_col = transition_matrix.dimnames[elem]

                transition_matrix.transition_probs[idx_row, idx_col] += 1
            end
        end
    end

    N_total = Iterators.flatten(names_collection) |>
        collect |>
        length

    transition_matrix.transition_probs = transition_matrix.transition_probs ./
        N_total

    return transition_matrix
end
