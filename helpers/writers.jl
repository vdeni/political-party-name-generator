"""
```
gatherWordInfo(transition_matrix::TransitionMatrix) =>
                   Dict{String, Dict{String, Any}}}
```
Create `Dict` with nonzero transition probabilities for each word

Parameters:
    - `transition_matrix`: a `TransitionMatrix` holding the transition
    probabilities and strings.

Returns:
    - A dictionary with a string taken from the party name as key, and
    having as values dictionaries that contain each other word present in the
    dataset, with the corresponding transition probability.
"""
function gatherWordInfo(transition_matrix::TransitionMatrix)

    out_dict = Dict{String, Dict{String, Float64}}()

    for word in keys(transition_matrix.dimnames)
        # indices of non-zero elements
        indices = findall(x -> x != 0,
                          transition_matrix.
                              transition_probs[transition_matrix.dimnames[word],
                                               :])

        transition_ps = Dict()

        if !isempty(indices)
            # find dimnames
            entries = filter(x -> x[2] in indices,
                             transition_matrix.dimnames)

            for key in keys(entries)
                transition_ps[key] =
                    transition_matrix.
                        transition_probs[transition_matrix.dimnames[word],
                                         entries[key]]
            end
        end

        out_dict[word] = transition_ps
    end

    return out_dict
end
