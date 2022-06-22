const LABIALS = split("βπφ","")
const DENTALS = split("δτθ","")
const PALATALS = split("γκχ","")
const STOPS = vcat(LABIALS, DENTALS, PALATALS)

const LIQUIDS = split("λρμν","")

const SIGMAS = split("σζψξ","")

const CONTRACTING = [PG.nfkc("έω"), PG.nfkc("άω"), PG.nfkc("όω")]
const NONCONTRACTING = split( "ιυηω" ,"")

"""True if label for `m` is a vowel-stem verb pattern.
"""
function vowelverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        endswith(s,"ω") && 
        isempty(m.gen) && 
        Unicode.normalize(string(s[start]), stripmark = true) in  NONCONTRACTING
    else
        false
    end
end


"""True if label for `m` is a liquid verb pattern.
"""
function liquidverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        endswith(s,"ω") && 
        isempty(m.gen) && 
        string(s[start]) in  LIQUIDS
    else
        false
    end
end


"""True if label for `m` is a stop verb pattern.
"""
function stopverb(m::MorphData)
    if skwverb(m)
        false
    else
        s = m.label
        cpindexes = collect(eachindex(s))
        if length(cpindexes)  > 2
            start = cpindexes[end-1]
            endswith(s,"ω") && 
            isempty(m.gen) &&
            string(s[start]) in  STOPS
        else
            false
        end
    end
end

"""True if label for `m` is a contract verb pattern.
"""
function contractverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        endswith(m.label, "ω") &&
        isempty(m.gen) &&
        s[start:end] in CONTRACTING
    else
        false
    end
end

"""True if label for `m` is a regular verb pattern in -ίζω.
"""
function azwverb(m::MorphData)
    endswith(m.label, PG.nfkc("άζω"))
end

"""True if label for `m` is a regular verb pattern in -ίζω.
"""
function ttwverb(m::MorphData)
    endswith(m.label, PG.nfkc("ττω"))
end

"""True if label for `m` is a regular verb pattern in -ίζω.
"""
function izwverb(m::MorphData)
    endswith(m.label, PG.nfkc("ίζω"))
end

"""True if label for `m` is a regular verb pattern in -έω.
"""
function econtractverb(m::MorphData)
    endswith(m.label, PG.nfkc("έω"))
end


"""True if label for `m` is a regular verb pattern in -άω.
"""
function acontractverb(m::MorphData)
    endswith(m.label, PG.nfkc("άω"))
end

"""True if label for `m` is a regular verb pattern in -έω.
"""
function ocontractverb(m::MorphData)
    endswith(m.label, PG.nfkc("όω"))
end



"""True if label for `m` is a regular verb pattern in -έω.
"""
function skwverb(m::MorphData)
    endswith(m.label, PG.nfkc("σκω"))
end


"""True if label for `m` is a stop verb pattern.
"""
function sigmaverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        endswith(s,"ω") && 
        isempty(m.gen) &&
        ! izwverb(m) &&
        string(s[start]) in SIGMAS
    else
        false
    end
end


"""True if label for `m` is a regular verb pattern in -νυμι.
"""
function numiverb(m::MorphData)
    endswith(m.label, "νυμι") &&
    isempty(m.gen)
end


"""True if label for `m` is an iregular -μι verb pattern.
"""
function irregmiverb(m::MorphData)
    endswith(m.label, "μι") &&
     ! endswith(m.label,"νυμι") && 
     isempty(m.gen)
end


"""True if label for `m` is an iregular -ω verb pattern.
"""
function irregomega(m::MorphData)
    endswith(m.label, "ω") && 
    isempty(m.gen) && 
    ! vowelverb(m) &&
    ! liquidverb(m) &&
    ! stopverb(m) &&
    ! contractverb(m)  &&
    ! izwverb(m) &&
    ! azwverb(m) &&
    ! ttwverb(m) &&
    ! sigmaverb(m) &&
    ! skwverb(m) &&

    ! stopverbdep(m) &&
    ! vowelverbdep(m) &&
    ! econtractdep(m) &&
    ! acontractdep(m) &&
    ! ocontractdep(m) &&
    ! izwverbdep(m) &&
    ! azwverbdep(m) &&
    ! ttwverbdep(m) &&
    ! sigmaverbdep(m) &&
    ! skwverbdep(m)
end