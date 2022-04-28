using PolytonicGreek
const PG = PolytonicGreek

prefixes = readlines("compounding-prefixes.txt") .|> PG.nfkc
disjunction = join(sort(prefixes, by=length, rev=true), "|")
re = Regex("^($disjunction)(.+)")

function splitem(s)
    replace(s, re => s"\1-\2")
end


vrb = "προσπαραδίδωμι"
splitem(vrb)

# Read all morphdata into `v`
# more than 20,500 omega entries!
omegas = filter(d -> endswith(d.label,"ω") && isempty(d.itype),  v)
ostrings = map(d -> d.label, omegas)
splits = ostrings .|> splitem
nosplits = filter(s -> !contains(s,"-"), splits)
# MOre than 7800 have one of the listed prefixes
filter!(s -> contains(s, "-"), splits)