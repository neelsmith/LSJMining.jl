
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

"""Load morphology data from files in `cex` directory
of repository, and filter for entries with valid orthography
only.
$(SIGNATURES)
"""
function loadmorphdata(cexdir)
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
            else
                @warn("Invalid string:", m.label)
            end
        end
    end
    v
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
        for (i,m) in enumerate(mdata)
            if i % 100 == 0
                @info("$(i)...")
            end
            if ! validstring(m.label, ortho)
                push!(badlist, m)
            end
        end
    end
    badlist
end