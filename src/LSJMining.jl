module LSJMining
using LexiconMining
using PolytonicGreek
const PG = PolytonicGreek
using Unicode

include("utils.jl")
include("phonology.jl")


include("nouns/decl2.jl")

include("adjs/firstsecond.jl")

include("verbs/regular.jl")
include("verbs/prefixes.jl")
include("verbs/morphemes.jl")
include("verbs/verbs.jl")

export decl2
export adjs1_2
export verbs


export vowelverb, liquidverb, stopverb, contractverb, izwverb, sigmaverb, numiverb, irregmiverb, irregomega

export stripbreathing
export splitmorphemes

end # module

