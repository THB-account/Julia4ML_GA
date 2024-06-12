using Random
using Julia4ML_GA
using Test

@testset "entire run trough" begin
    # https://en.wikipedia.org/wiki/Rosenbrock_function
    # rosenbrock funktion for a = 1 and b = 100
    # global minimum (x,y) at (a,a**2)
    # solution is (1,1)
    populationSize = 50
    rng = Random.default_rng()
    initPop = init_gaussian(Float64[0.,0.], populationSize, rng)

    result = Julia4ML_GA.optimize(
        initPop,
        x -> -((1-x[1])^2 +100*(x[2]-x[1]^2)^2),
        Julia4ML_GA.GeneticAlgorithm(
            populationSize=populationSize,
            eliteSize=20
        );
        iterations=100,
        rng=rng
    )

    @test isapprox(result, [[1.,1.]], atol=0.1)
end

@testset "knapsack" begin
    mass    = [1, 5, 3, 7, 2, 10, 5, 9, 2]
    utility = [1, 3, 5, 2, 5,  8, 3, 9, 5]

    fitnessFun = n -> (sum(mass .* n) <= 30) ? sum(utility .* n) : 0
    
    initpop = init_uniform_binary_population(50, 9)
    result = Julia4ML_GA.optimize(
        initpop,
        x -> fitnessFun(x),
        Julia4ML_GA.GeneticAlgorithm(
            populationSize=50
        );
        iterations=100
    );

    @test sum(result[1] .* utility) >= 30.
    @test sum(result[1] .* mass) <= 30.
end