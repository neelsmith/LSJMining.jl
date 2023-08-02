"""Use reasonable default settings to invoke
`kanones` function.
$(SIGNATURES)    
"""
function kanones()
    src = "cex"
    target = joinpath(pwd(), "kanonesdata", "lsjx")
    kroot = joinpath(dirname(pwd()), "Kanones.jl")
    kanones(src, target, kroot)
end

"""Read morphological data from CEX  in `src`,
and write  tabular data files for Kanones to `target`.
Records will be filtered by Kanones' collection of
lexemes in local clone of Kanones in `kroot`.
$(SIGNATURES)
"""
function kanones(src::AbstractString, target, kroot)
    v = loadmorphdata(src)
    kanones(v, target, kroot)
end

"""Use morphological data in `mdata`,
and write  tabular data files for Kanones to `target`.
Records will be filtered by Kanones' collection of
lexemes in local clone of Kanones in `kroot`.
$(SIGNATURES)
"""
function kanones(mdata::Vector{MorphData}, target, kroot)
    lsjx = registrycolumns(kroot)
    kanones(mdata, lsjx, target)
end

function kanones(mdata::Vector{MorphData}, lsjx::Vector{String}, target)

    #@info("Write verb stems")
    verbs(mdata, lsjx, target)

    # Rework these to filter on registry:
    nouns(mdata, lsjx, target)
    adjectives(mdata, lsjx, target)
end