
"""Read morphological data from CEX  in `src`,
and write  tabular data files for Kanones to `target`.
Records will be filtered by Kanones' collection of
lexemes in local clone of Kanones in `kroot`.
$(SIGNATURES)
"""
function kanones(src::AbstractString, target, kroot)
    v = loadmorphdata(src)
    lsjx = registrycolumns(kroot)

    verbs(v, lsjx, target)
    # Rework these to filter on registry:
    #nouns(v, lsjx, target)
    #adjectives(v, lsjx, target)
end


function kanones(mdata::Vector{MorphData}, target, kroot)
    lsjx = registrycolumns(kroot)
    @info("Write verb stems")
    verbs(mdata, lsjx, target)
end