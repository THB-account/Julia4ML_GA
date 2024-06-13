using Random
using Julia4ML_GA
using Test

@testset "Selection" begin
	rng = Random.default_rng(42)

	@testset "Roulette" begin
		Random.seed!(rng, 2)
		@test roulette_wheel([24, 2, 6, -3, 5], 2, rng) == [1, 1]
		Random.seed!(rng, 2)
		@test roulette_wheel([-4, -2, 0, -3, -5], 3, rng) == [1, 5, 5]
	end	

	@testset "Tounament" begin
		Random.seed!(rng, 2)
		@test tournament_selection([3, 1, -4, 7, 4, 2, 9], 3, 4, rng) == [7, 4, 1]
	end
end 