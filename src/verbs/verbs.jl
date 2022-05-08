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
    "numiverb"
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
    "numiverb" => numiverb
    #irregmiverb, irregomega
)


"Mapping of LSJ verb pattern to Kanones inflectional class."
infltypemap = Dict(
    "stopverb" => "w_regular",
   
    "vowelverb" => "w_regular", 
    "liquidverb" => "w_pp1", 
    "econtract" => "ew_contract",
    "acontract" => "aw_contract",
    "ocontract" => "aw_contract",
    "izwverb" => "izw", 
    "sigmaverb" => "w_pp1", 
    "numiverb" => "numi"
)

"""Create Kanones stem from LSJ lemma."""
function trimlemma(s::AbstractString, verbtype::AbstractString)
    @info("s, verbtype",s,verbtype)
    
    if (verbtype == "stopverb") || (verbtype == "vowelverb") || (verbtype == "sigmaverb") || (verbtype == "liquidverb")
        replace(s, r"ω$" => "") |> rmaccents
    elseif verbtype == "econtract"
        replace(s, r"έω$" => "") |> rmaccents
    elseif verbtype == "acontract"
        replace(s, r"άω$" => "") |> rmaccents
    elseif verbtype == "oontract"
        replace(s, r"όω$" => "") |> rmaccents
    elseif verbtype == "izw"
        replace(s, r"ίζω$" => "") |> rmaccents
    elseif verbtype == "numiverb"
        replace(s, r"νυμι$" => "") |> rmaccents
    else

    end
    
end


"""Find morphological data in `v` for ID value `s`.
($SIGNATURES)
"""
function lookup(s::AbstractString, v::Vector{MorphData})
    matches = filter(m -> m.label == s, v)
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


"""Extract all verbs from LSJ and write stems to Kanones
data set.
$(SIGNATURES)
"""
function verbs(v::Vector{MorphData}, target)
    for vtype in regularverbtypes
        f = verbfilters[vtype]
        mdata = filter(d -> f(d), v)
        @info("""Regular verb type "$(f)": $(length(mdata)) verbs to analyze""")

        stripped = map(m -> lowercase(m.label) |> stripbreathing,  mdata)
        lemmastrings = map(d -> d.label, mdata)
        splits = map(s -> splitmorphemes(s, stripped, withfailure = true), lemmastrings) 

        compounds = filter(pr -> contains(pr[1],"#"), splits )
        simplex = filter(pr -> ! contains(pr[1],"#") &&  isempty(pr[2]), splits )
        uncertain = filter(pr -> ! isempty(pr[2]) && !contains(pr[1],"#"), splits )
        @info("Compound verb entries:", length(compounds))
        @info("Simplex verb entries:", length(simplex))
        @info("Stems with uncertain morpheme boundaries: ",length(uncertain))
        @info("Out of $(length(mdata)) stems, total analyzed:", length(compounds) + length(simplex) + length(uncertain))

        simplexlines = ["Rule|LexicalEntity|Stem|StemClass"]
        for (i, pr) in enumerate(simplex)
            if i % 100 == 0
                @info("$(i)...")
            end

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
        verbfile = joinpath(target,"stems-tables", "verbs-simplex", "$(vtype).cex")
        @info("Writing simplex verbs to file")
        open(verbfile,"w") do io
            write(io, join(simplexlines, "\n"))
        end

        @warn("Compound verbs not yet recorded")
    end
end
