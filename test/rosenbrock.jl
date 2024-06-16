using Random
using Julia4ML_GA
using Test

@testset "rosenbrock" begin
    @testset "rosenbrock (1,1)" begin
        # https://en.wikipedia.org/wiki/Rosenbrock_function
        # rosenbrock funktion for a = 1 and b = 100
        # global minimum (x,y) at (a,a**2)
        # solution is (1,1)
        rng = Random.default_rng()

        populationSize = 1000
        initPop = init_gaussian(Float64[0.,0.], populationSize, rng)

        result = Julia4ML_GA.optimize(
            initPop,
            x -> (1-x[1])^2 +100*(x[2]-x[1]^2)^2,
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=populationSize,
            selection=roulette_wheel_inv,
            mutation=gaussian_displacement
            );
            iterations=100,
            rng=rng
        )

        @test isapprox(result, [[1.,1.]], atol=0.1)
    end

    @testset "rosenbrock (4,16) gaussian_displacement" begin
        # global minimum (x,y) at (a,a**2)
        # solution is (4,16)
        rng = Random.default_rng()

        populationSize = 1000
        initPop = init_gaussian(Float64[0.,0.], populationSize, rng)

        result = Julia4ML_GA.optimize(
            initPop,
            x -> (4-x[1])^2 +100*(x[2]-x[1]^2)^2,
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=populationSize,
                selection=roulette_wheel_inv,
                mutation=gaussian_displacement
            );
            iterations=1000,
            rng=rng
        )

        #println(result)

        @test isapprox(result, [[4.,16.]], atol=0.5)
    end

    @testset "rosenbrock (4,16) univariate_displacement" begin
        # global minimum (x,y) at (a,a**2)
        # solution is (4,16)
        rng = Random.default_rng()

        populationSize = 1000
        initPop = init_gaussian(Float64[0.,0.], populationSize, rng)

        result = Julia4ML_GA.optimize(
            initPop,
            x -> (4-x[1])^2 +100*(x[2]-x[1]^2)^2,
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=populationSize,
                selection=roulette_wheel_inv,
                mutation=univariate_displacement
            );
            iterations=1000,
            rng=rng
        )

        #println(result)

        @test isapprox(result, [[4.,16.]], atol=0.5)
    end
end