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

#=
"""True if stem part of morpheme boundary exists in list
of simplex verbs with breathing removed.
"""
function stemexists(s, nobreathing)
    @debug("Check", s)
    cols = split(s, "#")
    breathless = stripbreathing(cols[end])
    @debug("Breathless", breathless)
    breathless in nobreathing
end
=#

"""Split the verb string `s` into morpheme units.
$(SIGNATURES)

# Members

- `breathsdict`: mapping of breathless forms to fully accented forms
"""
function splitmorphemes(s,  breathsdict; withfailure = false)
    success = ""
    failure = ""

    @debug("Splitting $(s)")
    disjunction = join(sort(prefixes(), by=length, rev=true), "|")
    re = Regex("^($disjunction)(.+)")
    divided = splitem(s, re)
    pieces = split(divided, "#")
    if contains(divided,"#")
        @debug("Split into ", divided)
        if haskey(breathsdict, pieces[end])
        #if stemexists(divided, breathless)
            success = divided
        else
            @debug("Didn't find simplex for", divided)
            failure = divided

            shorter = filter(s -> length(s) < length(pieces[1]), prefixes())
            shorterdisjunction = join(sort(shorter, by = length, rev = true), "|")
            shortre =  Regex("^($shorterdisjunction)(.+)")
            subdivided = splitem(s, shortre)
            @debug("Use", shortre)
            if haskey(breathsdict, pieces[end])
            #if stemexists(subdivided, striplist)
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
