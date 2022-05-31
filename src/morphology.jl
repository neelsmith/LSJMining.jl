
"""Read morphological data from CEX  in `src`,
and write  tabular data files for Kanones to `target`.
Records will be filtered by Kanones' collection of
lexemes in local clone of Kanones in `kroot`.
$(SIGNATURES)
"""
function kanones(src, target, kroot)
    v = loadmorphdata(src)
    lsjx = registrycolumns(kroot)

    verbs(v, lsjx, target)
    # Rework these to filter on registry:
    #nouns(v, lsjx, target)
    #adjectives(v, lsjx, target)
end