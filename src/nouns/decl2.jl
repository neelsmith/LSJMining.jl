
"""Extract second-declension masculine noun entries from `v`
and write a table to a Kanones dataset.

"""
function decl2masc(v::Vector{MorphData}, registry, target)
    mnouns = filter(v) do d 
        stripped = rmaccents(d.label)
        isempty(d.itype) && 
        d.gen == "ὁ" && 
        endswith(stripped,"ος")
    end
    @info("Second decl. masc. nouns to format: $(length(mnouns))")
    mlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(mnouns)
        if i % 100 == 0
            @info("masc. second-declension noun $(i)…")
        end
        columns = 
        [ "nounstems.$(noun.id)",
        "lsjx.$(noun.id)",
        replace(rmaccents(noun.label), r"ος$" =>  ""),
        "masculine",
        "os_ou",
        accenttype(noun.label)   
        ]
        push!(mlines, join(columns,"|"))
    end


    registerednouns = filter(mlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end



    mnounfile = joinpath(target,"stems-tables", "nouns", "decl2m.cex")
    open(mnounfile,"w") do io
        write(io, join(registerednouns, "\n"))
    end
end

function decl2neut(v::Vector{MorphData}, registry, target)
    neutnouns = filter(v) do d 
        stripped = rmaccents(d.label)
        isempty(d.itype) && 
        d.gen == "τό" && 
        endswith(stripped,"ον")
    end
    @info("Second decl. neut. nouns to format: $(length(neutnouns))")
    neutlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(neutnouns)
        if i % 100 == 0
            @info("second-declension neuter noun $(i)…")
        end
        columns = 
        [ "nounstems.$(noun.id)",
        "lsjx.$(noun.id)",
        replace(rmaccents(noun.label), r"ον$" =>  ""),
        "neuter",
        "os_ou",
        accenttype(noun.label)   
        ]
        push!(neutlines, join(columns,"|"))
    end


    registerednouns = filter(neutlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end



    neutnounfile = joinpath(target,"stems-tables", "nouns", "decl2n.cex")
    open(neutnounfile,"w") do io
        write(io, join(registerednouns, "\n"))
    end
end

"""Extract second-declension nouns from LSJ data and
write stems files to Kanones.
$(SIGNATURES)
"""
function decl2(v::Vector{MorphData}, registry, target)
    nounstemsdir(target)
    @info("Total morph entries: $(length(v))")
    decl2masc(v,registry, target)
    decl2neut(v,registry, target)
end

