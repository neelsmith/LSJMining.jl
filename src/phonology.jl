breathingstripdict = Dict(
       'ἀ'  => 'α',
       'ἁ' => 'α',
       'ἄ' => 'ά',
       'ἅ' => 'ά',

       'ἐ'  => 'ε',
       'ἑ' => 'ε',
       'ἔ' => 'έ',
       'ἕ' => 'έ',


       'ἰ'  => 'ι',
       'ἱ' => 'ι',
       'ἴ' => 'ί',
       'ἵ' => 'ί',


       'ὀ'  => 'ο',
       'ὁ' => 'ο',
       'ὄ' => 'ό',
       'ὅ' => 'ό',


       'ὐ' => 'υ',
       'ὑ'  => 'υ',
       'ὔ' => 'ύ',
       'ὕ' => 'ύ',


       'ἠ'  => 'η',
       'ἡ' => 'η',
       'ἤ' => 'ή',
       'ἥ' => 'ή',

       'ὠ'  => 'ω',
       'ὡ' => 'ω',
       'ὤ' => 'ώ',
       'ὥ' => 'ώ'
    )


function stripbreathing(s)
    if s[1] in keys(breathingstripdict)
        chs = []
        push!(chs, breathingstripdict[s[1]])
        for i in eachindex(s)
            if i > 1
                push!(chs,s[i])
            end
        end    
        join(chs)
    else
        s
    end
end