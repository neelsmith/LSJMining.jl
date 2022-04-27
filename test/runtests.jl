using LSJMining
using PolytonicGreek
using Test

@testset "Test finding noun accent patterns" begin
    
    @test LSJMining.accenttype("ὠψά") == "inflectionaccented"
    @test LSJMining.accenttype("ὠχροσύνη") == "stemaccented"
    @test LSJMining.accenttype("ὠχρόξανθος") == "recessive"
end