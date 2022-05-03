
# After loading morphodata into `v`:
flist = [
    vowelverb, liquidverb, stopverb, contractverb, izwverb, sigmaverb, numiverb, irregmiverb, irregomega
]

countpairs = []
for f in flist
    lbl = string(f)
    count = filter(d -> f(d), v) |> length
    push!(countpairs, (lbl, count))
end



#=

> map(othercons ) do m
        s = m.label
        cpindexes = collect(eachindex(s))
        if length(cpindexes)  > 2
               start = cpindexes[end-1]
               s[start]
               else
               ""
               end
               end |> unique
15-element Vector{Any}:
 'ζ': Unicode U+03B6 (category Ll: Letter, lowercase)
 'σ': Unicode U+03C3 (category Ll: Letter, lowercase)
 'ξ': Unicode U+03BE (category Ll: Letter, lowercase)
 '̈': Unicode U+0308 (category Mn: Mark, nonspacing)
 'ψ': Unicode U+03C8 (category Ll: Letter, lowercase)
 'ε': Unicode U+03B5 (category Ll: Letter, lowercase)
 'ἀ': Unicode U+1F00 (category Ll: Letter, lowercase)
 ""
 '́': Unicode U+0301 (category Mn: Mark, nonspacing)
 'ͅ': Unicode U+0345 (category Mn: Mark, nonspacing)
 '>': ASCII/Unicode U+003E (category Sm: Symbol, math)
 'ὲ': Unicode U+1F72 (category Ll: Letter, lowercase)
 'ϝ': Unicode U+03DD (category Ll: Letter, lowercase)
 'α': Unicode U+03B1 (category Ll: Letter, lowercase)
 'ο': Unicode U+03BF (category Ll: Letter, lowercase)

=#