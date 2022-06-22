
"""Extract three-ending 1st-2nd declension adjectives from `v`
and write a stems table to the Kanones dataset in `target`.
$(SIGNATURES)
"""
function adjs1_2(v::Vector{MorphData}, registry, target)
    adjstemsdir(target)

    adjs = filter(d ->  (d.itype == "ή" || d.itype == "η") && isempty(d.gen),  v)
   
    @info("First-second decl. adjs to format: $(length(adjs))")


    adjlines = ["StemUrn|LexicalEntity|Stem|InflClass|Accent"]
    for (i, adj) in enumerate(adjs)
        if i % 100 == 0
            @info("$(i)…")
        end
        #adjstems.n17907a|lsj.n17907|αὐτ|os_h_on_pos|inflectionaccented|
        columns = 
        [ "adjstems.$(adj.id)",
        "lsjx.$(adj.id)",
        replace(rmaccents(adj.label), r"ος$" =>  ""),
        "os_h_on",
        accenttype(adj.label)   
        ]
        push!(adjlines, join(columns,"|"))
    end

    registeredadjs = filter(adjlines) do ln
        cols = split(ln, "|")
        "|$(cols[2])|" in registry
    end



    adjfile = joinpath(target,"stems-tables", "adjectives", "first-second.cex")
    open(adjfile,"w") do io
        write(io, join(registeredadjs, "\n")  * "\n")
    end

end