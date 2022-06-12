"Verb patterns to quarry from LSJ."
regularverbtypes = [
    "stopverb",
    "vowelverb" , 
    "liquidverb", 
    "econtract" ,
    "acontract",
    "ocontract" ,
    "izwverb" , 
    "sigmaverb" , 
    "skwverb",
    "numiverb"
]


deponentverbtypes = [
    "stopverbdep",
    "vowelverbdep" , 
    "econtractdep" ,
    "acontractdep",
    "ocontractdep" ,
    "izwverbdep" , 
    "sigmaverbdep" , 
    "skwverbdep",
    "numiverbdep"
]

"Boolean filtering function to use for each LSJ verb pattern."
verbfilters = Dict(
    "stopverb" => stopverb,

    "vowelverb" => vowelverb, 
    "liquidverb" => liquidverb, 
    "econtract" => econtractverb,
    "acontract" => acontractverb,
    "ocontract" => ocontractverb,
    "izwverb" => izwverb, 
    "sigmaverb" => sigmaverb, 
    "skwverb" => skwverb,
    "numiverb" => numiverb,
    # deponents
    "stopverbdep" => stopverbdep,
    "vowelverbdep" => vowelverbdep,
    "econtractdep" => econtractdep,
    "acontractdep" => acontractdep,
    "ocontractdep" => ocontractdep,
    "izwverbdep" => izwverbdep,
    "sigmaverbdep" => sigmaverbdep,
    "skwverbdep" => skwverbdep,
    "numiverbdep" => numiverbdep
)

"Mapping of LSJ verb pattern to Kanones inflectional class."
infltypemap = Dict(
    "stopverb" => "w_pp1",
   
    "vowelverb" => "w_regular", 
    "liquidverb" => "w_pp1", 
    "econtract" => "ew_contract",
    "acontract" => "aw_contract",
    "ocontract" => "ow_contract",
    "izwverb" => "izw", 
    "sigmaverb" => "w_pp1", 
    "skwverb" => "skw",
    "numiverb" => "numi",




    "stopverbdep" => "w_pp1_dep",
   
    "vowelverbdep" => "w_regular_dep", 
    "liquidverbdep" => "w_pp1_dep", 
    "econtractdep" => "ew_contract_dep",
    "acontractdep" => "aw_contract_dep",
    "ocontractdep" => "ow_contract_dep",
    "izwverbdep" => "izw_dep", 
    "sigmaverbdep" => "w_pp1_dep", 
    "skwverbdep" => "skw_dep",
    "numiverbdep" => "numi_dep"
)

"""Create Kanones stem from LSJ lemma."""
function trimlemma(s::AbstractString, verbtype::AbstractString)
    @debug("s, verbtype",s,verbtype)
    
    if (verbtype == "stopverb") || (verbtype == "vowelverb") || (verbtype == "sigmaverb") || (verbtype == "liquidverb")
        replace(s, r"ω$" => "") |> rmaccents
    elseif verbtype == "econtract"
        replace(s, r"έω$" => "") |> rmaccents
    elseif verbtype == "acontract"
        replace(s, r"άω$" => "") |> rmaccents
    elseif verbtype == "ocontract"
        replace(s, r"όω$" => "") |> rmaccents
    elseif verbtype == "izwverb"
        replace(s, r"ίζω$" => "ι") |> rmaccents
    elseif verbtype == "numiverb"
        replace(s, r"νυμι$" => "") |> rmaccents
    elseif verbtype == "skwverb"
        replace(s, r"σκω$" => "") |> rmaccents

    elseif (verbtype == "stopverbdep") || (verbtype == "vowelverbdep") || (verbtype == "sigmaverbdep") || (verbtype == "liquidverbdep")
            replace(s, r"ομαι$" => "") |> rmaccents
    elseif verbtype == "econtractdep"
        replace(s, r"έομαι$" => "") |> rmaccents
    elseif verbtype == "acontractdep"
        replace(s, r"άομαι$" => "") |> rmaccents
    elseif verbtype == "ocontractdep"
        replace(s, r"όομαι$" => "") |> rmaccents
    elseif verbtype == "izwverbdep"
        replace(s, r"ίζομαι$" => "ι") |> rmaccents
    elseif verbtype == "numiverbdep"
        replace(s, r"νυμαι$" => "") |> rmaccents
    elseif verbtype == "skwverb"
        replace(s, r"σκομαι$" => "") |> rmaccents



    else

    end
    
end


"""Find morphological data in `v` for ID value `s`.
($SIGNATURES)
"""
function lookup(s::AbstractString, v::Vector{MorphData})
    matches = filter(m -> m.label == s, v)
    @debug("Lookup filtered $(s)")
    if isempty(matches)
        @warn("No match for label $(s)")
        nothing
    elseif length(matches) > 1
        @warn("Multiple matches for label $(s). Omitting.")
        nothing
    
    else
        matches[1]
    end

end


"""Extract all verbs from LSJ and write stems to a Kanones
data set.
$(SIGNATURES)
"""
function writesimplexverbs(
    verblines,   
    vtype::AbstractString, 
    kdataset::AbstractString)
    verbfile = joinpath(kdataset,"stems-tables", "verbs-simplex", "$(vtype).cex")
    @info("Writing simplex verbs to file")
    open(verbfile,"w") do io
        write(io, join(verblines, "\n"))
    end
end


function writecompoundverbs(
    verblines,   
    vtype::AbstractString, 
    kdataset::AbstractString)
    verbfile = joinpath(kdataset,"stems-tables", "verbs-compound", "$(vtype).cex")
    @info("Writing compound verbs to file $(verbfile)")
    open(verbfile,"w") do io
        write(io, join(verblines, "\n"))
    end
end


"""Compose Kanones data lines for both simplex and compound verbs of type `vtype` .
$(SIGNATURES)
"""
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
    end

    compoundlines = ["Stem|LexicalEntity|Prefix|Simplex|Note"]
    # e.g.:
    # compounds.n30252|lsj.n30252|ἐν|lsj.n56496|ἐγκελεύω

    for (i, pr) in enumerate(compounds)
        if i % 1000 == 0
            @info("Compound stem $(i)…")
        end

        compstring = pr[1]
        pieces = split(compstring,"#")
        restored = replace(compstring, "#" => "")
        @debug("Restored: ", restored)
        verb = lookup(restored, mdata)
        rootverb = lookup(breathingdict[pieces[2]], mdata)
        @debug("Tried looking up rootverb/verb", rootverb, verb)
        if ! isnothing(verb) && ! isnothing(rootverb)
            columns = 
            [ "compounds.$(verb.id)",
            "lsjx.$(verb.id)",
            pieces[1],
            "lsjx.$(rootverb.id)",
            restored
            ]
            push!(compoundlines, join(columns,"|"))
        end
    end

    @info("\n\n")
    @info("Totals examined for type $(vtype)")
    @info("====== ======== ==== " * repeat("=", length(vtype)))
    @info("Compound verb entries:", length(compounds))
    @info("Simplex verb entries:", length(simplex))
    @info("Stems with uncertain morpheme boundaries: ",length(uncertain))
    @info("Out of $(length(mdata)) stems, total analyzed:", length(compounds) + length(simplex) + length(uncertain))
    @info("\n")
    @info("Total kept:")
    @info("----- ----")
    @info("$(length(simplexlines)) simplex verbs")
    @info("$(length(compoundlines)) compound verbs")
    @info("\n")
    (simplexlines, compoundlines)
end


function fullregularverbs(v::Vector{MorphData}, 
    registry, target::AbstractString)

    for vtype in regularverbtypes
        @info("Processing verbs of type $(vtype)")
        (simplexresults, compoundresults) = verbsfortype(v, vtype)
        registeredsimplex = filter(simplexresults) do ln
            cols = split(ln, "|")
            "|$(cols[2])|" in registry
        end
        writesimplexverbs(registeredsimplex, vtype, target)

        registeredcompounds = filter(compoundresults) do ln
            cols = split(ln, "|")
            "|$(cols[2])|" in registry
        end
        writecompoundverbs(
            registeredcompounds, vtype, target
            )
    end
end



function regulardeponentverbs(v::Vector{MorphData}, 
    registry, target::AbstractString)

    for vtype in deponentverbtypes
        @info("Processing verbs of type $(vtype)")
        (simplexresults, compoundresults) = verbsfortype(v, vtype)
        @info("Got $(length(simplexresults)) simplex verbs")
        registeredsimplex = filter(simplexresults) do ln
            cols = split(ln, "|")
            "|$(cols[2])|" in registry
        end
        writesimplexverbs(registeredsimplex, vtype, target)

        registeredcompounds = filter(compoundresults) do ln
            cols = split(ln, "|")
            "|$(cols[2])|" in registry
        end
        writecompoundverbs(
            registeredcompounds, vtype, target
            )
    end
end


"""Extract all verbs from LSJ and format delimited-text representation for Kanones.
$(SIGNATURES)
"""
function verbs(v::Vector{MorphData}, 
    registry, target::AbstractString)

    fullregularverbs(v,registry,target)
    regulardeponentverbs(v,registry,target)
    
end
