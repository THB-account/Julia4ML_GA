import Random
import Julia4ML_GA

@testset "mutation" begin
    @testset "Bit Inversion" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 2)
        @test Julia4ML_GA.bit_inversion([true, true, true, true, true], rng) == [false, true, true, true, true]
        Random.seed!(rng, 13)
		@test (Julia4ML_GA.bit_inversion([true, true, true, true, true, false, false, false, false, false], rng) == 
            [true, true, true, false, true, false, false, false, true, false])
	end

    @testset "Displacement" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 7)
        @test Julia4ML_GA.displacement([1, 2, 3, 4, 5], rng) == [1, 5, 2, 3, 4]
        Random.seed!(rng, 2)
		@test Julia4ML_GA.displacement([1, 2, 3, 4, 5], rng) == [5, 1, 2, 3, 4]
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