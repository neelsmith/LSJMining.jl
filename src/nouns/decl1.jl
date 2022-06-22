function decl1eta(v::Vector{MorphData}, registry, target)
    etanouns = filter(v) do d 
        stripped = rmaccents(d.label)
        isempty(d.itype) && 
        d.gen == nfkc("ἡ") && 
        endswith(stripped,"η")
    end
    @info("First decl. fem. nouns to format: $(length(etanouns))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(etanouns)
        if i % 100 == 0
            @info("first-declension feminine noun $(i)…")
        end
        columns = 
        [ "nounstems.$(noun.id)",
        "lsjx.$(noun.id)",
        replace(rmaccents(noun.label), r"η$" =>  ""),
        "feminine",
        "h_hs",
        accenttype(noun.label)   
        ]
        push!(nounlines, join(columns,"|"))
    end

    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl1eta.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end




function decl1masc(v::Vector{MorphData}, registry, target)
    firstnouns = filter(v) do d 
        stripped = rmaccents(d.label)
        d.itype == nfkc("ου") && 
        d.gen == nfkc("ὁ") && 
        endswith(stripped,"ης")
    end
    @info("First decl. masc. nouns to format: $(length(firstnouns))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(firstnouns)
        if i % 100 == 0
            @info("first-declension masculine noun $(i)…")
        end
        columns = 
        [ "nounstems.$(noun.id)",
        "lsjx.$(noun.id)",
        replace(rmaccents(noun.label), r"ης$" =>  ""),
        "masculine",
        "hs_ou",
        accenttype(noun.label)   
        ]
        push!(nounlines, join(columns,"|"))
    end

    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl1masc.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end

"""Extract second-declension nouns from LSJ data and
write stems files to Kanones.
$(SIGNATURES)
"""
function decl1(v::Vector{MorphData}, registry, target)
    nounstemsdir(target)
    @info("Total morph entries: $(length(v))")
    decl1eta(v,registry, target)
    decl1masc(v,registry, target)

end