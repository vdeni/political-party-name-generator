struct TransitionMatrix
    transition_probs::Matrix{Int8}
    dimnames::Vector{Tuple{Int64, String}}

    function TransitionMatrix(;
                              dimnames::Vector{String})
        dimnames = zip(1:length(dimnames),
                       dimnames) |>
            collect

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

    return transition_matrix
end
