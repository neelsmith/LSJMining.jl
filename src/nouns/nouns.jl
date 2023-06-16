
function nouns(v::Vector{MorphData}, registry::Vector{String}, target; chunk = 100)
    decl1(v, registry, target; chunk = chunk)
    decl2(v, registry, target; chunk = chunk)
    decl3(v, registry, target; chunk = chunk)
end