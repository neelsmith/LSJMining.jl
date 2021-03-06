
function decl3ous(v::Vector{MorphData}, registry, target)
    ousnouns = filter(v) do d 
        stripped = rmaccents(d.label)
        d.itype == "εος" && 
        endswith(stripped,"ος")
    end
    @info("Third decl. nouns os/ous: $(length(ousnouns))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(ousnouns)
        if i % 100 == 0
            @info("third-declension nouns os/ous $(i)…")
        end
        columns = 
        [ "nounstems.$(noun.id)",
        "lsjx.$(noun.id)",
        replace(rmaccents(noun.label), r"ος$" =>  ""),
        "neuter",
        "os_ous",
        accenttype(noun.label)   
        ]
        push!(nounlines, join(columns,"|"))
    end


    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl3ous.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end


"""Extract second-declension nouns from LSJ data and
write stems files to Kanones.
$(SIGNATURES)
"""
function decl3(v::Vector{MorphData}, registry, target)
    nounstemsdir(target)
    @info("Total morph entries: $(length(v))")
   
    decl3ous(v,registry, target)
end