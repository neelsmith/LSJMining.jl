using PolytonicGreek
const PG = PolytonicGreek



# Read all morphdata into `v`
# more than 20K omega entries!
omegas = filter(d -> endswith(d.label,"ω"),  v)
stripped = map(m -> lowercase(m.label) |> stripbreathing,  omegas)
ostrings = map(d -> d.label, omegas)

#splits = map(s -> splitem(s, re), ostrings)
splits = map(s -> splitmorphemes(s, stripped, withfailure = true), ostrings) 


checkthese = filter(pr -> !isempty(pr[2]) && ! contains(pr[1],"#"), splits)
open("failchecks.txt", "w") do io
    write(io, join(checkthese,"\n"))
end
length(checkthese)





nosplits = filter(s -> !contains(s,"-"), splits)
# MOre than 7800 have one of the listed prefixes
prefixed  = filter!(s -> contains(s, "-"), splits)

xreffed = filter(s -> stemexists(s, stripped), prefixed)
notfound = filter(s -> ! stemexists(s, stripped), prefixed)










##########################
simplex = map(s -> replace(s, r"[^\-]+\-" => ""), splits) |> unique |> sort

open("simplex.txt", "w") do io
    write(io, join(simplex, "\n"))
end


