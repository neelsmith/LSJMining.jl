
function decl2(v::Vector{MorphData}, target)
    @info("Total morph entries: $(length(v))")
    mnouns = filter(d -> isempty(d.itype) && d.gen == "ὁ", v)
    @info("Second decl. masc. nouns: $(length(mnouns))")
end