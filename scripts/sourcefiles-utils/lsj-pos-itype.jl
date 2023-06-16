repo = pwd()
using Pkg
Pkg.activate(repo)
Pkg.resolve()
Pkg.instantiate()



basedir = joinpath(pwd(), "cex")
v = Vector{MorphData}()
for i in collect(1:27)
    f = joinpath(basedir, "morphdata_$(i).cex")
    append!(v, readlines(f) .|> morphData)
end

target = joinpath(pwd(), "cex", "pos-itype-pairs-bycount.cex")

freqtab = pos_itype_counts(v)
open(target, "w") do io
    write(io,join(freqtab,"\n"))
end