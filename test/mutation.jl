using Random
using Julia4ML_GA
using Test

@testset "mutation" begin
    rng = Random.default_rng()

    @testset "Displacement" begin
		Random.seed!(rng, 2)
		#@test displacement([24, 2, 6, -3, 5], rng) == [5, 24, 2, 6, -3]
	end	

    @testset "Displacement: Test length" begin
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