module LSJMining
using LexiconMining
using PolytonicGreek, Orthography
using Unicode

# Too hard to type:
const PG = PolytonicGreek


using Documenter, DocStringExtensions
include("utils.jl")
include("phonology.jl")


include("nouns/decl1.jl")
include("nouns/decl2.jl")
include("nouns/decl3.jl")
include("nouns/nouns.jl")

include("adjs/firstsecond.jl")
include("adjs/adjectives.jl")

include("verbs/regular.jl")
include("verbs/prefixes.jl")
include("verbs/morphemes.jl")
include("verbs/deponents.jl")
include("verbs/verbs.jl")
include("verbs/irregularcompounds.jl")

include("profilingutils.jl")
include("morphology.jl")

export kanones, loadmorphdata

export decl2
export adjs1_2
export verbs, nouns, adjectives


export vowelverb, liquidverb, stopverb, contractverb, izwverb, sigmaverb, numiverb, irregmiverb, irregomega

export stripbreathing
export splitmorphemes
export profile_endings

end # module

