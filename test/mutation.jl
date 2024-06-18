using Random
using Julia4ML_GA
using Test

@testset "mutation" begin
    @testset "Displacement" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 7)
        @test displacement([1, 2, 3, 4, 5], rng) == [1, 5, 2, 3, 4]
        Random.seed!(rng, 2)
		@test displacement([1, 2, 3, 4, 5], rng) == [5, 1, 2, 3, 4]
	end	

    @testset "Displacement: Test length" begin
        rng = Random.default_rng()
        number_of_runs = 10
        for i in 1:number_of_runs
            length_genes = i
            genes = [i for i in 1:length_genes]

            mutated = displacement(genes, rng)

            # println("genes ", genes)
            # println("mutated ", mutated)
            
            # Test length
            @test length(mutated) == length(genes) && sum(genes) == sum(mutated)
        end
    end
end