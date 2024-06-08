using Random
using Julia4ML_GA

@testset "entire run trough" begin
    Julia4ML_GA.optimize(Float64[0.,0.],x->(1-x[1])^2 +100*(x[2]-x[1]^2)^2,Julia4ML_GA.GeneticAlgorithm();iterations=100)
end