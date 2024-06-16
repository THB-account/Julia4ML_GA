# Contents of test/runtests.jl
using Julia4ML_GA
using Test

@testset "Julia4ML_GA.jl" begin
    # Write your tests here.
    include("rosenbrock.jl")
    include("knapsack.jl")
    include("crossoverTest.jl")
    include("mutationTest.jl")
end