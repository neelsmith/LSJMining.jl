repo = pwd()
using Pkg
Pkg.activate(repo)
Pkg.resolve()
Pkg.instantiate()
using LexiconMining

basedir = joinpath(pwd(), "sourcedata")
xml = []
for i in collect(1:27)
    f = joinpath(basedir, "lsj_$(i).cex")
    append!(xml, readlines(f))
end

