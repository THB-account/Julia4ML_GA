import Random
import Julia4ML_GA

@testset "mutation" begin
    @testset "Bit Inversion" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 7)
        @test Julia4ML_GA.bit_inversion([true, true, true, true, true], rng) == [true, true, true, false, true]
        Random.seed!(rng, 13)
		@test (Julia4ML_GA.bit_inversion([true, true, true, true, true, false, false, false, false, false], rng) == 
            [true, true, false, true, true, false, false, false, false, false])
	end

    @testset "Displacement" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 7)
        @test Julia4ML_GA.displacement([1, 2, 3, 4, 5], rng) == [1, 2, 4, 3, 5]
        Random.seed!(rng, 2)
		@test Julia4ML_GA.displacement([1, 2, 3, 4, 5], rng) == [4, 5, 1, 2, 3]
	end	

    @testset "Displacement: Test length" begin
        rng = Random.default_rng()
        number_of_runs = 10
        for i in 1:number_of_runs
            length_genes = i
            genes = [i for i in 1:length_genes]

            mutated = Julia4ML_GA.displacement(genes, rng)

            # println("genes ", genes)
            # println("mutated ", mutated)
            
            # Test length
            @test length(mutated) == length(genes) && sum(genes) == sum(mutated)
        end
    end
end