#PREFIXES = readlines("compounding-prefixes.txt") .|> PG.nfkc

function prefixes() 
    keys(prefixdict ) .|> PG.nfkc
    #readlines("compounding-prefixes.txt") 
end


"""Split `s` into two parts using `rege`.
"""
function splitem(s,rege)
    replace(s, rege => s"\1-\2")
end

"""True if stem part of morpheme boundary exists in simplex list.
"""
function stemexists(s, striplist)
    cols = split(s,"-")
    breathless = stripbreathing(cols[end])
    breathless in striplist
end


function splitmorphemes(s, striplist)
    disjunction = join(sort(prefixes(), by=length, rev=true), "|")
    re = Regex("^($disjunction)(.+)")
    divided = splitem(s, re)
    if contains(divided,"-")
        @info("Split into ", divided)
        if stemexists(divided, striplist)
            divided
        else
            @info("Didn't find simplex.")
            pieces = split(divided,"-")

            shorter = filter(s -> length(s) < length(pieces[1]), prefixes())
            shorterdisjunction = join(sort(shorter, by = length, rev = true), "|")
            shortre =  Regex("^($shorterdisjunction)(.+)")
            subdivided = splitem(s, shortre)
            @info("Use", shortre)
            @info("Subdivided", subdivided)
            if stemexists(subdivided, striplist)
                subdivided
            else
                s
            end
        end
    else
        s
    end
end
