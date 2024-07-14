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
        rng = Random.default_rng()

        populationSize = 1000
        initPop = Julia4ML_GA.init_gaussian(populationSize, Float64[0.,0.], rng)

        result = Julia4ML_GA.optimize(
            initPop,
            x -> (1-x[1])^2 +100*(x[2]-x[1]^2)^2,
            Julia4ML_GA.GeneticAlgorithm(
                populationSize=populationSize,
            selection=Julia4ML_GA.roulette_wheel_inv,
            mutation=Julia4ML_GA.gaussian_noise,
            crossover=Julia4ML_GA.k_point
            );
            iterations=100,
            rng=rng
        )

        @test isapprox(Julia4ML_GA.argmin(result), [[1.,1.]], atol=0.1)
    end

    @testset "rosenbrock solution: (-4, 16) uniform_noise" begin
        best_solution = Julia4ML_GA.solve_rosenbrock(-4, 100, starting_point=Float32[1.,1.], mutation=Julia4ML_GA.uniform_noise)
        @test isapprox(best_solution, [-4.,16.], atol=0.9)
    end
end
