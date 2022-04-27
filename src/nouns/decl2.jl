
function decl2masc(v::Vector{MorphData}, target)
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
            @info("$(i)...")
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
    mnounfile = joinpath(target,"stems-tables", "nouns", "decl2m.cex")
    open(mnounfile,"w") do io
        write(io, join(mlines, "\n"))
    end
end

function decl2neut(v::Vector{MorphData}, target)
    neutnouns = filter(v) do d 
        stripped = rmaccents(d.label)
        isempty(d.itype) && 
        d.gen == "τό" && 
        endswith(stripped,"ον")
    end
    neutlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(neutnouns)
        if i % 100 == 0
            @info("$(i)...")
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
    neutnounfile = joinpath(target,"stems-tables", "nouns", "decl2n.cex")
    open(neutnounfile,"w") do io
        write(io, join(neutlines, "\n"))
    end
end
function decl2(v::Vector{MorphData}, target)
    nounstemsdir(target)
    @info("Total morph entries: $(length(v))")
    decl2masc(v,target)
    decl2neut(v,target)
end

