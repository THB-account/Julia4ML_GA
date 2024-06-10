using Random
using Julia4ML_GA
using Test

function test_rosenbrock()
    # https://en.wikipedia.org/wiki/Rosenbrock_function
    # rosenbrock funktion for a = 1 and b = 100
    # global minimum (x,y) at (a,a**2)
    # solution is (1,1)

    result = Julia4ML_GA.optimize(
        Float64[0.,0.],
        x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2,
        Julia4ML_GA.GeneticAlgorithm();
        iterations=100
    )

    @test isapprox(result, [[1.,1.]], atol=0.1)
end
@testset "entire run trough" begin
    test_rosenbrock()
end

#@testset "knapsack" begin
#    mass    = [1, 5, 3, 7, 2, 10, 5]
#    utility = [1, 3, 5, 2, 5,  8, 3]
#
#    fitnessFun = n -> (sum(mass .* n) <= 20) ? sum(utility .* n) : 0
#    
#    initpop = [true, false, true, false, true, false, true]
#    result = Julia4ML_GA.optimize(
#        initpop,
#        x -> -fitnessFun(x),
#        Julia4ML_GA.GeneticAlgorithm();
#        iterations=100
#    );
#
#    @test abs(Evolutionary.minimum(result)) == 21.
#    @test sum(mass .* Evolutionary.minimizer(result)) <= 20
#end