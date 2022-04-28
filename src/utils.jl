
function adjstemsdir(target)
    if ! isdir(joinpath(target, "stems-tables"))
        mkdir(joinpath(target, "stems-tables"))
    end
    if !isdir(joinpath(target, "stems-tables", "adjectives"))
        mkdir(joinpath(target, "stems-tables", "adjectives"))
    end
end



function nounstemsdir(target)
    if ! isdir(joinpath(target, "stems-tables"))
        mkdir(joinpath(target, "stems-tables"))
    end
    if !isdir(joinpath(target, "stems-tables", "nouns"))
        mkdir(joinpath(target, "stems-tables", "nouns"))
    end
end


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
