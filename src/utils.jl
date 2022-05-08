
"""Load morphology data from files in `cex` directory
of repository, and filter for entries with valid orthography
only.
$(SIGNATURES)
"""
function loadmorphdata(cexdir, kroot = joinpath("..", "Kanones.jl"))
    ortho = literaryGreek()
    v = Vector{MorphData}()
    for i in collect(1:27)
        f = joinpath(cexdir, "morphdata_$(i).cex")
        mdata = readlines(f)[2:end] .|> morphData
        for (i,m) in enumerate(mdata)
            if i % 100 == 0
                @info("$(i)...")
            end
            if validstring(m.label, ortho)
                push!(v, m)
            elseif validstring(tidier(m.label), ortho)
                
                morph = MorphData(
                    m.id,
                    tidier(m.label),
                    m.lemma,
                    m.pos,
                    m.itype,
                    m.gen,
                    m.mood
                )
                push!(v, morph)
            else
                @warn("Invalid string:", m.label)
            end
        end
    end
    lsj = registry(kroot)
    unregistered(v, lsj)
end


function registry(kroot = joinpath("..", "Kanones.jl"))
    f = joinpath(kroot, "datasets", "lsj-vocab", "lexemes", "lsj.cex")
    data = readlines(f)[2:end]
    idlist = []
    for ln in filter(l -> !isempty(l), data)
        cols = split(ln,"|")
        pieces = split(cols[1],".")
        push!(idlist, pieces[2] )
    end
    idlist
end

function unregistered(v::Vector{MorphData}, lsj)
  filter(d -> (d.id in lsj) == false, v)
end

"""Find and create if necessary stems directory for
adjectives for the Kanones dataset in `target`.
$(SIGNATURES)
"""
function adjstemsdir(target)
    if ! isdir(joinpath(target, "stems-tables"))
        mkdir(joinpath(target, "stems-tables"))
    end
    if !isdir(joinpath(target, "stems-tables", "adjectives"))
        mkdir(joinpath(target, "stems-tables", "adjectives"))
    end
end


"""Find and create if necessary stems directory for
nouns for the Kanones dataset in `target`.
$(SIGNATURES)
"""
function nounstemsdir(target)
    if ! isdir(joinpath(target, "stems-tables"))
        mkdir(joinpath(target, "stems-tables"))
    end
    if !isdir(joinpath(target, "stems-tables", "nouns"))
        mkdir(joinpath(target, "stems-tables", "nouns"))
    end
end


"""Find LSJMining's string key word for accent type.
$(SIGNATURES)
"""
function accenttype(s::AbstractString)
    if lg_accentedsyll(s) == :UNACCENTED
        nothing
    elseif lg_accentedsyll(s) == :ULTIMA
        "inflectionaccented"
    elseif lg_accentedsyll(s) == :PENULT
        "stemaccented"
    elseif lg_accentedsyll(s) == :ANTEPENULT
        "recessive"
    end
end


"""Remove erroneous diacritics 
for orthographic validation.
$(SIGNATURES)
"""
function tidier(s) 
    cleaner = replace(s, r"[ᾰᾱ]" => "α")
    cleaner = replace(cleaner, r"[ῐῑ]" => "ι")
    cleaner = replace(cleaner, r"[ῠῡ]" => "υ")
    cleaner  = replace(cleaner, "\u3af\u308" => "ΐ")
    cleaner  = replace(cleaner, "\u3cd\u308" => "ΰ")
    cleaner  = replace(cleaner, r"[\u301\u314]" => "")
    cleaner  = replace(cleaner, "Δ\u2eΗ\u2e\u301" => PG.nfkc("δῃ"))

    cleaner
end


"""Find entries with invalid orthography.
$(SIGNATURES)
"""
function invalidortho(cexdir)
    badlist = []
    ortho = literaryGreek()
    v = Vector{MorphData}()
    for i in collect(1:27)
        f = joinpath(cexdir, "morphdata_$(i).cex")
        mdata = readlines(f)[2:end] .|> morphData
        @info("Analyzing $(length(mdata)) records from $(f)")
        for (i,m) in enumerate(mdata)
            if i % 100 == 0
                #@info("$(i)...")
            end
            
            if ! validstring(m.label, ortho)
                if ! validstring(tidier(m.label), ortho)
                    push!(badlist, m)
                end
            end
        end
    end
    badlist
end