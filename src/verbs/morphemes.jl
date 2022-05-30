#PREFIXES = readlines("compounding-prefixes.txt") .|> PG.nfkc

function prefixes() 
    keys(prefixdict) .|> PG.nfkc
    #readlines("compounding-prefixes.txt") 
end


"""Split `s` into two parts using `rege`.
"""
function splitem(s,rege)
    replace(s, rege => s"\1#\2")
end

"""True if stem part of morpheme boundary exists in simplex list.
"""
function stemexists(s, striplist)
    @debug("Check", s)
    cols = split(s, "#")
    breathless = stripbreathing(cols[end])
    @debug("Breathless", breathless)
    breathless in striplist
end


function splitmorphemes(s, striplist; withfailure = false)
    success = ""
    failure = ""

    disjunction = join(sort(prefixes(), by=length, rev=true), "|")
    re = Regex("^($disjunction)(.+)")
    divided = splitem(s, re)
    if contains(divided,"#")
        @debug("Split into ", divided)
        if stemexists(divided, striplist)
            success = divided
        else
            @debug("Didn't find simplex for", divided)
            failure = divided
            pieces = split(divided,"#")

            shorter = filter(s -> length(s) < length(pieces[1]), prefixes())
            shorterdisjunction = join(sort(shorter, by = length, rev = true), "|")
            shortre =  Regex("^($shorterdisjunction)(.+)")
            subdivided = splitem(s, shortre)
            @debug("Use", shortre)
            
            if stemexists(subdivided, striplist)
                @debug("Subdivided", subdivided)
                success = replace(subdivided, r"^#" => "" )
            else
                @warn("Failed on both", divided, subdivided)
                failure = subdivided
                success = s
            end
        end
    else
        success = s
    end
    withfailure ? (success,failure) : success
end
