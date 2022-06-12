```@setup overview
repo = pwd() |> dirname |> dirname
```


# LSJMining: overview

> Quarry morphological data from the Perseus edition of Liddell-Scott-Jones, *Greek Lexicon*.


## Data in this repository


### Source

The `LSJMining` package takes it XML data from Giuseppe Celano's conversion of beta-code Greek in the Perseus Liddell-Scott-Jones *Greek Lexicon* to Unicode Greek, available [here](https://github.com/gcelano/LSJ_GreekUnicode).  

### Organization

- files in the directory `sourcedata` contain TEI `entryFree` elements  from the Perseus LSJ, formatted with one entry per line.
- files in the `cex` directory named `morphdata_*.cex` are delimited-text files with morphological data extracted from Perseus LSJ using the package [LexiconMining](https://neelsmith.github.io/LexiconMining.jl/stable/).  The `morphdata_*.cex` files are created from hints in the TEI markup to identify seven items: a unique identifier, a tidied-up label, the lemma string in the lexicon, a part of speech, an inflectional type, a genitive form for nouns, and a mood for verbs.  (The latter is not extracted from the LSJ markup, and is always an empty string in this repository.)


###  License

The data here are available under vesion 4.0 of the [Creative Commons BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/).




## Code

The goal of this package is to construct a morphological lexicon formatted for use with [Kanones](https://neelsmith.github.io/Kanones.jl/stable/).

The `kanones` function morphological data from this repository, and writes tables of stems data formatted for Kanones in a target directory.  It consults a specified clone of the `Kanones.jl` repository to filter out stems for any lexemes already defined in the core datasets included in `Kanones.jl`.  


The `kanonesdata/lsjx` directory contains the current output of the `kanones` function. It is created by cloning the `Kanones.jl` repository  in an adjacent directory, and executing the following lines:

```
using LSJMining

src = "cex"
target = joinpath(pwd(), "kanonesdata","lsjx")
kroot = joinpath("..","greek2021","Kanones.jl")

kanones(src, target, kroot)
```



### Other things you can do

If you want to work directly with the extracted morphological data, you can read the `cex` directory's files into a vector of `MorphData` objects.

```@example overview
using LSJMining
cexdir = joinpath(repo, "cex")
morph = loadmorphdata(cexdir)
```


## Other material in this repository

-  `scripts`: some Julia scripts for managing data in this repository