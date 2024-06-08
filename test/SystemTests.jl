using Random
using Julia4ML_GA

@testset "entire run trough" begin
    # https://en.wikipedia.org/wiki/Rosenbrock_function
    # rosenbrock funktion for a = 1 and b = 100
    # global minimum (x,y) at (a,a**2)
    # solution is (1,1)
    @test isapprox( Julia4ML_GA.optimize(Float64[0.,0.],x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2,Julia4ML_GA.GeneticAlgorithm();iterations=100), [1.,1.], atol=0.05)
end