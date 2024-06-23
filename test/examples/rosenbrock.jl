using Random:default_rng
using Julia4ML_GA
using Test

@testset "rosenbrock" begin
    @testset "rosenbrock solution: (4, 16) default" begin
        best_solution = Julia4ML_GA.solve_rosenbrock(4, 100)
        @test isapprox(best_solution, [4.,16.], atol=0.5)
    end

    @testset "rosenbrock solution: (1,1) complete" begin
        # https://en.wikipedia.org/wiki/Rosenbrock_function
        # rosenbrock funktion for a = 1 and b = 100
        # global minimum (x,y) at (a,a**2)
        # solution is (1,1)
        rng = default_rng()

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

        @test isapprox(Julia4ML_GA.argmin(result), [[1.,1.]], atol=0.1)
    end

    @testset "rosenbrock solution: (-4, 16) univariate_displacement" begin
        best_solution = Julia4ML_GA.solve_rosenbrock(-4, 100, mutation=univariate_displacement)
        @test isapprox(best_solution, [-4.,16.], atol=0.5)
    end
end
