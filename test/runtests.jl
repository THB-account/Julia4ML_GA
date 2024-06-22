# Contents of test/runtests.jl
using Julia4ML_GA
using Test

@testset "Julia4ML_GA.jl" begin
    # Write your tests here.
    include("logging.jl")
    include("other.jl")    

    include("rosenbrock.jl")
    include("knapsack.jl")
    include("sudoku.jl")

    include("crossover.jl")
    include("mutation.jl")
    include("selection.jl")
end