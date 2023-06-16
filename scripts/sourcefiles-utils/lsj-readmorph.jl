repo = pwd()
using Pkg
Pkg.activate(repo)
Pkg.resolve()
Pkg.instantiate()
using LexiconMining



function charsok(s)
    ok = true
    for c in s
        if (c < '\u390')
            ok = false
        end
    end
    ok
end


function loadmorph()
    basedir = joinpath(pwd(), "cex")
    v = Vector{MorphData}()
    for i in collect(1:27)
        f = joinpath(basedir, "morphdata_$(i).cex")
        mdata = readlines(f)[2:end] .|> morphData
        for m in mdata
            if charsok(m.label)
                push!(v, m)
            end
        end
    end
    v
end






#=
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

=#