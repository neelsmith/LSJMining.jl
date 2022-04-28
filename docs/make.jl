# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'julia -e 'using LiveServer; serve(dir="docs/build")' 
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using LexiconMining


makedocs(
    sitename="LSJMining.jl",
    pages = [
        "User's guide" => Any[
            "Overview" => "index.md",
        ]
    ],
    )

deploydocs(
    repo = "github.com/neelsmith/LSJMining.jl.git",
)
