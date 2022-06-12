using LSJMining
src = "cex"
v = loadmorphdata(src)
target = joinpath(pwd(), "kanonesdata","lsjx")
kroot = joinpath("..","Kanones.jl")


kanones(v, target, kroot)