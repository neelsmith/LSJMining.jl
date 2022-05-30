# Load morphology data into v


for k in keys(LSJMining.stemiddict)
    compounds = filter(m -> endswith(m.lemma, k),  v)
    println(k, ": ", length(compounds), " for ", LSJMining.xscriptdict[k], " with key ", LSJMining.stemiddict[k])
end