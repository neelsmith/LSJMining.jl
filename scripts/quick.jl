using LSJMining
src = "cex"
target = joinpath(pwd(), "kanonesdata","lsjx")
kroot = joinpath("..","greek2021","Kanones.jl")

v = loadmorphdata(src)


kanones(src, target, kroot)