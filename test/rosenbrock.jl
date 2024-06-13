using Random
using Julia4ML_GA
using Test

@testset "rosenbrock" begin
    # https://en.wikipedia.org/wiki/Rosenbrock_function
    # rosenbrock funktion for a = 1 and b = 100
    # global minimum (x,y) at (a,a**2)
    # solution is (1,1)
    rng = Random.default_rng()
    Random.seed!(rng, 2)

    populationSize = 1000
    initPop = init_gaussian(Float64[0.,0.], populationSize, rng)

    result = Julia4ML_GA.optimize(
        initPop,
        x -> (1-x[1])^2 +100*(x[2]-x[1]^2)^2,
        Julia4ML_GA.GeneticAlgorithm(
            populationSize=populationSize,
	    selection=roulette_wheel_inv
        );
        iterations=100,
        rng=rng
    )

    @test isapprox(result, [[1.,1.]], atol=0.1)
end