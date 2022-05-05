
# 356 numi verbs
# Load morph data in `v`, then:
 numis = filter(m -> endswith(m.label,"νυμι"),  v )

map(m -> replace(m.label, r"νυμι$" => "")[end],  numis) |> unique


#= Results:
 'γ': Unicode U+03B3 (category Ll: Letter, lowercase)
 'ν': Unicode U+03BD (category Ll: Letter, lowercase)
 'κ': Unicode U+03BA (category Ll: Letter, lowercase)
 'μ': Unicode U+03BC (category Ll: Letter, lowercase)
 'ί': Unicode U+03AF (category Ll: Letter, lowercase)
 'ἵ': Unicode U+1F35 (category Ll: Letter, lowercase)
 'ρ': Unicode U+03C1 (category Ll: Letter, lowercase)
 =#