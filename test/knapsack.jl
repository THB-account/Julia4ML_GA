using Random:default_rng
using Julia4ML_GA
using Test

@testset "knapsack" begin
    rng = default_rng()

    mass    = [1, 5, 3, 7, 2, 10, 5, 9, 2]
    utility = [1, 3, 5, 2, 5,  8, 3, 9, 5]

    fitnessFun = n -> (sum(mass .* n) <= 30) ? sum(utility .* n) : 0.001
    
    initpop = init_uniform_binary_population(50, 9)
    result = Julia4ML_GA.optimize(
        initpop,
        x -> -fitnessFun(x),
        Julia4ML_GA.GeneticAlgorithm(
            populationSize=50,
            selection=roulette_wheel,
            mutation=bit_inversion
        );
        iterations=30,
        rng=rng
    );

    @test sum(Julia4ML_GA.argmin(result)[1] .* utility) >= 30.
    @test sum(Julia4ML_GA.argmin(result)[1] .* mass) <= 30.
end
