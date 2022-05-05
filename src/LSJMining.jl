module LSJMining
using LexiconMining
using PolytonicGreek, Orthography
using Unicode

# Too hard to type:
const PG = PolytonicGreek


using Documenter, DocStringExtensions
include("utils.jl")
include("phonology.jl")


include("nouns/decl2.jl")

include("adjs/firstsecond.jl")

include("verbs/regular.jl")
include("verbs/prefixes.jl")
include("verbs/morphemes.jl")
include("verbs/verbs.jl")

export loadmorphdata

export decl2
export adjs1_2
export verbs


export vowelverb, liquidverb, stopverb, contractverb, izwverb, sigmaverb, numiverb, irregmiverb, irregomega

export stripbreathing
export splitmorphemes

end # module

