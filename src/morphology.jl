
"""Read morphological data from CEX  in `src`,
and write  tabular dagta files for Kanones to `target`.
Records will be filtered by Kanones' collection of
lexemes in local clone of Kanones in `kroot`.
$(SIGNATURES)
"""
function kanones(src,target,kroot)
    v = loadmorphdata(src, kroot)
    verbs(v, target)
    nouns(v, target)
    adjectives(v, target) # HANGING IN omega!
end