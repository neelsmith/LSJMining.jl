

"""Compute frequencies of last `n` graphemes in a 
vector of morphological data.
$(SIGNATURES)
"""
function profile_endings(mdata::Vector{MorphData}; n = 2)
    sliver = n - 1
    if n < 1
        throw(DomainError("Moron. `n` must be greater than 0."))
    end
    endinglist = map(mdata) do m
        stripped = rmaccents(m.label)
        uchars = graphemes(stripped) |> collect
        length(uchars) > sliver ? join(uchars[end-sliver:end]) : join(uchars)
    end
    groupedendings = group(endinglist)
    counts = []

    for ending in keys(groupedendings)
        num = groupedendings[ending] |> length
        push!(counts, (ending, num))
    end
    sort(counts, by = pr -> pr[2], rev = true)
end

