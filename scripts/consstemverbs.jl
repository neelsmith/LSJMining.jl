using PolytonicGreek
using Unicode

const PG = PolytonicGreek
    ortho = literaryGreek()





omega2 = filter(v) do m
    cpindexes = collect(eachindex(m.label))
    if length(cpindexes) > 1
        penultidx = cpindexes[end - 1]

        endswith(m.label,"ω") && occursin(m.label[penultidx], PG.consonants(ortho))
    else
        false
    end
end

omegalabels = map(m -> m.label, omega2)

endings = map(omegalabels) do s
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end - 2]
        if occursin(s[start], PG.consonants(ortho))
        else
            start = cpindexes[end-1]
        end
        s[start:end]
    else
        s
    end
end





