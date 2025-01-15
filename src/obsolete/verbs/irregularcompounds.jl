stemiddict = Dict(
nfkc("ίημι") => "n50165",
nfkc("τίθημι") => "n103922",
nfkc("δίδωμι") => "n26447",
nfkc("ίστημι") => "n51241"
)


xscriptdict = Dict(
nfkc("ίημι") => "hiemi",
nfkc("τίθημι") => "tiqemi",
nfkc("δίδωμι") => "didomi",
nfkc("ίστημι") => "histemi"
)


function writecompoundirregulars(
    verblines,   
    kdataset::AbstractString)
    verbfile = joinpath(kdataset,"irregular-stems", "verbs-compound", "compoundirregulars.cex")
    @info("Writing compounds of irregular verbs to file",verbfile)
    open(verbfile,"w") do io
        write(io, join(verblines, "\n") * "\n")
    end
end

function compoundirregulars(morphdata::Vector{MorphData}, registry, target::AbstractString)
    compoundlines = []
    for basevrb in keys(xscriptdict)
        compoundmatches = filter(morphdata) do m
            endswith(m.lemma, basevrb) && m.id != stemiddict[basevrb]
        end
        # FILTER FOR ENTRIES IN LSJ INVENTORY!
        for v in compoundmatches
            prefixed = string(replace(v.lemma, basevrb => ""), "#", basevrb)
            prefix = replace(v.lemma, basevrb => "")
            columns = 
            [ "compounds.$(v.id)",
            "lsjx.$(v.id)",
            prefix,
            string("lsjx.", stemiddict[basevrb]),
            prefixed
            ]
            push!(compoundlines, join(columns,"|") * "|")
        end
    end

    writecompoundirregulars(
        compoundlines, target
    )
    
end

#=

function verbsfortype(v::Vector{MorphData}, 
    vtype::AbstractString, ortho = literaryGreek())


   f = verbfilters[vtype]
    mdata = filter(d -> f(d), v)
    @info("""Regular verb type "$(f)": $(length(mdata)) verbs to analyze""")

    lemmastrings = map(d -> d.label, mdata)
    breathingdict = Dict()
    for s in lemmastrings
        stripped = rmbreathing(s,ortho)
        breathingdict[stripped] = s
    end
    splits = map(s -> splitmorphemes(s, breathingdict,  withfailure = true), lemmastrings) 

    simplex = filter(pr -> ! contains(pr[1],"#") &&  isempty(pr[2]), splits )
    compounds = filter(pr -> contains(pr[1],"#"), splits )
    uncertain = filter(pr -> ! isempty(pr[2]) && !contains(pr[1],"#"), splits )

    simplexlines = ["Rule|LexicalEntity|Stem|StemClass"]
    for (i, pr) in enumerate(simplex)
        if i % 1000 == 0
            @info("Simplex stem $(i)…")
        end
        @debug("SIMPLEX: ", pr[1])
        @debug("In breathing dict?: ", pr[1] in values(breathingdict))

        verb = lookup(pr[1], mdata)
        if ! isnothing(verb)
            columns = 
            [ "verbstems.$(verb.id)",
            "lsjx.$(verb.id)",
            trimlemma(verb.label, vtype),
            infltypemap[vtype]
            ]
            push!(simplexlines, join(columns,"|"))
        end
=#