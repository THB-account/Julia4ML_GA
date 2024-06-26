module Julia4ML_GA

using Dates
using Logging
using Random: MersenneTwister, default_rng,seed!, shuffle
# Write your package code here.

include("api/types.jl")
include("api/objective.jl")

include("crossover.jl")
include("mutation.jl")
include("selection.jl")
include("initialization.jl")
include("ga.jl")
include("api/optimize.jl")
include("api/utils.jl")
include("termination.jl")

include("examples/tsp.jl")
include("examples/sudoku.jl")
include("examples/knapsack.jl")
include("examples/rosenbrock.jl")

export 
roulette_wheel, 
roulette_wheel_inv,
tournament_selection,
rank_selection,
displacement, 
k_point, 
partially_mapped,
gaussian_displacement, 
univariate_displacement,
bit_inversion,
init_gaussian,
init_uniform_binary_population,
terminate,
solve_knapsack,
solve_rosenbrock,
solve_sudoku,
solve_tsp
end
