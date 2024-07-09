# Contents of test/runtests.jl
import Julia4ML_GA
import Random
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
    include("termination_criteria.jl")
end