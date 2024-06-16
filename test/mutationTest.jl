using Random
using Julia4ML_GA
using Test

@testset "mutation" begin
    @testset "displacement" begin
        rng = Random.default_rng()

        #rng = MersenneTwister(1234);
        number_of_runs = 10
        for i in 1:number_of_runs
            length_genes = i
            genes = [i for i in 1:length_genes]

            mutated = displacement(genes, rng)
            
            # Test length
            @test length(mutated) == length(genes)

            #println(genes)
            #println(mutated)
        end
    end
end