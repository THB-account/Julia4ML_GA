using Random
using Julia4ML_GA
using Test

@testset "Selection" begin
	@testset "Roulette" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 2)
		@test roulette_wheel([24, 2, 6, -3, 5], 2, rng) == [1, 3]
		Random.seed!(rng, 2)
		@test roulette_wheel([-4, -2, 0, -3, -5], 3, rng) == [1, 5, 5]
	end	

	@testset "Tounament" begin
        rng = Random.Xoshiro()
		Random.seed!(rng, 2)
		@test tournament_selection([3, 1, -4, 7, 4, 2, 9], 3, 4, rng) == [6, 2, 6]
	end

	@testset "Roulette wheel: Test length" begin
        rng = Random.default_rng()

        selection_number = 10
        number_of_runs = 10
        for i in 1:number_of_runs
            length_fitness = i
            fitness = [rand() for i in 1:length_fitness]

            selected_indices = roulette_wheel(fitness, selection_number, rng)
            
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

            selected_indices = roulette_wheel_inv(fitness, selection_number, rng)
            
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