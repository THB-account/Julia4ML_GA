module Julia4ML_GA

using Random: MersenneTwister, default_rng,seed!
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

export 
roulette_wheel, 
roulette_wheel_inv,
tournament_selection,
rank_selection,
displacement, 
single_point, 
gaussian_displacement, 
univariate_displacement,
bit_inversion,
init_gaussian,
init_uniform_binary_population

end
