# Contents of test/runtests.jl
using Julia4ML_GA
using Test

@testset "Julia4ML_GA.jl" begin
    # Write your tests here.
    include("logging.jl")
    include("other.jl")    

    include("examples/rosenbrock.jl")
    include("examples/knapsack.jl")
    include("examples/sudoku.jl")
    include("examples/tsp.jl")

    include("crossover.jl")
    include("mutation.jl")
    include("selection.jl")
end