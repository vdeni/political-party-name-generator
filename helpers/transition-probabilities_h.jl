struct TransitionMatrix
    transition_probs::Matrix{Int16}
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

function makeTransitionProbs(;
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

    return transition_matrix
end
