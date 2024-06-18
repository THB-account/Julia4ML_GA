import Random
import Julia4ML_GA

@testset "Selection" begin
    @testset "Rank" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 13)
		@test Julia4ML_GA.rank_selection([24, 2, 6, -3, 5], 20, rng) == [6, -3, -3, 6, 2, -3, 2, -3, 6, 2, -3, 2, -3, 5, 6, -3, 2, -3, 6, 2]
    end

	@testset "Roulette" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 2)
		@test Julia4ML_GA.roulette_wheel([24, 2, 6, 3, 5], 20, rng) == [1, 3, 3, 4, 1, 4, 3, 1, 3, 3, 5, 3, 5, 2, 1, 1, 1, 1, 1, 4]
		Random.seed!(rng, 2)
		@test Julia4ML_GA.roulette_wheel([-4, -2, -20, -3, -5], 20, rng) == [1, 3, 3, 4, 3, 5, 3, 3, 3, 3, 5, 3, 5, 3, 3, 3, 3, 3, 1, 4]
	end	

	@testset "Tounament" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 2)
		@test Julia4ML_GA.tournament_selection([3, 1, -4, 7, 4, 2, 9], 3, 4, rng) == [6, 2, 6]
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