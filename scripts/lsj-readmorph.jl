repo = pwd()
using Pkg
Pkg.activate(repo)
Pkg.resolve()
Pkg.instantiate()
using LexiconMining

basedir = joinpath(pwd(), "cex")
v = Vector{MorphData}()
for i in collect(1:27)
    f = joinpath(basedir, "morphdata_$(i).cex")
    append!(v, readlines(f) .|> morphData)
end


###
using PolytonicGreek
vvowels = vcat(split(PolytonicGreek.LG_VOWELS,""), PolytonicGreek.allaccents())

mascs = filter(m -> m.gen == "ὁ" && endswith(m.label,"ν"),  v)
words = map(d -> d.label, neuts)
syllabifiedvowels = []
for word in words
    cstrings = split(word,"")
    vstrings = filter(c -> c in vvowels,  cstrings)
    push!(syllabifiedvowels, vstrings)
end

