
"""True if label for `m` is a vowel-stem verb pattern.
"""
function vowelverbdep(m::MorphData)
    s = m.label
    
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 4
        start = cpindexes[end-4]
        keep = endswith(s,"ομαι") && 
        isempty(m.gen) && 
        Unicode.normalize(string(s[start]), stripmark = true) in  NONCONTRACTING

        startchar = Unicode.normalize(string(s[start]), stripmark = true)
        if keep
            @debug("startchar in for", startchar,  s)
        end
        keep
    else
        false
    end
end


"""True if label for `m` is a liquid verb pattern.
"""
function liquidverbdep(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 4
        start = cpindexes[end-4]
        endswith(s,"ομαι") && 
        isempty(m.gen) && 
        string(s[start]) in  LIQUIDS
    else
        false
    end
end


"""True if label for `m` is a stop verb pattern.
"""
function stopverbdep(m::MorphData)
    if skwverb(m)
        false
    else
        s = m.label
        cpindexes = collect(eachindex(s))
        if length(cpindexes)  > 4
            start = cpindexes[end-4]
            endswith(s,"ομαι") && 
            isempty(m.gen) &&
            string(s[start]) in  STOPS
        else
            false
        end
    end
end

"""True if label for `m` is a regular verb pattern in -ίζομαι.
"""
function izwverbdep(m::MorphData)
    endswith(m.label, PG.nfkc("ίζομαι"))
end


"""True if label for `m` is a regular verb pattern in -άζομαι.
"""
function azwverbdep(m::MorphData)
    endswith(m.label, PG.nfkc("άζομαι"))
end



"""True if label for `m` is a regular verb pattern in -ττομαι.
"""
function ttwverbdep(m::MorphData)
    endswith(m.label, PG.nfkc("ττομαι"))
end

"""True if label for `m` is a regular verb pattern in -έω.
"""
function econtractdep(m::MorphData)
    endswith(m.label, PG.nfkc("έομαι"))
end


"""True if label for `m` is a regular verb pattern in -άω.
"""
function acontractdep(m::MorphData)
    endswith(m.label, PG.nfkc("άομαι"))
end

"""True if label for `m` is a regular verb pattern in -έω.
"""
function ocontractdep(m::MorphData)
    endswith(m.label, PG.nfkc("όομαι"))
end



"""True if label for `m` is a regular verb pattern in -έω.
"""
function skwverbdep(m::MorphData)
    endswith(m.label, PG.nfkc("σκομα"))
end


"""True if label for `m` is a stop verb pattern.
"""
function sigmaverbdep(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 4
        start = cpindexes[end-4]
        endswith(s,"ομαι") && 
        isempty(m.gen) &&
        ! izwverb(m) &&
        string(s[start]) in SIGMAS
    else
        false
    end
end


"""True if label for `m` is a regular verb pattern in -νυμι.
"""
function numiverbdep(m::MorphData)
    endswith(m.label, "νυμαι") &&
    isempty(m.gen)
end


"""True if label for `m` is an iregular -μι verb pattern.
"""
function irregmiverb(m::MorphData)
    endswith(m.label, "μι") &&
     ! endswith(m.label,"νυμι") && 
     isempty(m.gen)
end

