# Load `v`, then
lbls = map(m -> m.label,v)
chlist = split(join(lbls,""),"") |> unique |> sort

open("chlist.txt","w") do io
    write(io, join(chlist,"\n"))
end