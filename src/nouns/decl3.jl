
function decl3ous(v::Vector{MorphData}, registry, target; chunk = 100)
    ousnouns = filter(v) do d 
        stripped = rmaccents(d.label)
        d.itype == "εος" && 
        endswith(stripped,"ος")
    end
    @info("Third decl. nouns os/ous: $(length(ousnouns))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(ousnouns)
        if i % chunk == 0
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




function decl3ma_matos(v::Vector{MorphData}, registry, target; chunk = 100)
    nouns3 = filter(v) do d 
        stripped = rmaccents(d.label)
        d.itype == "ατος" && 
        endswith(stripped,"μα") &&
        d.gen == nfkc("τό")
    end
    @info("Third decl. neuters ma/matos: $(length(nouns3))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(nouns3)
        if i % chunk == 0
            @info("third-declension nouns ma/matos $(i)…")
        end
        columns = 
        [ "nounstems.$(noun.id)",
        "lsjx.$(noun.id)",
        rmaccents(noun.label),
        "neuter",
        "ma_matos",
        accenttype(noun.label)   
        ]
        push!(nounlines, join(columns,"|"))
    end


    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl3ma_matos.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end





function decl3is_idos(v::Vector{MorphData}, registry, target; chunk = 100)
    nouns3 = filter(v) do d 
        stripped = rmaccents(d.label)
        rmaccents(d.itype) == "ιδος" && 
        endswith(stripped,"ις") &&
        ! isempty(d.gen)
    end
    @info("Third decl. is/idos: $(length(nouns3))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(nouns3)
        if i % chunk == 0
            @info("third-declension nouns is/idos $(i)…")
        end

        if noun.gen in keys(lsjgender)
            columns = 
            [ "nounstems.$(noun.id)",
            "lsjx.$(noun.id)",
            replace(rmaccents(noun.label), r"ις$" =>  ""),
            lsjgender[noun.gen],
            "is_idos",
            accenttype(noun.label)   
            ]
            push!(nounlines, join(columns,"|"))
        else
            @warn("decl3is_idos: not a valid gender key |$(noun.gen)| in $(noun)")
        end
    end


    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl3is_idos.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end





function decl3hs_htos(v::Vector{MorphData}, registry, target; chunk = 100)
    nouns3 = filter(v) do d 
        stripped = rmaccents(d.label)
        rmaccents(d.itype) == "ητος" && 
        endswith(stripped,"ης") &&
        ! isempty(d.gen)
    end
    @info("Third decl. hs/htos: $(length(nouns3))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(nouns3)
        if i % chunk == 0
            @info("third-declension nouns hs/htos $(i)…")
        end

        if noun.gen in keys(lsjgender)
            columns = 
            [ "nounstems.$(noun.id)",
            "lsjx.$(noun.id)",
            replace(rmaccents(noun.label), r"ης$" =>  ""),
            lsjgender[noun.gen],
            "hs_htos",
            accenttype(noun.label)   
            ]
            push!(nounlines, join(columns,"|"))
        else
            @warn("decl3hs_htos: not a valid gender key |$(noun.gen)| in $(noun)")
        end
    end


    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl3hs_htos.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end


function decl3hr_hros(v::Vector{MorphData}, registry, target; chunk = 100)
    nouns3 = filter(v) do d 
        stripped = rmaccents(d.label)
        rmaccents(d.itype) == "ηρος" && 
        endswith(stripped,"ηρ") &&
        ! isempty(d.gen)
    end
    @info("Third decl. hr/hros: $(length(nouns3))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(nouns3)
        if i % chunk == 0
            @info("third-declension nouns hr/hros $(i)…")
        end

        if noun.gen in keys(lsjgender)
            columns = 
            [ "nounstems.$(noun.id)",
            "lsjx.$(noun.id)",
            rmaccents(noun.label),
            lsjgender[noun.gen],
            "0_os",
            accenttype(noun.label)   
            ]
            push!(nounlines, join(columns,"|"))
        else
            @warn("decl3hr_hros: not a valid gender key |$(noun.gen)| in $(noun)")
        end
    end


    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl3hr_hros.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end




function decl3as_ados(v::Vector{MorphData}, registry, target; chunk = 100)
    nouns3 = filter(v) do d 
        stripped = rmaccents(d.label)
        rmaccents(d.itype) == "αδος" && 
        endswith(stripped,"ας") &&
        ! isempty(d.gen)
    end
    @info("Third decl. as/ados: $(length(nouns3))")
    nounlines = ["StemUrn|LexicalEntity|Stem|Gender|InflClass|Accent|"]
    for (i, noun) in enumerate(nouns3)
        if i % chunk == 0
            @info("third-declension nouns as/ados $(i)…")
        end
        stemval = 
        if noun.itype == "άδος"
            stemval = replace(rmaccents(noun.label), r"ς$" =>  "")
            
        elseif noun.itype == "ᾶδος"
            stemval = replace(rmaccents(noun.label), r"ς$" =>  "_")
        end
        
        if noun.gen in keys(lsjgender)
            columns = 
            [ "nounstems.$(noun.id)",
            "lsjx.$(noun.id)",
            stemval,
            lsjgender[noun.gen],
            "as_ados",
            accenttype(noun.label)   
            ]
            push!(nounlines, join(columns,"|"))
        else
            @warn("decl3as_ados: not a valid gender key |$(noun.gen)| in $(noun)")
        end
    end


    registerednouns = filter(nounlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end

    nounfile = joinpath(target,"stems-tables", "nouns", "decl3as_ados.cex")
    open(nounfile,"w") do io
        write(io, join(registerednouns, "\n")  * "\n")
    end
end



"""Extract second-declension nouns from LSJ data and
write stems files to Kanones.
$(SIGNATURES)
"""
function decl3(v::Vector{MorphData}, registry, target; chunk = 100)
    nounstemsdir(target)
    @info("Total morph entries: $(length(v))")
   
    decl3ous(v,registry, target; chunk = chunk)
    decl3ma_matos(v,registry, target; chunk = chunk)
    decl3is_idos(v,registry, target; chunk = chunk)
    decl3hs_htos(v,registry, target; chunk = chunk)
    decl3hr_hros(v,registry, target; chunk = chunk)
    decl3as_ados(v,registry, target; chunk = chunk)
end