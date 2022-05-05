# Add these classes to the vector as soon as Kanones rules
# are complete for that type:
#=
regularverbfilters = [
    vowelverb, liquidverb, stopverb, contractverb, izwverb, sigmaverb, numiverb, irregmiverb, irregomega
]
=#
regularverbtypes = [
    "stopverb"
]


verbfilters = Dict(
    "stopverb" => stopverb,
    "vowelverb" => vowelverb, 
    "liquidverb" => liquidverb, 
    #"econtract" => econtract,
    #"acontract" => acontract,
    #ocontract" => ocontract,
    "izwverb" => izwverb, 
    "sigmaverb" => sigmaverb, 
    "numiverb" => numiverb
    #irregmiverb, irregomega
)

infltypemap = Dict(
    "stopverb" => "w_regular"
)
function trimlemma(s::AbstractString, verbtype::AbstractString)
    if verbtype == "stopverb"
        replace(s, r"ω$" => "") |> rmaccents
    end
end

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
