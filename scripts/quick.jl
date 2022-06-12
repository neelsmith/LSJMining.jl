using LSJMining
src = "cex"
v = loadmorphdata(src)


target = joinpath(pwd(), "kanonesdata","lsjx")
kroot = joinpath("..","greek2021","Kanones.jl")




kanones(src, target, kroot)