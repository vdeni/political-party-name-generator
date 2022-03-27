"""
```
gatherWordInfo(transition_matrix::TransitionMatrix,
               initial_probs::Dict{String, Float64}) => Dict{Any, Any}}
```
Bind transition probabilities and initial probabilities into single Dict ready
for JSON dump.
"""
function gatherWordInfo(transition_matrix::TransitionMatrix,
                        initial_probs::Dict{String, Float64})

    out_dict = Dict()

    for word in keys(transition_matrix.dimnames)
        # indices of non-zero elements
        indices = findall(x -> x != 0,
                          transition_matrix.
                          transition_probs[transition_matrix.dimnames[word], :])

        transition_ps = Dict()

        if !isempty(indices)
            # find dimnames
            entries = filter(x -> x[2] in indices,
                             transition_matrix.dimnames)

            for key in keys(entries)
                transition_ps[key] =
                    transition_matrix.
                    transition_probs[transition_matrix.dimnames[word], entries[key]]
            end
        end

        if !(word in keys(initial_probs))
            initial_probs_out = 0
        else
            initial_probs_out = initial_probs[word]
        end
        
        out_dict[word] = Dict("transition_probs" => transition_ps,
                              "initial_probs" => initial_probs_out)
    end

    return out_dict
end
