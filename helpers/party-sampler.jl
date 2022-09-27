using StatsBase
using DataFrames
using Random

"""
```
function makePartyName(transition_probs::Dict{String, Any},
                       initial_probs::Dict{String, Any}) => String
```
Generate a party name from transition probability matrix and a set of
initial probabilities.

Parameters:
    - `transition_probs`: Dictionary containing the probability of transitioning
    from a string given as a key to any other string present in the transition
    matrix.
    - `initial_probs`: Initial probability for each string, i.e. the probability
    that the string will appear as the first string in the party name.

Returns: a `String` representing a generated party name.
"""
function makePartyName(transition_probs::Dict{String,Any},
    initial_probs::Dict{String,Any})

    party_name = Vector()

    initial_words = collect(keys(initial_probs))

    initial_weights = StatsBase.Weights(Vector{Float64}(undef,
        length(initial_words)))

    for (i, word) in enumerate(initial_words)
        initial_weights[i] = initial_probs[word]
    end

    append!(party_name,
        [StatsBase.sample(initial_words,
            initial_weights)])

    while !isempty(transition_probs[last(party_name)])
        words_next = collect(keys(transition_probs[last(party_name)]))

        weights_next = StatsBase.Weights(Vector{Float64}(undef,
            length(words_next)))

        for (i, word) in enumerate(words_next)
            weights_next[i] = transition_probs[last(party_name)][word]
        end

        append!(party_name,
            [StatsBase.sample(words_next,
                weights_next)])
    end

    return join(party_name,
        " ")
end

"""
```
function makePartyName(syntactic_patterns::Vector{String},
                       morphological_lexicon::DataFrames.DataFrame) => String
```
Generate a party name using syntactic patterns and a lexicon.

Parameters:
    - `syntactic_patterns`: A `Vector` of syntactic patterns represented
    as `String`s which hold comma-separated part-of-speech tags. One is chosen
    at random to construct a party name.
    - `morphological_lexicon`: A `DataFrame` holding morphological forms,
    lemmas, and their part-of-speech tags.

Returns: a `String` representing a generated party name.
"""
function makePartyName(syntactic_patterns::Vector{String},
    morphological_lexicon::DataFrames.DataFrame)

    pattern = rand(syntactic_patterns)

    pattern = split(pattern, ",")

    out_elems = Vector()

    for elem in pattern
        if startswith(elem, "M")
            word = Random.rand(1:5_000)
        elseif elem == "Z"
            word = "-"
        elseif !isnothing(match(r"^[[:upper:]]+$", elem))
            word = elem
        else
            word = DataFrames.subset(morphological_lexicon,
                       :msd => x -> x .== elem;
                       view=true) |>
                   eachrow |>
                   rand |>
                   x -> uppercase(x.wordform)
        end

        append!(out_elems,
            [word])
    end

    return join(out_elems,
        " ")
end
