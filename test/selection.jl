import Random
import Julia4ML_GA

@testset "Selection" begin
    @testset "Rank" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 13)
		@test Julia4ML_GA.rank_selection([24, 2, 6, -3, 5], 20, rng) == [4, 4, 3, 4, 2, 2, 4, 4, 4, 4, 4, 3, 3, 1, 2, 3, 4, 5, 2, 4]
        Random.seed!(rng, 7)
		@test Julia4ML_GA.rank_selection([24, 2, 6, -3, 5, 7, 10, 10], 20, rng) == [4, 2, 5, 7, 5, 6, 6, 6, 4, 2, 3, 2, 5, 4, 5, 4, 3, 2, 2, 2]
    end

	@testset "Roulette" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 2)
		@test Julia4ML_GA.roulette_wheel([24, 2, 6, 3, 5], 20, rng) == [1, 1, 1, 4, 1, 1, 1, 1, 1, 3, 1, 3, 1, 3, 3, 1, 3, 1, 3, 1]
		Random.seed!(rng, 2)
		@test Julia4ML_GA.roulette_wheel([-4, -2, -20, -3, -5], 20, rng) == [3, 3, 3, 4, 3, 3, 3, 3, 3, 3, 2, 3, 1, 4, 3, 3, 3, 3, 3, 2]
	end	

	@testset "Tounament" begin
        rng = Random.MersenneTwister()
		Random.seed!(rng, 2)
		@test Julia4ML_GA.tournament_selection([3, 1, -4, 7, 4, 2, 9], 3, 4, rng) == [3, 2, 3]
	end

	@testset "Roulette wheel: Test length" begin
        rng = Random.default_rng()

        selection_number = 10
        number_of_runs = 10
        for i in 1:number_of_runs
            length_fitness = i
            fitness = [rand() for i in 1:length_fitness]

            selected_indices = Julia4ML_GA.roulette_wheel(fitness, selection_number, rng)
            
            # Test length
            @test length(selected_indices) == selection_number

            #println(fitness)
            #println(selected_indices)

            for (index, element) in enumerate(selected_indices)
                @test element >= 1 && element <= length_fitness
            end
        end
    end

    @testset "Roulette wheel inv: Test length" begin
        rng = Random.default_rng()

        selection_number = 10
        number_of_runs = 10
        for i in 1:number_of_runs
            length_fitness = i
            fitness = [rand() + 0.001 for i in 1:length_fitness]  # + 0.001 to prevent 0

            selected_indices = Julia4ML_GA.roulette_wheel_inv(fitness, selection_number, rng)
            
            # Test length
            @test length(selected_indices) == selection_number

            #println(fitness)
            #println(selected_indices)

            for (index, element) in enumerate(selected_indices)
                @test element >= 1 && element <= length_fitness
            end
        end
    end
end 