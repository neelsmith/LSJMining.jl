# LSJMining

Quarry morphological data from Perseus edition of Liddell-Scott-Jones *Greek Lexicon*.

Overview of repository's contents:

- `cex`: `morphdata_*.cex` are delimited-text files with morphological data extracted from Perseus LSJ
- `kanonesdata`: morphological stems for use with Kanones
- `sourcedata`: extracted TEI `entryFree` elements from Perseus LSJ, one per line
-  `scripts`: Julia scripts for managing data in this repository

## Some things you can do


### Read in a vector of morphological data

Read the contents of the repository's `cex` directory into `MorphData` objects, while using data in a copy of the `Kanones.jl` repository to filter for valid lexical ids.

```
morph = loadmorphdata(cexdir, kroot = joinpath("..", "Kanones.jl"))
 ```

 The vector `morph` should have around 110,000 `MorphData` objects.


 ### Write Kanones stem files

 Everything `LSJMining` knows about:

 ```
 kanones(src, target, kroot)
 ```


