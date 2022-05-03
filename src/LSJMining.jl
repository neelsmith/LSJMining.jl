module LSJMining
using LexiconMining
using PolytonicGreek
const PG = PolytonicGreek
using Unicode

include("utils.jl")
include("nouns/decl2.jl")
include("adjs/firstsecond.jl")
include("verbs/regular.jl")

export decl2
export adjs1_2


export vowelverb, liquidverb, stopverb, contractverb, izwverb, numiverb, irregmiverb, irregomega

end # module

