const LABIALS = split("βπφ","")
const DENTALS = split("δτθ","")
const PALATALS = split("γκχ","")
const STOPS = vcat(LABIALS, DENTALS, PALATALS)

const LIQUIDS = split("λρμν","")

const CONTRACTING = [PG.nfkc("έω"), PG.nfkc("άω"), PG.nfkc("όω")]
const NONCONTRACTING = split( "ιυηω" ,"")

"""True if label for `m` is a vowel-stem verb pattern.
"""
function vowelverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        endswith(s,"ω") && Unicode.normalize(string(s[start]), stripmark = true) in  NONCONTRACTING
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
        endswith(s,"ω") && string(s[start]) in  LIQUIDS
    else
        false
    end
end


"""True if label for `m` is a stop verb pattern.
"""
function stopverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        endswith(s,"ω") && string(s[start]) in  STOPS
    else
        false
    end
end

"""True if label for `m` is a contract verb pattern.
"""
function contractverb(m::MorphData)
    s = m.label
    cpindexes = collect(eachindex(s))
    if length(cpindexes)  > 2
        start = cpindexes[end-1]
        s[start:end] in  CONTRACTING
    else
        false
    end
end


"""True if label for `m` is a regular verb pattern in -νυμι.
"""
function numiverb(m::MorphData)
    endswith(m.label, "νυμι")
end


"""True if label for `m` is an iregular -μι verb pattern.
"""
function irregmiverb(m::MorphData)
    endswith(m.label, "μι") && endswith(m.label,"νυμι") == false && isempty(m.gen)
end